
clear all
close all

if exist('functions', 'dir'), addpath('functions'); end
if exist('data', 'dir'), addpath('data'); end
if exist('results', 'dir'), addpath('results'); end
if exist('../functions', 'dir'), addpath('../functions'); end
if exist('../data', 'dir'), addpath('../data'); end
if exist('../results', 'dir'), addpath('../results'); end

mc=xlsread('results.xls','figure7');

labels = {'Macrun1m','Macrun3m','Macrun12m','Finaun1m','Finaun3m','Finaun12m','Realun1m','Realun3m','Realun12m',...
    'T-bill','Kilian','Epu','Gpr','Vol','Emv','Commodity','Petroluem','Spread'};

subplot(2,2,1)
barh(mc(:,1))
set(gca,'YTick',1:18,'YTickLabel',labels)
xlim([0.95, 1.00]);
title('(a): 1990m1-2024m12 out-of-sample period.');
xlabel('Average VaR loss relative to benchmark');
ylabel('Monitoring variable');

subplot(2,2,2)
barh(mc(:,3))
set(gca,'YTick',1:18,'YTickLabel',labels)
xlim([0.95, 1.00]);
title('(b): 1990m1-2019m12 out-of-sample period.');
xlabel('Average VaR loss relative to benchmark');
ylabel('Monitoring variable');

subplot(2,2,3)
barh(mc(:,2))
hold on;
plot([0, 0], [0, 19], 'k:');
set(gca,'YTick',1:18,'YTickLabel',labels)
xlim([-0.15, 0.35]);
title('(c): 1990m1-2024m12 out-of-sample period.');
xlabel('Sharpe ratio relative to the benchmark');
ylabel('Monitoring variable');

subplot(2,2,4)
barh(mc(:,4))
hold on;
plot([0, 0], [0, 19], 'k:');
set(gca,'YTick',1:18,'YTickLabel',labels)
xlim([-0.1, 0.4]);
title('(d): 1990m1-2019m12 out-of-sample period.');
xlabel('Sharpe ratio relative to the benchmark');
ylabel('Monitoring variable');




