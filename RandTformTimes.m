function [ sensorData ] = RandTformTimes( sensorData, timeLength )
%RANDTFORMTIMES gets a random contiguous section of sensor data of length
%   timeLength
%--------------------------------------------------------------------------
%   Required Inputs:
%--------------------------------------------------------------------------
%   sensorData- a nx1 cell containing sensor data sturcts
%   timeLength- length of required data in seconds
%
%--------------------------------------------------------------------------
%   Outputs:
%--------------------------------------------------------------------------
%   sensorData- a nx1 cell containing sensor data sturcts
%
%--------------------------------------------------------------------------
%   References:
%--------------------------------------------------------------------------
%   This function is part of the Multi-Array-Calib toolbox 
%   https://github.com/ZacharyTaylor/Multi-Array-Calib
%   
%   This code was written by Zachary Taylor
%   zacharyjeremytaylor@gmail.com
%   http://www.zjtaylor.com

validateattributes(sensorData,{'cell'},{'vector'});
validateattributes(timeLength,{'numeric'},{'positive','scalar'});

timeLength = 1000000*timeLength;
dataLength = sensorData{1}.time(end)-sensorData{1}.time(1);

if(timeLength > dataLength)
    error('Not enough data for set time');
end

startT = sensorData{1}.time(1) + rand(1)*(dataLength-timeLength);
endT = startT + timeLength;

valid = and(sensorData{1}.time > startT, sensorData{1}.time < endT);

valid = find(valid);

addpath('./timing/');
sensorData = SensorDataSubset(sensorData, valid);

end
