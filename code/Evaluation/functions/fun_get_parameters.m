% FUN_GET_PARAMETERS  Get parameters of a tag. 
%   P = FUN_GET_PARAMETERS(TagID) returns the parameters of a tag. 

%   Example:
%       P = fun_get_parameters(TagID)
function P = fun_get_parameters(TagID)
%% Load data from file
temp_col = 1; % Temperature column
ptime_col = 2; % Persistence time column
epc_col =3; % ID column
if TagID>=1&TagID<=20
    load(['data' filesep 'training' filesep 'Monza5.mat'])
else
    if TagID>=21&TagID<=40
        load(['data' filesep 'training' filesep 'MonzaR6.mat'])
        TagID = TagID -20;
    end
end
epcs = unique(train_data(:,epc_col));
epc = epcs(TagID);
index = train_data(:,epc_col) == epc;
temps = train_data(index,temp_col); % Temperature
ptimes = train_data(index,ptime_col); % Persistence time
%% Data processing
temp = [];
ptime = [];
for i= 1:18
    index = temps>i*5-2.5&temps<i*5+2.5;
    if ~isnan(mean(ptimes(index)))
        ptime = [ptime;mean(ptimes(index))];
        temp = [temp;(i)*5];
    end
end
%% Least square methods
fun = @(para,temp)para(1)./(para(2).^temp+para(3));
x0 = [1,1,1];
P =  lsqcurvefit(fun,x0,temp,ptime);
end

