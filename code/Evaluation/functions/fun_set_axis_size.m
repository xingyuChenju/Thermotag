%FUN_SET_AXIS Get a figure with the specified size.
%   Example:
%       fun_set_axis_size('Temperature (\circC)','Error (\circC)',16,[420 300]); 
function [  ] = fun_set_axis_size( x_label, y_label, size,fsize)
figsize = [100 100 fsize];
set(gcf,'Position',figsize); 
label_size = size;
axis_size = size;
set(gca,'FontSize',axis_size,'fontname','Times New Roman');
xlabel(x_label,'Fontsize',label_size,'fontname','Times New Roman');
ylabel(y_label,'Fontsize',label_size,'fontname','Times New Roman');
end

