clear all
repl_root=fullfile(fileparts(mfilename('fullpath')),'..','..');
if isempty(fileparts(mfilename('fullpath'))), repl_root=fullfile(pwd,'..','..'); end
addpath(fullfile(repl_root,'code','functions'),fullfile(repl_root,'data'),fullfile(repl_root,'reports','results'),fullfile(repl_root,'code','replication_of_submission'));
close all
clc


mc=xlsread('results.xls','figure3_supp');
mc=mc(1:18, :);

fig = figure('Visible', 'off', 'Position', [100 100 800 600]);

subplot(2,2,1)
scatter(mc(:,1),mc(:,2), 50, 'b', 'filled')   
hold on
plot([1,1],[0, 1.0], 'k:')
plot(xlim,[0.1,0.1], 'k--', 'LineWidth', 2)
xlim([0.97, 1.04]); ylim([0, 1.0]);
xlabel('TU'); ylabel('CW p-value');
title('(a): 1990m1-2024m12 out-of-sample period.');

subplot(2,2,2)
scatter(mc(:,1),mc(:,3), 50, 'b', 'filled')
hold on 
plot([1,1],[0, 1.0], 'k:')
plot(xlim,[0.1,0.1], 'k--', 'LineWidth', 2)
xlim([0.97, 1.04]); ylim([0, 1.0]);
xlabel('TU'); ylabel('DM p-value');
title('(b): 1990m1-2024m12 out-of-sample period.');

subplot(2,2,3)
scatter(mc(:,4),mc(:,5), 50, 'b', 'filled')
hold on 
plot([1,1],[0, 1.0], 'k:')
plot(xlim,[0.1,0.1], 'k--', 'LineWidth', 2)
xlim([0.97, 1.04]); ylim([0, 1.0]);
xlabel('TU'); ylabel('CW p-value');
title('(c): 1990m1-2019m12 out-of-sample period.');

subplot(2,2,4)
scatter(mc(:,4),mc(:,6), 50, 'b', 'filled')
hold on 
plot([1,1],[0, 1.0], 'k:')
plot(xlim,[0.1,0.1], 'k--', 'LineWidth', 2)
xlim([0.97, 1.04]); ylim([0, 1.0]);
xlabel('TU'); ylabel('DM p-value');
title('(d): 1990m1-2019m12 out-of-sample period.');

out_dir = fullfile(repl_root, 'reports', 'plots');
set(fig, 'PaperPositionMode', 'auto');
saveas(fig, fullfile(out_dir, 'figure3_supp_reproduced.png'));
saveas(fig, fullfile(out_dir, 'figure3_supp_reproduced.fig'));
close(fig);