clear all
repl_root=fullfile(fileparts(mfilename('fullpath')),'..','..');
if isempty(fileparts(mfilename('fullpath'))), repl_root=fullfile(pwd,'..','..'); end
addpath(fullfile(repl_root,'code','functions'),fullfile(repl_root,'data'),fullfile(repl_root,'reports','results'),fullfile(repl_root,'code','replication_of_submission'));
close all
clc


mc=xlsread('results.xls','figure1_supp');

fig = figure('Visible', 'off', 'Position', [100 100 900 700]);

vtid=(1:420)';
xlimits=[1,420];
mc(1,2)=0;
vb=[0;diff((mc(:,2)>0)*1)];
ma=[vtid,vb];
vstart=find(ma(:,end)==1);
vend=(find(ma(:,end)==-1)-1)+2;
Recessions=[vtid(vstart,1),vtid(vend,1)];

subplot(3,2,1)
plot(mc(:,1))
axis tight;
recession_bars;
plot(vtid,mc(:,1), 'b', 'LineWidth', 1.2)
axis tight; 
xlim([1, 420]); ylim([0, 0.4]);
xlabel('Time'); ylabel('Value');
title('(a): Results using the estimated correlation coefficient matrix.');

subplot(3,2,2)
plot(mc(:,3:6), 'LineWidth', 1.0)
legend('TN','FP','FN','TP', 'Location', 'best')
hold on
plot(xlim,[0.1,0.1], 'k:')
plot(xlim,[0.8,0.8], 'k:')
xlim([0, 420]); ylim([0, 1.0]);
xlabel('Time'); ylabel('Rate');
title('(b): Results using the estimated correlation coefficient matrix.');

vtid=(1:420)';
xlimits=[1,420];
mc(1,2)=0;
vb=[0;diff((mc(:,9)>0)*1)];
ma=[vtid,vb];
vstart=find(ma(:,end)==1);
vend=(find(ma(:,end)==-1)-1)+2;
Recessions=[vtid(vstart,1),vtid(vend,1)];

subplot(3,2,3)
plot(mc(:,8))
axis tight;
recession_bars;
plot(vtid,mc(:,8), 'b', 'LineWidth', 1.2)
axis tight; 
xlim([1, 420]); ylim([0, 0.5]);
xlabel('Time'); ylabel('Value');
title('(c): High-correlation scenario.');

subplot(3,2,4)
plot(mc(:,10:13), 'LineWidth', 1.0)
legend('TN','FP','FN','TP', 'Location', 'best')
hold on
plot(xlim,[0.1,0.1], 'k:')
plot(xlim,[0.8,0.8], 'k:')
xlim([0, 420]); ylim([0, 1.0]);
xlabel('Time'); ylabel('Rate');
title('(d): High-correlation scenario.');

vtid=(1:420)';
xlimits=[1,420];
mc(1,2)=0;
vb=[0;diff((mc(:,16)>0)*1)];
ma=[vtid,vb];
vstart=find(ma(:,end)==1);
vend=(find(ma(:,end)==-1)-1)+2;
Recessions=[vtid(vstart,1),vtid(vend,1)];

subplot(3,2,5)
plot(mc(:,15))
axis tight;
recession_bars;
plot(vtid,mc(:,15), 'b', 'LineWidth', 1.2)
axis tight; 
xlim([1, 420]); ylim([0, 0.3]);
xlabel('Time'); ylabel('Value');
title('(e): Low-correlation scenario.');

subplot(3,2,6)
plot(mc(:,17:20), 'LineWidth', 1.0)
legend('TN','FP','FN','TP', 'Location', 'best')
hold on
plot(xlim,[0.1,0.1], 'k:')
plot(xlim,[0.8,0.8], 'k:')
xlim([0, 420]); ylim([0, 1.0]);
xlabel('Time'); ylabel('Rate');
title('(f): Low-correlation scenario.');

out_dir = fullfile(repl_root, 'reports', 'plots');
set(fig, 'PaperPositionMode', 'auto');
saveas(fig, fullfile(out_dir, 'figure1_supp_reproduced.png'));
saveas(fig, fullfile(out_dir, 'figure1_supp_reproduced.fig'));
close(fig);