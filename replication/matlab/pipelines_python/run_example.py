import time
from pathlib import Path

import matlab.engine

MATLAB_ROOT = Path(__file__).resolve().parents[1]


class ExampleReplicationRunner:
    def run(self):
        sessions = matlab.engine.find_matlab()
        if not sessions:
            print('No active MATLAB engine sessions found')
            return
        eng = matlab.engine.connect_matlab(sessions[0])
        eng.cd(str(MATLAB_ROOT / 'code' / 'replication_of_submission'), nargout=0)

        print('Executing main_example.m for predictor k=4 (Petroleum tracker)...')
        t0 = time.time()
        eng.eval('main_example', nargout=0)
        print(f'main_example.m completed in {time.time() - t0:.2f} seconds')

        print('Running figure1_computation_example.m...')
        eng.eval('figure1_computation_example', nargout=0)
        mquant = eng.workspace['mquant']
        print(f'Generated mquant row 4: {mquant}')


if __name__ == '__main__':
    ExampleReplicationRunner().run()
