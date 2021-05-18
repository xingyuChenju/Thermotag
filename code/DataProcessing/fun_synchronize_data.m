% FUN_SYNCHRONIZE_DATA Synchronize RFID data and temperature data. 
%   [temps,ptimes,IDs] = FUN_SYNCHRONIZE_DATA(date,filename) returns temperature levels
%   , persistence times, and tag IDs.
%   Example:
%       date = '210421'; % date refers to the measurement time of an experiment. 
%       filename = 'Monza5-4.txt';
%       [temps,ptimes,IDs] = fun_synchronize_data(date,filename)
function [temps,ptimes,IDs] = fun_synchronize_data(date,filename)
id_col = 1;
time_col = 4;
sensor_col = 6;
time_path = ['RFIDdata\data' date '\ftimes\'];
data_path =  ['RFIDdata\data' date '\ptimes\'];
start_time = readtable([time_path filename],'Delimiter',' ');
RFID_day = str2num(datestr(start_time.Var1,'yyyymmdd'));
RFID_hour = str2num(datestr(start_time.Var2,'HHMMSS'));
file_names = dir('TemperatureData');
temp_filename = file_names(3).name ;

for i = 3:length(file_names)
    data_name = file_names(i).name;
    temp_day = str2num(data_name(10:17));
    temp_hour = str2num(data_name(18:23));
    if temp_day == RFID_day
        if temp_hour >RFID_hour
            break;
        else
            temp_filename = data_name;
        end
    else
        if temp_day >RFID_day
            break
        end
        temp_filename = data_name;
    end
end
temp_data = readtable(['TemperatureData\' temp_filename],'Delimiter',',');
index = temp_data.Time>= start_time.Var2;
temp_subdata = temp_data(index,:);

ptime_data = load([data_path filename]);
sensors = ptime_data(:,sensor_col);

%% Label persistence time with temperature
temps = [];
ptimes = [];
IDs= [];
for sensorid = 0:2
    index = sensors == sensorid;
    ptime_subdata = ptime_data(index,:);
    epcs= ptime_subdata(:,id_col);
    epc_set = unique(epcs);
    for j = 1:length(epc_set)
        m_epc = epc_set(j);
        index =epcs ==m_epc;
        temp_data = ptime_subdata(index,:);
        times = temp_data(:,time_col)/1000;
         time_dif = times(2:end) - times(1:end-1);
        
        index = fun_diff(time_dif,2);
        time_dif = time_dif(logical(index));
        times = times(index);
        times = times(2:end);
        index = round(times)+1;
        tems = smooth(temp_subdata{:,sensorid+4});
        tems = tems(index);
        [tems,index] = sort(tems);
        time_dif = time_dif(index);
        temps = [temps;tems];
        ptimes = [ptimes;time_dif];
        IDs = [IDs; epc_set(j)*ones(length(tems),1)+sensorid*100];
    end
end
end

function [index] = fun_diff(time_diff,lim)
% Remove noisy data. 
label = 1;
index =zeros(length(time_diff),1);
i =1;
while(i<length(time_diff))
    startpoint = i;
    while i<=length(time_diff)&time_diff(i)<20
        if time_diff(i)>lim
            label = 0;
        end
        i=i+1;
    end
    if label
        if max(time_diff(startpoint:i-1))-min(time_diff(startpoint:i-1))>0.2|i-startpoint<6
            index(startpoint:i-1) = 0;
        else
            index(startpoint:i-1) = 1;
        end
    else
        index(startpoint:i-1) = 0;
    end
    label =1;
    i = i+1;
end
index = logical(index);
end




