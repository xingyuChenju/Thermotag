% FUN_GET_ERROR Get temperature errors of a selected tag.
%   E = FUN_GET_ONESHOT_ERROR(TagID) returns the temperature errors of a tag.  

%   [E,T] = FUN_GET_ONESHOT_ERROR(TagID) also returns the corresponding temperature levels.
%   The result means the temperature error at T ℃ is E ℃. 

%   Example:
%       IDsets = [1 2 3 4 5];
%       TagID = 6;
%       E = fun_get_oneshot_error(TagID)
%       [E,T] =  fun_get_oneshot_error(TagID)

function [E,T] = fun_get_oneshot_error(IDset,TagID)
%% Extract parameters with traning data.
para = [0 0 0];
for i = 1:length(IDset)
    para = para+ fun_get_parameters(IDset(i));
end
para = para/length(IDset);

%% Calculate temperature errors with testing data.
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
T = test_data(index,temp_col); 
ptimes = test_data(index,ptime_col);
E = abs(fun_get_temperature(para,ptimes)-T);
function temperature = fun_get_temperature(parameters,ptime)
temperature = log(parameters(1)./ptime-parameters(3))/log(parameters(2));
end
end

