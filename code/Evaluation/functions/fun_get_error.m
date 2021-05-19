% FUN_GET_PERTAG_ERROR  Get temperature errors of a selected tag.
%   E = FUN_GET_PERTAG_ERROR(TagID) returns the temperature errors of a tag.  

%   [E,T] = FUN_GET_PERTAG_ERROR(TagID) also returns the corresponding temperature levels.
%   The result means the temperature error at T ¡æ is E ¡æ. 

%   Example:
%       E = fun_get_pertag_error(TagID)
%       [E,T] =  fun_get_pertag_error(TagID)
function [E,T] = fun_get_pertag_error(TagID)
%% Extract parameters
para = fun_get_parameters(TagID);
%% Calculate temperature errors
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

