%creating 20 second time axis with sampling rate at 1000hz
time=0:0.0001:20;
fs=10000;
 
%creating  sinusoid with frequency of 5 hertz
y=cos(2*pi*5*time);
plot(time,y);
title('message signal with 5 Hz signal frequency');
xlabel('time');
ylabel('amplitude');
 
%creating carier signal with 40Hz frequency
z=cos(2*pi*40*time);
plot(time,z);
title('carier signal with 40 Hz signal frequency');
xlabel('time');
ylabel('amplitude');
 
%creating AM LC with modulation index 0.5
x1=(1+0.5*y).*z;
plot(time,x1);
title('AM LC with modulation index 0.5');
xlabel('time');
ylabel('amplitude');
 
%creating AM LC with modulation index 1
x2=(1+1*y).*z;
plot(time,x2);
title('AM LC with modulation index 1');
xlabel('time');
ylabel('amplitude');
 
%creating AM LC with modulation index 1.5
x3=(1+1.5*y).*z;
plot(time,x3);
title('AM LC with modulation index 1.5');
xlabel('time');
ylabel('amplitude');
 
% creating a Fourier transform of AMLC using spectrum analyzer with index 0.5 
SpectrumAnalyzer(x1,fs)
title('AMLC using spectrum analyzer with index 0.5');
 
%creating a Fourier transform of AMLC using spectrum analyzer with index 1.0 
SpectrumAnalyzer(x2,fs)
title('AMLC using spectrum analyzer with index 1.0');
 
%creating a Fourier transform of AMLC using spectrum analyzer with index 1.5 
SpectrumAnalyzer(x3,fs)
title('AMLC using spectrum analyzer with index 1.5');


 

%B.Coherent demodulation
%multiplying the input modulated signal by carrier signal
cdemod1=x1.*z;
cdemod2=x2.*z;
cdemod3=x3.*z;
 
cohfilter1=filter(Num,1,cdemod1); %LPF with fpass=8 and fstop=12
plot(time(1:10000),cohfilter1(1:10000));
title('Demodulated signal with index of 0.5');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(cohfilter1,fs) ;  %spectrum analyzer plot for coherent demodulation with index of 0.5
title('spectrum analyzer output of demodulated signal with m=0.5');
 
 
cohfilter2=filter(Num,1,cdemod2); %LPF with fpass=8 and fstop=12
plot(time(1:10000),cohfilter2(1:10000));
title('Demodulated signal with index of 1');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(cohfilter2,fs) ;  %spectrum analyzer plot for coherent demodulation with index of 1.0
title('spectrum analyzer output of demodulated signal with m=1');
 
                                   
cohfilter3=filter(Num,1,cdemod3); %LPF with fpass=8 and fstop=12
plot(time(1:10000),cohfilter3(1:10000));
title('Demodulated signal with index of 1.5');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(cohfilter3,fs) ;  %spectrum analyzer plot for coherent demodulation with index of 1.5
title('spectrum analyzer output of demodulated signal with m=1.5');

%C.Dempdulation using envelop detection
% Passing modulated signal x1 through detector
dect1=abs(x1);
plot(time(1:10000),dect1(1:10000));
title('Envelop Detector output with index of 0.5');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(dect1,fs);  %spectrum analyzer plot for envelope detection with index of 0.5
title('Spectrum Analyzer output of envelop dectector with m=0.5');
 
% Passing modulated signal x2 through detector
dect2=abs(x2);
plot(time(1:10000),dect2(1:10000));
title('Envelop Detector output with index of 1');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(dect2,fs);  %spectrum analyzer plot for envelope detection with index of 1
title('Spectrum Analyzer output of envelop dectector with m=1');
 
% Passing modulated signal x3 through detector
dect3=abs(x3);
plot(time(1:10000),dect3(1:10000));
title('Envelop Detector output with index of 1.5');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(dect3,fs);  %spectrum analyzer plot for envelope detection with index of 1.5
title('Spectrum Analyzer output of envelop dectector with m=1.5');
 
