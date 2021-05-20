%This routine is to previous analyzis of data.
%Author : Izabeba Lima Paiva 
clear 
clc
addpath 'E:\Mestrado\CODE\Functions' %set the path with additional functions
cd      'E:\Mestrado\OpenEphysTest1\2021-04-19_17-10-37\Record Node 110' %Set the directory with the OE  files.

%% PSD 

load 'LFPs' 
srate   = 1000;
window  = 1*srate;
overlap = [];      % O padrão de overlap é de 50% de sobreposição entre as janelas.
NFFT    = 2^13;    % Padrão para análises.


for i = 1:24
    
    LFP = eval(['LFP' num2str(i)]);
    [PSD, F] = pwelch(LFP1,window,overlap,NFFT,srate); % ['LFP' num2str(i)]
    
    eval (['PSD_' num2str(i) '= PSD;'])
    
end

%% Hilbert Transform and EEG - Filt 

for i = 1:24 
 
LFP = eval(['LFP' num2str(i)]);

%EEg filt  
deltaband  = eegfilt(LFP,srate,1,4);    %Delta Band
thetaband  = eegfilt(LFP,srate,8,12);   %Theta band
gammaband  = eegfilt(LFP,srate,30,160); %Gamma band 

eval (['deltaband' num2str(i) '= deltaband;'])
eval (['thetaband' num2str(i) '= thetaband;'])
eval (['gammaband' num2str(i) '= gammaband;'])

%Hilbert transform: Absolute value

deltaamp   = abs(hilbert(deltaband));
thetaamp   = abs(hilbert(thetaband));
gammaamp   = abs(hilbert(gammaband));

eval (['deltaamp' num2str(i) '= deltaamp;'])
eval (['thetaamp' num2str(i) '= thetaamp;'])
eval (['gammaamp' num2str(i) '= gammaamp;'])

%Hilbert transform: Angle

deltaphase    = angle(hilbert(deltaband));
thetaphase    = angle(hilbert(thetaband));
gammaphase    = angle(hilbert(gammaband));

eval (['deltaangle' num2str(i) '= deltaphase;'])
eval (['thetaangle' num2str(i) '= thetaphase;'])
eval (['gammaangle' num2str(i) '= gammaphase;'])

%Hilbert transform: Frequency

deltaphaserad = unwrap(thetaphase);
thetaphaserad = unwrap(deltaphase);
gammaphaserad = unwrap(gammaphase);

Freq_Inst_delta = diff(deltaphaserad)/(2*pi)/dt; 
Freq_Inst_theta = diff(thetaphaserad)/(2*pi)/dt; 
Freq_Inst_gamma = diff(gammaphaserad)/(2*pi)/dt; 

eval (['Freq_Inst_delta' num2str(i) '= Freq_Inst_delta;'])
eval (['Freq_Inst_theta' num2str(i) '= Freq_Inst_theta;'])
eval (['Freq_Inst_gamma' num2str(i) '= Freq_Inst_gamma;'])

end

%% Spectrogram

for i = 1:24
    
    LFP = eval(['LFP' num2str(i)]);
    [S,F,T,P] = spectrogram(filtLFP,WindowLength,Overlap,NFFT,srate); % ['LFP' num2str(i)]
    
    eval (['SPECT_' num2str(i) '= T;'])
    eval (['SPECF_' num2str(i) '= F;'])
    eval (['SPECP_' num2str(i) '= P;'])
end

