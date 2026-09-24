clear all
close all
clc

script_dir = fileparts(mfilename('fullpath'));
if isempty(script_dir), script_dir = pwd; end
addpath(fullfile(script_dir, '..', 'functions'));
addpath(fullfile(script_dir, '..', 'data'));
addpath(fullfile(script_dir, '..', 'results'));

mc=xlsread('results.xls','figure5_supp');
mc=mc(1:18, :);

fig = figure('Visible', 'off', 'Position', [100 100 800 600]);

subplot(2,2,1)
scatter(mc(:,1),mc(:,2), 50, 'b', 'filled')   
hold on
plot([1,1],[0, 0.50], 'k:')
plot(xlim,[0.1,0.1], 'k--', 'LineWidth', 2)
xlim([0.95, 1.02]); ylim([0, 0.50]);
xlabel('TU'); ylabel('CW p-value');
title('(a): 1990m1-2024m12 out-of-sample period.');

subplot(2,2,2)
scatter(mc(:,1),mc(:,3), 50, 'b', 'filled')
hold on 
plot([1,1],[0, 0.63], 'k:')
plot(xlim,[0.1,0.1], 'k--', 'LineWidth', 2)
xlim([0.95, 1.02]); ylim([0, 0.63]);
xlabel('TU'); ylabel('DM p-value');
title('(b): 1990m1-2024m12 out-of-sample period.');

subplot(2,2,3)
scatter(mc(:,4),mc(:,5), 50, 'b', 'filled')
hold on 
plot([1,1],[0, 0.30], 'k:')
plot(xlim,[0.1,0.1], 'k--', 'LineWidth', 2)
xlim([0.95, 1.02]); ylim([0, 0.30]);
xlabel('TU'); ylabel('CW p-value');
title('(c): 1990m1-2019m12 out-of-sample period.');

subplot(2,2,4)
scatter(mc(:,4),mc(:,6), 50, 'b', 'filled')
hold on 
plot([1,1],[0, 0.50], 'k:')
plot(xlim,[0.1,0.1], 'k--', 'LineWidth', 2)
xlim([0.95, 1.02]); ylim([0, 0.50]);
xlabel('TU'); ylabel('DM p-value');
title('(d): 1990m1-2019m12 out-of-sample period.');

out_dir = fullfile(script_dir, '..', 'plots');
set(fig, 'PaperPositionMode', 'auto');
saveas(fig, fullfile(out_dir, 'figure5_supp_reproduced.png'));
saveas(fig, fullfile(out_dir, 'figure5_supp.fig'));
close(fig);