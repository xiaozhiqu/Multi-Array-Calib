function [ sensorData ] = SampleData( sensorData, samples )
%SAMPLEDATA Uniformly samples data
%--------------------------------------------------------------------------
%   Inputs:
%--------------------------------------------------------------------------
%   sensorData- nx1 cell containing sensor data sturcts
%   samples - scalar, number of points to sample the data at (uniformly
%       distributed)
%
%--------------------------------------------------------------------------
%   Outputs:
%--------------------------------------------------------------------------
%   sensorData- nx1cell containing sensor data sturcts
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

%check inputs
validateattributes(samples,{'numeric'},{'scalar','positive','integer','nonzero'});
validateattributes(sensorData,{'cell'},{'vector'});
for i = 1:length(sensorData)
    validateattributes(sensorData{i},{'struct'},{});
end

addpath('./timing');

%get interpolation points
tMin = 0;
tMax = inf;
for i = 1:length(sensorData)
    tMin = max(tMin,sensorData{i}.time(1));
    tMax = min(tMax,sensorData{i}.time(end));
end

%turn points into times
times = tMin:(tMax-tMin)/(samples):tMax;

%interpolate at set times
sensorData = IntSensorData(sensorData, times);

end
