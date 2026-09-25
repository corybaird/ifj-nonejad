
clear all
repl_root=fullfile(fileparts(mfilename('fullpath')),'..','..');
if isempty(fileparts(mfilename('fullpath'))), repl_root=fullfile(pwd,'..','..'); end
addpath(fullfile(repl_root,'code','functions'),fullfile(repl_root,'data'),fullfile(repl_root,'reports','results'),fullfile(repl_root,'code','replication_of_submission'));
clc

close all


mc=xlsread('results.xls','figure5');
mc=mc(1:18,:);

subplot(2,2,1)
scatter(mc(:,1),mc(:,2),50,'b','filled')
xlim([0.95, 1.02]); ylim([0, 1.0]);
hold on
plot([1,1],[0, 1.0],'k:')
plot(xlim,[0.1,0.1],'k--','LineWidth',2)
xlabel('TU'); ylabel('CW p-value');
title('(a): Periods of high economic activity as defined in Kilian (2009).');

subplot(2,2,2)
scatter(mc(:,1),mc(:,3),50,'b','filled')
xlim([0.95, 1.02]); ylim([0, 1.0]);
hold on
plot([1,1],[0, 1.0],'k:')
plot(xlim,[0.1,0.1],'k--','LineWidth',2)
xlabel('TU'); ylabel('DM p-value');
title('(b): Periods of high economic activity as defined in Kilian (2009).');

subplot(2,2,3)
scatter(mc(:,4),mc(:,5),50,'b','filled')
xlim([0.90, 1.02]); ylim([0, 1.0]);
hold on
plot([1,1],[0, 1.2],'k:')
plot(xlim,[0.1,0.1],'k--','LineWidth',2)
xlabel('TU'); ylabel('CW p-value');
title('(c): Periods of low economic activity as defined in Kilian (2009).');

subplot(2,2,4)
scatter(mc(:,4),mc(:,6),50,'b','filled')
xlim([0.90, 1.02]); ylim([0, 1.0]);
hold on
plot([1,1],[0, 1.2],'k:')
plot(xlim,[0.1,0.1],'k--','LineWidth',2)
xlabel('TU'); ylabel('DM p-value');
title('(d): Periods of low economic activity as defined in Kilian (2009).');
 
