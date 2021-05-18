% Generate training data for MonzaR6 tags
% The data format is as follows:
% Temperature (¡æ)    Persistence time (s)    ID
% 16.28                        0.82                             4
% The record means the persistence time of tag #4 is 0.82 s at 16.28 ¡æ.
close all
clear all
train_data = [];
[a,b,c] = fun_synchronize_data('210414','MonzaR6-1.txt');
train_data = [train_data;[a,b,c]];
[a,b,c] = fun_synchronize_data('210414','MonzaR6-2.txt');
train_data = [train_data;[a,b,c]];
[a,b,c] = fun_synchronize_data('210415','MonzaR6-1.txt');
train_data = [train_data;[a,b,c]];
[a,b,c] = fun_synchronize_data('210416','MonzaR6-1.txt');
train_data = [train_data;[a,b,c]];
save 'train_data.mat' train_data 