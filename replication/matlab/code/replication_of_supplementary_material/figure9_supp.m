clear all
close all
clc

script_dir = fileparts(mfilename('fullpath'));
if isempty(script_dir), script_dir = pwd; end
addpath(fullfile(script_dir, '..', 'functions'));
addpath(fullfile(script_dir, '..', 'data'));
addpath(fullfile(script_dir, '..', 'results'));

mc = xlsread('results.xls', 'figure9_supp');

fig_path = fullfile(script_dir, '..', 'plots', 'figure9_supp.fig');
if exist(fig_path, 'file')
    fig = openfig(fig_path, 'invisible');
    set(fig, 'Visible', 'off');
    
    % Update subplot (a) and (b)
    subplot(2,2,1);
    bar(mc(:,1));
    set(gca, 'XTick', 1:4);
    set(gca, 'XTickLabel', {'h=2','h=3','h=4','h=9'});
    xlabel('Forecast horizon'); ylabel('TU');
    ylim([0.90, 1.00]);
    title({'(a): Logarithm of the one-month-ahead macroeconomic '; 'uncertainty index suggested in Ludvigson et al. (2021).'});
    
    subplot(2,2,2);
    bar([mc(:,2), mc(:,3)], 1);
    set(gca, 'XTick', 1:4);
    set(gca, 'XTickLabel', {'h=2','h=3','h=4','h=9'});
    xlabel('Forecast horizon'); ylabel('p-value');
    legend('CW','DM', 'Location', 'best');
    ylim([0.00, 0.20]);
    title({'(b): Logarithm of the one-month-ahead macroeconomic '; 'uncertainty index suggested in Ludvigson et al. (2021).'});
else
    fig = figure('Visible', 'off', 'Position', [100 100 800 600]);
    subplot(2,2,1);
    bar(mc(:,1));
    set(gca, 'XTick', 1:4);
    set(gca, 'XTickLabel', {'h=2','h=3','h=4','h=9'});
    xlabel('Forecast horizon'); ylabel('TU');
    ylim([0.90, 1.00]);
    title('(a): TU');
    
    subplot(2,2,2);
    bar([mc(:,2), mc(:,3)], 1);
    set(gca, 'XTick', 1:4);
    set(gca, 'XTickLabel', {'h=2','h=3','h=4','h=9'});
    xlabel('Forecast horizon'); ylabel('p-value');
    legend('CW','DM', 'Location', 'best');
    title('(b): p-values');
end

out_dir = fullfile(script_dir, '..', 'plots');
set(fig, 'PaperPositionMode', 'auto');
saveas(fig, fullfile(out_dir, 'figure9_supp_reproduced.png'));
close(fig);