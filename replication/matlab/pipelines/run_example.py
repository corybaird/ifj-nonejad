from pathlib import Path
import time
import matlab.engine

class ExampleReplicationRunner:
    def run(self):
        sessions = matlab.engine.find_matlab()
        if not sessions:
            print('No active MATLAB engine sessions found')
            return
        eng = matlab.engine.connect_matlab(sessions[0])
        script_dir = str(Path(__file__).resolve().parents[1] / 'replication_of_submission')
        data_dir = str(Path(__file__).resolve().parents[1] / 'data')
        func_dir = str(Path(__file__).resolve().parents[1] / 'functions')
        
        eng.cd(script_dir, nargout=0)
        eng.addpath(data_dir, nargout=0)
        eng.addpath(func_dir, nargout=0)
        
        print('Executing main_example.m for predictor k=4 (Petroleum tracker)...')
        t0 = time.time()
        eng.eval('main_example', nargout=0)
        elapsed = time.time() - t0
        print(f'main_example.m completed in {elapsed:.2f} seconds')
        
        print('Running figure1_computation_example.m...')
        eng.eval('figure1_computation_example', nargout=0)
        mquant = eng.workspace['mquant']
        print(f'Generated mquant row 4: {mquant}')

ExampleReplicationRunner().run()
