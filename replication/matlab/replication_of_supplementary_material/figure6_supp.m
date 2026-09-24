clear all
close all
clc

script_dir = fileparts(mfilename('fullpath'));
if isempty(script_dir), script_dir = pwd; end
addpath(fullfile(script_dir, '..', 'functions'));
addpath(fullfile(script_dir, '..', 'data'));
addpath(fullfile(script_dir, '..', 'results'));

mc=xlsread('results.xls','figure6_supp');
mc=mc(1:18, :);

fig = figure('Visible', 'off', 'Position', [100 100 800 600]);

subplot(2,2,1)
scatter(mc(:,1),mc(:,2), 50, 'b', 'filled')   
hold on
plot([1,1],[0, 0.50], 'k:')
plot(xlim,[0.1,0.1], 'k--', 'LineWidth', 2)
xlim([0.95, 1.02]); ylim([0, 0.50]);
xlabel('TU'); ylabel('CW p-value');
title('(a): Hyperparameter values on the prior for \pi_{t+1} are \alpha=0.10 and \beta=0.10.');

subplot(2,2,2)
scatter(mc(:,3),mc(:,4), 50, 'b', 'filled')
hold on 
plot([1,1],[0.04, 0.14], 'k:')
plot(xlim,[0.1,0.1], 'k--', 'LineWidth', 2)
xlim([0.95, 1.02]); ylim([0.04, 0.14]);
xlabel('TU'); ylabel('CW p-value');
title('(b): Hyperparameter values on the prior for \pi_{t+1} are \alpha=2 and \beta=2.');

subplot(2,2,3)
scatter(mc(:,5),mc(:,6), 50, 'b', 'filled')
hold on 
plot([1,1],[0.04, 0.14], 'k:')
plot(xlim,[0.1,0.1], 'k--', 'LineWidth', 2)
xlim([0.95, 1.02]); ylim([0.04, 0.14]);
xlabel('TU'); ylabel('CW p-value');
title('(c): Hyperparameter values on the prior for \pi_{t+1} are \alpha=20 and \beta=1.');

subplot(2,2,4)
scatter(mc(:,7),mc(:,8), 50, 'b', 'filled')
hold on 
plot([1,1],[0.04, 0.14], 'k:')
plot(xlim,[0.1,0.1], 'k--', 'LineWidth', 2)
xlim([0.95, 1.02]); ylim([0.04, 0.14]);
xlabel('TU'); ylabel('CW p-value');
title('(d): Hyperparameter values on the prior for \pi_{t+1} are \alpha=20 and \beta=0.10.');

out_dir = fullfile(script_dir, '..', 'plots');
set(fig, 'PaperPositionMode', 'auto');
saveas(fig, fullfile(out_dir, 'figure6_supp_reproduced.png'));
saveas(fig, fullfile(out_dir, 'figure6_supp.fig'));
close(fig);