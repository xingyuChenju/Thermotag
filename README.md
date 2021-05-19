 
<h1 align="center">Thermotag</h1>
 
 
## Introduction
Thermotag is a novel temperature sensing method based on low-cost commodity RFID tags. It leverages the discharging period of RFID tag's volatile memory as the metric to do temperature sensing. Since this metric is C1G2 compatible and is robust to environmental factors like the tag location, Thermotag is a low-cost and reliable way to perform temperature sensing in practice.
 
In this project, we show how Thermotag measures the persistence time from commodity RFID tags and plot results with data extracted in practice. An Impinj R420 reader is used in Thermotag. Note that the same method can also be applied to other commercial reader models, such as Alien F800 and Thingmagic M6E. The details are given below.   
 
## Getting Started
#### 1. Environment settings:
 The JDK version is 1.80\_121 and [Intellij IDEA](https://www.jetbrains.com/idea/) is severed as the compiler for editing and running these codes. The Java codes are based on [Octane SDK](https://support.impinj.com/hc/en-us/articles/202755268-Octane-SDK?_ga=2.2128496.1151575669.1621242414-348232292.1593868628) and are used to measure persistence times of RFID tags. The MATLAB version is R2019a. The matlab codes are used for processing the RFID data and plotting the results.
 
#### 2. Measure persistence times:
Connect an RFID reader to the computer.
 
After that, run Settings.java to get the settings used in Thermotag. It will return a settings.json, which will later be used by ReadTag.java to operate the reader.
 
Finally, start ReadTag.java and the valid data of the tag will be stored in files. The data format is as follows:

    ID      Phase       RSSI(dBm)    Time(ms)    Frequency(MHz)   SensorID 
    07      0.11045      -21.5          0         	920.625          01 
    02      5.19099      -52.5          1         	920.625          01 
    07      0.11658      -21.0          1329      	920.625          01  
 
The persistence time of a tag is the time difference between its adjacent replies. In this example, the persistence time of tag #7 is 1329 - 0 = 1329 ms.
 
#### 3. Data processing:
Extract temperature data with a temperature sensor (The sensor model is PT100) and an industrial online monitoring analyzer (The analyzer model is f5000 from [Sinomeasure](https://sinomeasure.en.alibaba.com/)). 
 
After that, synchronize RFID measurements and temperature measurements with fun\_synchronize\_data.m. Several examples are given in test\_monza5.m, test\_monzaR6.m, train\_monza5.m, train\_monzaR6.m with data extracted in our lab. The data format after synchronizing is given below:

    Temperature (℃)   Persistence time (s)    ID
        16.28             	0.82               4  
   	  
The record means the persistence time of tag #4 is 0.82 s at 16.28 ℃.
 
Note that this process is optional. If a different temperature sensor is used, the code should be changed to fit the new data format.
 
#### 4. Evaluation:
Then, we evaluate the performance (temperature error) of Thermotag with data obtained in data processing.
 
You can calculate the temperature error of Thermotag with fun\_get\_error.m. An example is shown in show\_results.m.  
 
## Project Structure 
    code
     ├─DataProcessing
     │       ├─RFIDdata  
     │       └─TemperatureData  
     ├─Evaluation
     │       ├─data  
     │       │  ├─testing  
     │       │  └─training  
     │       └─functions  
     └─FlagBasedMeasurement
             ├─.idea
             │  └─libraries  
             ├─lib
             └─ReadTags 
Java codes are in folder FlagBasedMeasurement\ReadTags.

fun\_synchronize\_data.m. and the examples are in folder DataProcessing.

fun\_get\_error.m is in folder Evaluation\functions and the example is in folder Evaluation.
