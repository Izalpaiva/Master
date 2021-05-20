%This routine is to convert the continuous files from OpenEphys(OE)to Matlab. Uses a function from the OpenEphys guide. 
%Author : Izabeba Lima Paiva 
clear 
clc
addpath 'E:\Mestrado\CODE\Functions' %set the path with additional functions
cd      'E:\Mestrado\OpenEphysTest1\2021-04-19_17-10-37\Record Node 110' %Set the directory with the OE  files.
filenames  = dir('*.continuous');
% Loading LFP and timestamps 
LFP     =[];
ts      =[];
for i =[1,12,18,19,20,21,22,23,24,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17] %List of channels in order
channel = [];
[data timestamps] = load_open_ephys_data(filenames(24).name);
LFP               = [LFP, data];
end 

% Downsampling of LFP 
srateRec  = 30000;
srate     = 1000;
dt        = 1/srate;

for l = 1:size(LFP,2) 
    detrend_signal  = detrend(LFP(:,l));
    resemple_time   = timestamps(1:30:end)/60;
    LFP_temp        = resample(detrend_signal,srate/1000,srateRec/1000);
    eval(['LFP' num2str(l) '= LFP_temp;']);    
end

 save('LFPs', 'LFP*') %Save the LFP.

% Print the signal - General view :)
for p = 1:16
plot(timevector,LFP1 + p*1000)
hold on
xlim([0 0.5])
end

for  p = 1:8
plot(resemple_time, eval(['LFP' num2str(p)])
hold on
xlim([12.5 12.55])
ylim 
end

