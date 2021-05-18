% Generate training data for Monza5 tags
% The data format is as follows:
% Temperature (℃)    Persistence time (s)    ID
% 16.28                        0.82           4
% The record means the persistence time of tag #4 is 0.82 s at 16.28 ℃.
close all
clear all
train_data = [];
[temps,ptimes,IDs] = fun_synchronize_data('210414','Monza5-4.txt');
train_data = [train_data;[temps,ptimes,IDs]];
[temps,ptimes,IDs] = fun_synchronize_data('210415','Monza5-1.txt');
train_data = [train_data;[temps,ptimes,IDs]];
[temps,ptimes,IDs] = fun_synchronize_data('210416','Monza5-1.txt');
train_data = [train_data;[temps,ptimes,IDs]];
[temps,ptimes,IDs] = fun_synchronize_data('210420','Monza5-1.txt');
train_data = [train_data;[temps,ptimes,IDs]];
save 'train_data.mat' train_data 
