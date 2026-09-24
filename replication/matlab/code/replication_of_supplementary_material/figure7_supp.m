clear all
repl_root=fullfile(fileparts(mfilename('fullpath')),'..','..');
if isempty(fileparts(mfilename('fullpath'))), repl_root=fullfile(pwd,'..','..'); end
addpath(fullfile(repl_root,'code','functions'),fullfile(repl_root,'data'),fullfile(repl_root,'reports','results'),fullfile(repl_root,'code','replication_of_submission'));
close all
clc


mc=xlsread('results.xls','figure7_supp');

fig = figure('Visible', 'off', 'Position', [100 100 900 700]);

subplot(3,2,1)
bar(mc(:,1))
set(gca,'XTick',1:5)
set(gca,'XTickLabel',{'g=0.05','g=0.50','g=5.00','g=50.00','g=100.00'})
xlabel('Prior hyperparameter value'); ylabel('TU');
ylim([0.90, 1.00]);
title('(a): 1990m1-2024m12 out-of-sample period.');

subplot(3,2,2)
bar(mc(:,2))
set(gca,'XTick',1:5)
set(gca,'XTickLabel',{'g=0.05','g=0.50','g=5.00','g=50.00','g=100.00'})
xlabel('Prior hyperparameter value'); ylabel('TU');
ylim([0.90, 1.00]);
title('(b): 1990m1-2019m12 out-of-sample period.');

subplot(3,2,3)
bar(mc(:,3))
set(gca,'XTick',1:5)
set(gca,'XTickLabel',{'g=0.05','g=0.50','g=5.00','g=50.00','g=100.00'})
xlabel('Prior hyperparameter value'); ylabel('CW p-value');
ylim([0.00, 0.15]);
title('(c): 1990m1-2024m12 out-of-sample period.');

subplot(3,2,4)
bar(mc(:,4))
set(gca,'XTick',1:5)
set(gca,'XTickLabel',{'g=0.05','g=0.50','g=5.00','g=50.00','g=100.00'})
xlabel('Prior hyperparameter value'); ylabel('CW p-value');
ylim([0.00, 0.15]);
title('(d): 1990m1-2019m12 out-of-sample period.');

subplot(3,2,5)
bar(mc(:,5))
set(gca,'XTick',1:5)
set(gca,'XTickLabel',{'g=0.05','g=0.50','g=5.00','g=50.00','g=100.00'})
xlabel('Prior hyperparameter value'); ylabel('DM p-value');
ylim([0.00, 0.15]);
title('(e): 1990m1-2024m12 out-of-sample period.');

subplot(3,2,6)
bar(mc(:,6))
set(gca,'XTick',1:5)
set(gca,'XTickLabel',{'g=0.05','g=0.50','g=5.00','g=50.00','g=100.00'})
xlabel('Prior hyperparameter value'); ylabel('DM p-value');
ylim([0.00, 0.15]);
title('(f): 1990m1-2019m12 out-of-sample period.');

out_dir = fullfile(repl_root, 'reports', 'plots');
set(fig, 'PaperPositionMode', 'auto');
saveas(fig, fullfile(out_dir, 'figure7_supp_reproduced.png'));
saveas(fig, fullfile(out_dir, 'figure7_supp_reproduced.fig'));
close(fig);