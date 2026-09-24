
clear all
clc
close all

if exist('functions', 'dir'), addpath('functions'); end
if exist('data', 'dir'), addpath('data'); end
if exist('results', 'dir'), addpath('results'); end
if exist('../functions', 'dir'), addpath('../functions'); end
if exist('../data', 'dir'), addpath('../data'); end
if exist('../results', 'dir'), addpath('../results'); end

mc=xlsread('results.xls','figure4');
mc=mc(1:18,:);

subplot(2,2,1)
scatter(mc(:,1),mc(:,2),50,'b','filled')
hold on
plot([1,1],get(gca,'ylim'),'k:')
plot(xlim,[0.1,0.1],'k--','LineWidth',2)
xlabel('TU'); ylabel('CW p-value');
title('(a): Expansion periods in the United States as defined by NBER.');

subplot(2,2,2)
scatter(mc(:,1),mc(:,3),50,'b','filled')
hold on
plot([1,1],get(gca,'ylim'),'k:')
plot(xlim,[0.1,0.1],'k--','LineWidth',2)
xlabel('TU'); ylabel('DM p-value');
title('(b): Expansion periods in the United States as defined by NBER.');

subplot(2,2,3)
scatter(mc(:,4),mc(:,5),50,'b','filled')
hold on
plot([1,1],get(gca,'ylim'),'k:')
plot(xlim,[0.1,0.1],'k--','LineWidth',2)
xlabel('TU'); ylabel('CW p-value');
title('(c): Recession periods in the United States as defined by NBER.');

subplot(2,2,4)
scatter(mc(:,4),mc(:,6),50,'b','filled')
hold on
plot([1,1],get(gca,'ylim'),'k:')
plot(xlim,[0.2,0.2],'k--','LineWidth',2)
xlabel('TU'); ylabel('DM p-value');
title('(d): Recession periods in the United States as defined by NBER.');
 