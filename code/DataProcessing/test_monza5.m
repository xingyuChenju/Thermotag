% Generate testing data for Monza5 tags
% The data format is as follows:
% Temperature (¡æ)    Persistence time (s)    ID
% 16.28                        0.82                             4
% The record means the persistence time of tag #4 is 0.82 s at 16.28 ¡æ.

close all
clear all
test_data = [];
[temps,ptimes,IDs] = fun_synchronize_data('210421','Monza5-4.txt');
test_data = [test_data;[temps,ptimes,IDs]];
[temps,ptimes,IDs] = fun_synchronize_data('210422','Monza5-2.txt');
test_data = [test_data;[temps,ptimes,IDs]];
[temps,ptimes,IDs] = fun_synchronize_data('210423','Monza5-2.txt');
test_data = [test_data;[temps,ptimes,IDs]];
[temps,ptimes,IDs] = fun_synchronize_data('210423','Monza5-3.txt');
test_data = [test_data;[temps,ptimes,IDs]];
save 'test_data.mat' test_data 