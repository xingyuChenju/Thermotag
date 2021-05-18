% Generate testing data for MonzaR6 tags
% The data format is as follows:
% Temperature (¡æ)    Persistence time (s)    ID
% 16.28                        0.82                             4
% The record means the persistence time of tag #4 is 0.82 s at 16.28 ¡æ.
close all
clear all
test_data = [];
[a,b,c] = fun_synchronize_data('210424','MonzaR6-1.txt');
test_data = [test_data;[a,b,c]];
[a,b,c] = fun_synchronize_data('210424','MonzaR6-2.txt');
test_data = [test_data;[a,b,c]];
[a,b,c] = fun_synchronize_data('210424','MonzaR6-3.txt');
test_data = [test_data;[a,b,c]];
[a,b,c] = fun_synchronize_data('210424','MonzaR6-4.txt');
test_data = [test_data;[a,b,c]];
save 'test_data.mat' test_data 