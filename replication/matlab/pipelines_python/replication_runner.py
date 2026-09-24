import os
import subprocess
import time
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime
from pathlib import Path

import numpy as np
import pandas as pd
import yaml

MATLAB_ROOT = Path(__file__).resolve().parents[1]
CONFIG_PATH = Path(__file__).resolve().parent / 'replication_runs.yaml'


class ReplicationRunner:
    def __init__(self, config_path: Path = CONFIG_PATH):
        self.config = yaml.safe_load(config_path.read_text())
        self.code_root = MATLAB_ROOT / self.config['code_dir']
        self.plots_dir = MATLAB_ROOT / self.config['plots_dir']
        self.timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        self.run_dir = MATLAB_ROOT / self.config['output_dir'] / f'replication_run_{self.timestamp}'
        self.run_dir.mkdir(parents=True, exist_ok=True)

    def run(self):
        producer_log = self._run_phase(self.config['producers'], self._producer_command)
        computation_log = self._run_phase(self.config['computations'], self._computation_command)
        figure_log = self._run_phase(self.config['figures'], self._figure_command)
        self._run_matlab('export_references', self._reference_png_command(), {})
        pd.DataFrame(producer_log + computation_log + figure_log).to_csv(self._output_path('jobs'), index=False)
        cells = self._compare_all()
        cells.to_csv(self._output_path('cells'), index=False)
        flips = cells[cells['conclusion_flip']]
        flips.to_csv(self._output_path('conclusion_flips'), index=False)
        summary = self._summarise(cells)
        summary.to_csv(self._output_path('summary'), index=False)
        print(summary.to_string(index=False))
        print(f'{len(flips)} conclusion flips out of {int(cells["stat"].notna().sum())} classified cells')
        print(f'Outputs written to {self.run_dir}')

    def _output_path(self, label: str) -> Path:
        return self.run_dir / f'replication_{label}_{self.timestamp}.csv'

    def _run_phase(self, jobs: list, command_builder) -> list:
        with ThreadPoolExecutor(max_workers=self.config['max_workers']) as pool:
            futures = [pool.submit(self._run_matlab, job['name'], command_builder(job), job.get('env', {})) for job in jobs]
            return [future.result() for future in futures]

    def _run_matlab(self, name: str, command: str, env_overrides: dict) -> dict:
        env = os.environ.copy()
        env.update({f'REPL_{key.upper()}': str(value) for key, value in env_overrides.items()})
        log_path = self.run_dir / 'logs' / f'{name}.log'
        log_path.parent.mkdir(exist_ok=True)
        start = time.time()
        with log_path.open('w') as log:
            result = subprocess.run([self.config['matlab_bin'], '-batch', command], env=env, stdout=log, stderr=subprocess.STDOUT)
        elapsed = time.time() - start
        print(f'{name}: exit {result.returncode} in {elapsed:.1f}s', flush=True)
        return {'job': name, 'exit_code': result.returncode, 'seconds': round(elapsed, 1)}

    def _cd_command(self, job: dict) -> str:
        return f"cd('{self.code_root / job['dir']}'); "

    def _producer_command(self, job: dict) -> str:
        return self._cd_command(job) + f"{job['script']};"

    def _computation_command(self, job: dict) -> str:
        capture = job.get('capture', 'mquant')
        csv_path = self.run_dir / 'captures' / f"{job['name']}.csv"
        csv_path.parent.mkdir(exist_ok=True)
        return self._cd_command(job) + f"evalc('{job['script']}'); repl_out={capture}; writematrix(repl_out,'{csv_path}');"

    def _figure_command(self, job: dict) -> str:
        png_path = self.plots_dir / job['output']
        return self._cd_command(job) + f"set(0,'DefaultFigureVisible','off'); evalc('{job['script']}'); saveas(gcf,'{png_path}');"

    def _reference_png_command(self) -> str:
        fig_dir = (MATLAB_ROOT / self.config['reference_figs']).resolve()
        return f"d=dir(fullfile('{fig_dir}','*.fig')); for i=1:numel(d), f=openfig(fullfile(d(i).folder,d(i).name),'invisible'); [~,s]=fileparts(d(i).name); saveas(f,fullfile('{self.plots_dir}',[s '_reference.png'])); close(f); end"

    def _compare_all(self) -> pd.DataFrame:
        sheets = pd.read_excel(MATLAB_ROOT / self.config['results_file'], sheet_name=None, header=None)
        frames = [self._compare_job(job, sheets[job['sheet']]) for job in self.config['computations']]
        cells = pd.concat([frame for frame in frames if frame is not None], ignore_index=True)
        cells['stat'] = [self._stat_type(sheet, col) for sheet, col in zip(cells['sheet'], cells['col'])]
        cells['conclusion_flip'] = [self._flips(stat, ref, rep) for stat, ref, rep in zip(cells['stat'], cells['reference'], cells['reproduced'])]
        return cells

    def _compare_job(self, job: dict, sheet: pd.DataFrame) -> pd.DataFrame | None:
        csv_path = self.run_dir / 'captures' / f"{job['name']}.csv"
        if not csv_path.exists():
            print(f"{job['name']}: no capture, skipped in comparison")
            return None
        captured = np.atleast_2d(pd.read_csv(csv_path, header=None).to_numpy(dtype=float))
        src_cols = [col - 1 for col in job['src_cols']]
        dst_cols = [col - 1 for col in job['dst_cols']]
        dst_rows = [row - 1 for row in job['dst_rows']] if 'dst_rows' in job else list(range(captured.shape[0]))
        src_rows = list(range(len(dst_rows))) if 'dst_rows' in job else dst_rows
        reference = sheet.iloc[dst_rows, dst_cols].to_numpy(dtype=float)
        reproduced = captured[np.ix_(src_rows, src_cols)]
        rows, cols = np.meshgrid(np.array(dst_rows) + 1, np.array(dst_cols) + 1, indexing='ij')
        return pd.DataFrame({'job': job['name'], 'sheet': job['sheet'], 'row': rows.ravel(), 'col': cols.ravel(), 'reference': reference.ravel(), 'reproduced': reproduced.ravel(), 'abs_diff': np.abs(reference - reproduced).ravel()})

    def _stat_type(self, sheet: str, col: int) -> str | None:
        columns = self.config['stat_columns'].get(sheet)
        return columns[col - 1] if columns else None

    def _flips(self, stat: str | None, ref: float, rep: float) -> bool:
        if stat in ('tu', 'loss_ratio'):
            return bool((ref < 1) != (rep < 1))
        if stat == 'sharpe':
            return bool((ref > 0) != (rep > 0))
        if stat == 'pval':
            return any((ref < level) != (rep < level) for level in self.config['significance_levels'])
        return False

    def _summarise(self, cells: pd.DataFrame) -> pd.DataFrame:
        tolerance = self.config['tolerance_4dp']
        grouped = cells.groupby('job', sort=False)
        summary = grouped.agg(sheet=('sheet', 'first'), cells=('abs_diff', 'size'), max_abs_diff=('abs_diff', 'max'), mean_abs_diff=('abs_diff', 'mean'), conclusion_flips=('conclusion_flip', 'sum'))
        summary['match_4dp_share'] = grouped['abs_diff'].apply(lambda diff: (diff <= tolerance).mean()).round(3)
        summary['cells_over_1e-3'] = grouped['abs_diff'].apply(lambda diff: int((diff > 1e-3).sum()))
        return summary.reset_index()


if __name__ == '__main__':
    ReplicationRunner().run()
