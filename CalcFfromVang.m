function [freq] = CalcFfromVang(Vangdegrees,timevector,freq_initialPU)
%CalcFfromVang This function is to be used to calculate the frequency given the
% voltage angle in degrees, time vector in seconds, and initial frequency in PU. 
%   Detailed explanation goes here

%% Check to see if length of vectors are the same
if(length(Vangdegrees)~=length(timevector))
    error('Length of Vang and Timevector are not the same.')
end

%% Check to see if timevector has repeated points
if(length(unique(timevector))~=length(timevector))
        error('Timevector has repeated points.')
end

%% Calculate Frequency from Vangle
theta=unwrap(Vangdegrees*pi/180);

for k=1:length(theta)-1
DeltaAngleRad(k)=(theta(k+1)-theta(k));
DeltaT(k)=timevector(k+1)-timevector(k);
freq(k)=DeltaAngleRad(k)/DeltaT(k)/(2*pi);
end
freq=[0,freq];

freq=freq/60;
freq=freq_initialPU+freq;

end

