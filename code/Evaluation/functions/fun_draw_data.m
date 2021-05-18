% FUN_DRAW_DATA Plot the theoretical curve and the testing data of a selected tag.
%   Example:
%       fun_draw_data(TagID)
function [] = fun_draw_data(TagID)
%% Get parameters
para = fun_get_parameters(TagID);
%% Load data from file
temp_col = 1; % Temperature column
ptime_col = 2; % Persistence time column
epc_col =3; % ID column
if TagID>=1&TagID<=20
    load('data\testing\Monza5.mat')
else
    if TagID>=21&TagID<=40
        load('data\testing\MonzaR6.mat')
        TagID = TagID -20;
    end
end
epcs = unique(test_data(:,epc_col));
epc = epcs(TagID);
index = test_data(:,epc_col) == epc;
temps = test_data(index,temp_col);
ptimes = test_data(index,ptime_col);
%% Plot data 
figure
fun = @(para,temp)para(1)./(para(2).^temp+para(3));
temp = 0:1:80;
y = fun(para,temp);
cl = {[50,100,180]/255, [46,139,87]/255,  [210,105,30]/255, [128,128,128]/255,[205,92,92]/255}; % blue gree orange grey 
plot(temps,ptimes,'o','Color', [210,105,30]/255)
hold on 
plot(temp,y,'LineWidth',1.5,'Color',[50,100,180]/255);
legend('Testing Data','Theoretical Curve','Location','southwest');
fun_set_axis_size('Temperature (\circC)','Persistence Time (s)',14,[420 300]);
end