%low pass filtering the dect1 values
envolpout1=filter(Num,1,dect1);   %filter 'Num' is lowpass filter choosen with Fs=10000, Fp=8, Fstop=12
plot(time,envolpout1);
title('Envelope Detection output in time axis after passing through LPF with index of 0.5');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(envolpout1,fs)  %spectrum analyzer plot for envelope detection output with index of 0.5
title(' spectrum analyzer plot for envelope detection i.e after passing LPF output with index of 0.5')              
 
    %low pass filtering the dect2 values
envolpout2=filter(Num,1,dect2);   %filter 'Num' is lowpass filter choosen with Fs=10000, Fp=8, Fstop=12
plot(time(1:10000),envolpout2(1:10000));
title('Envelope Detection output in time axis after passing through LPF with index of 1');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(envolpout2,fs)  %spectrum analyzer plot for envelope detection output with index of 1
title(' spectrum analyzer plot for envelope detection i.e after passing LPF output with index of 1')                                
 
 
%low pass filtering the dect3 values
envolpout3=filter(Num,1,dect3);   %filter 'Num' is lowpass filter choosen with Fs=10000, Fp=8, Fstop=12
plot(time,envolpout3);
title('Envelope Detection output in time axis after passing through LPF with index of 1.5');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(envolpout3,fs)  %spectrum analyzer plot for envelope detection output with index of 1.5
title(' spectrum analyzer plot for envelope detection i.e after passing LPF output with index of 1.5')                              


?
%D.USE REAL WAVEFORMS
time=0:0.0001:20;
% Load handel function
%a
load handel.mat;  %load handel file
hfile='handel.wav';
%b .listen to music 
Fs=8192;
soundsc(y,Fs);
%c
fil=filter(Num,1,y);        %Filter Num1 is a lowpass filter with Fs=8192, Fpass=2000, Fstop=2500
soundsc(fil,Fs);         %listen filtered audio file
figure(1)
plot(time(1:1000),fil(1:1000));
title('Filtered output');
xlabel('time');
ylabel('amplitude');

%d upsample and resample the fil i.e five times the sampling rate
upsample=resample(fil,5,1);
Fs1=40960;
%e  listen to the upsample music
soundsc(upsample,Fs1);

%f creating a new time axis w.r.to upsample music
time1=length(upsample)/Fs1;
timenew=1:1/40960:time1;
%g creating a sinusoid carrier with 15000 hertz
c1=cos(2*pi*15000*timenew);
% h  creating a large career AM signal

newsignal=upsample(1:length(timenew)); %to get the same sample size as time1 
LCAM = (1+newsignal).*c1';   %modulating the audio file with the carrierwave
% i

figure(2)
plot(timenew(1:1000),newsignal(1:1000));
title('newmodulating signal');
xlabel('time');
ylabel('amplitude');

SpectrumAnalyzer(newsignal,Fs1);
title('spectrum analyzer output for newsignal');

figure(3)
plot(timenew(1:1000),LCAM(1:1000));
title('modulated wave');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(LCAM,Fs1); 


%j coherent demodulation


% (A) by Coherent Demodulation
det=LCAM.*c1';              %multiplying the signal with the carrier again to obtain the audio signal
 
filt=filter(Num1,1,det);      %filter Num5 is a lowpass filter with
 
plot(timenew(1:1400),filt(1:1400));
title('coherent detection output');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(filt,40960) ;


% (B) by Envelope Detection
outt=LCAM.*(LCAM>0);          %passing the signal through an ideal diode
plot(timenew(1:4000),outt(1:4000));
title('ideal diode output');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(outt,40960)  %spectrum analyzer output from the diode
 

filt1=filter(Num1,1,outt);    %Re-Filtering the signal with same FS=40960,FSTOP=2500,FPASS=2000; parameters
soundsc(filt1,40960);		%listening to the output re-constructed signal
					 
plot(timenew(1:5000),filt1(1:5000));
title(' output');
xlabel('time');
ylabel('amplitude');
SpectrumAnalyzer(filt1,40960) %Spectrum analyzer output for demodulated signal through envelope detection
