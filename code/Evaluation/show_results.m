close all
clear all
addpath('functions')
%% Plot data of the k-th tag
% 1<=k<=20 tag model is Monza5
% 20<=k<=40 tag model is MonzaR6
k =1;
fun_draw_data(1);

%% Plot average temperature errors of 20 tags
errors = zeros(1,20);
for i = 1:20
    errors(i) = mean(fun_get_error(i));
end
figure
cl = {[60,87,167]/255, [253,238,16]/255, [43,46,128]/255, [254,191,16]/255,[221,31,38]/255,[111,204,221]/255, [126,20,22]/255,[56,79,162]/255,[118,201,182]/255, [143,203,127]/255,[63,101,176]/255,[70,133,198]/255, [245,127,32]/255,[238,47,36]/255,[219,225,32]/255, [46,64,157]/255,[56,198,244]/255,[174,30,35]/255,[240,83,35]/255,[171,209,82]/255};
h = bar(errors,0.8,'FaceColor','flat');
for i = 1:20
    h.CData(i,:) = cl{i};
end 
xticks(1:20)
xlim([0 21])
fun_set_axis_size('Tag #','Temperature Error (\circC)',12,[420 300]);

%% Plot temperature errors at different temperature levels 
errors = zeros(1,20);
pertag_errors = [];
temps = [];
for i = 1:20
    [errors,temp]= fun_get_error(i);
    temps = [temps;temp];
    pertag_errors = [pertag_errors;errors];
end
mean_errors = zeros(1,8);
for i = 1:8
    index = temps>i*10-10&temps<i*10;
    mean_errors(1,i) = mean(pertag_errors(index));
end

figure 
cl = {[50,100,180]/255, [46,139,87]/255,  [210,105,30]/255, [128,128,128]/255,[205,92,92]/255}; % blue gree orange grey 
h=bar(mean_errors',0.6,'FaceColor','flat');
h(1).CData = cl{1};

xticklabels({'0-10';'10-20';'20-30';'30-40';'40-50';'50-60';'60-70';'70-80'})
set(gca,'FontSize',10,'fontname','Times New Roman');
set(gcf,'Position', [100 100 420 300]); 
xlabel('Temperature (\circC)','Fontsize',16,'fontname','Times New Roman');
ylabel('Error (\circC)','Fontsize',16,'fontname','Times New Roman');
ylim([0 5])

