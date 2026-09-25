function export_reference_png(fig_dir,out_dir)
% R2009b figures carry manual tick labels on auto tick positions; modern MATLAB
% regenerates the positions and pastes the labels onto them in order, so the
% axes misreport the plotted values. Rebuild positions from the numeric labels.
d=dir(fullfile(fig_dir,'*.fig'));
for i=1:numel(d)
    f=openfig(fullfile(d(i).folder,d(i).name),'invisible');
    ax=findall(f,'Type','axes');
    for j=1:numel(ax)
        restore_ticks(ax(j),'X');
        restore_ticks(ax(j),'Y');
    end
    [~,s]=fileparts(d(i).name);
    saveas(f,fullfile(out_dir,[s '_reference.png']));
    close(f);
end
end

function restore_ticks(ax,dim)
if ~strcmp(get(ax,[dim 'TickLabelMode']),'manual') || ~strcmp(get(ax,[dim 'TickMode']),'auto'), return; end
vals=str2double(cellstr(get(ax,[dim 'TickLabel'])));
if numel(vals)<2 || any(isnan(vals)) || any(diff(vals)<=0)
    fprintf('%s: non-numeric %sTickLabel left unchanged\n',get(get(ax,'Title'),'String'),dim);
    return;
end
set(ax,[dim 'Tick'],vals');
if strcmp(get(ax,[dim 'LimMode']),'auto'), set(ax,[dim 'Lim'],[vals(1),vals(end)]); end
end
