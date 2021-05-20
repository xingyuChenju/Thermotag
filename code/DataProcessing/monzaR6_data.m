% Generate testing data for Monza5 tags
% The data format is as follows:
% Temperature (degree)    Persistence time (s)    ID
% 16.28                        0.82           4
% The record means the persistence time of tag #4 is 0.82 s at 16.28 â„?.

close all
clear all
%% Generate testing data
test_data = [];
[a,b,c] = fun_synchronize_data('210424','MonzaR6-1.txt');
test_data = [test_data;[a,b,c]];
[a,b,c] = fun_synchronize_data('210424','MonzaR6-2.txt');
test_data = [test_data;[a,b,c]];
[a,b,c] = fun_synchronize_data('210424','MonzaR6-3.txt');
test_data = [test_data;[a,b,c]];
[a,b,c] = fun_synchronize_data('210424','MonzaR6-4.txt');
test_data = [test_data;[a,b,c]];

% Map the tag ID to 1-20
temp_col = 1;
ptime_col = 2;
epc_col = 3;
test_data20 = [];
epcs = unique(test_data(:,epc_col));
for i = 1:20
    % select the i-th tag
    index = test_data(:,epc_col) == epcs(i);
    % change its ID to i
    subdata = test_data(index,:)
    subdata(:,epc_col) = i;
    test_data20 = [test_data20;subdata];
end
test_data = test_data20;
mkdir(['data' filesep 'testing' filesep]);
filename =  ['data' filesep 'testing' filesep 'MonzaR6.mat'];
save(filename,'test_data') 

%% Generate training data 
train_data = [];
[a,b,c] = fun_synchronize_data('210414','MonzaR6-1.txt');
train_data = [train_data;[a,b,c]];
[a,b,c] = fun_synchronize_data('210414','MonzaR6-2.txt');
train_data = [train_data;[a,b,c]];
[a,b,c] = fun_synchronize_data('210415','MonzaR6-1.txt');
train_data = [train_data;[a,b,c]];
[a,b,c] = fun_synchronize_data('210416','MonzaR6-1.txt');
train_data = [train_data;[a,b,c]];

% Map the tag ID to 1-20
temp_col = 1;
ptime_col = 2;
epc_col = 3;
train_data20 = [];
for i = 1:20
    % select the i-th tag
    index = train_data(:,epc_col) == epcs(i);
    % change its ID to i
    subdata = train_data(index,:)
    subdata(:,epc_col) = i;
    train_data20 = [train_data20;subdata];
end
train_data = train_data20;
mkdir(['data' filesep 'training' filesep]);
filename =  ['data' filesep 'training' filesep 'MonzaR6.mat'];
save(filename,'train_data') 


