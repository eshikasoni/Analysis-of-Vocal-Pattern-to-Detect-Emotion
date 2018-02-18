%% Load Data for Testing
clc;


load net.mat 
delete svmStruct1.mat
  
[path,file]=uigetfile('*.wav','Load the speech signal');
full_path=strcat(file,path);
 [sig_limited,fs]=audioread(full_path);
      sig_1000=fs/1000;          % maximum speech Fx at 1000Hz
      sig_50=fs/50;              % minimum speech Fx at 50Hz
      sig_500=fs/500;                 % maximum speech Fx at 500Hz
     t=(0:length(sig_limited)-1)/fs;
     Y=fft(sig_limited.*hamming(length(sig_limited))); % taking FFT
     hz5000=5000*length(Y)/fs;
     f=(0:hz5000)*fs/length(Y);
     C=fft(log(abs(Y)+eps));% cepstrum is DFT of log spectrum
     q=(sig_1000:sig_50)/fs; % plotting between 1ms  (1000Hz) and 20ms (50Hz)
     [c,fx]=max(abs(C(sig_1000:sig_50)));
     r_corre=xcorr(sig_limited,sig_50,'coeff'); % calculate autocorrelation  
     d_timw=(-sig_50:sig_50)/fs;   
     r_corre=r_corre(sig_50+1:2*sig_50+1);
     [rmax,tx]=max(r_corre(sig_500:sig_50));
     x=resample(sig_limited,10000,fs); 
     fs=10000;
     lpf=2+fs/1000;           % rule  
     a=lpc(x,lpf);
     [h,f]=freqz(1,a,512,fs);
     r=roots(a);                  % find roots of polynomial a
     r=r(imag(r)>0.01);           % only look for roots >0Hz up to fs/2
     ffreq=sort(atan2(imag(r),real(r))*fs/(2*pi));
     Features = stFeatureExtraction(sig_limited, fs, 0.020, 0.020);
     F = Features(3,:);
     timeFeature = 0.010:0.020:length(x)/fs;
     time = 0:1/fs:length(x)/fs-1/fs;
     MIN1 = min([length(F);length(timeFeature)]);
     timeFeature = timeFeature(1:MIN1);
     F = F(1:MIN1);
    MIN2 = min([length(x);length(time)]);
    time = time(1:MIN2);
    x = x(1:MIN2);
  % [Frt] = spFormantsLpc(sig_limited, fs);
   Ft=Features';
   [mp,np]=size(Ft);
   Ft1=Ft(1:round(mp/2),:);
   Ft2=Ft(round(mp/2):mp,:);
   A1=max(Ft1);
   A2=min(Ft1);
   A3=mean(Ft1);
   A4=std(Ft1);
   A7=median(Ft1);
   A012=entropy(Ft1);
   A10=max(Ft2);
   A20=min(Ft2);
   A30=mean(Ft2);
   A40=std(Ft2);
   A70=median(Ft2);
   A120=entropy(Ft2);
   A201=max(Ft1);
   A202=min(Ft1);
   A203=mean(Ft1);
   A204=std(Ft1);
   A207=median(Ft1);
   Final_feat_test=[A1 A2 A3 A4 A7 A012  A10 A20 A30 A40 A70 A120 A201 A202 A203 A204 A207 ];
%      Final_feat_test =  Final_feat_test/norm( Final_feat_test);
   clear   A1 A2 A3 A4 A7 A012  A10 A20 A30 A40 A70 A120 A201 A202 A203 A204 A207
   clear Ft1 Ft2 mp np Ft
   % Testing using neural network
   
 %% Neural Network Classifier
    
testX1 = Final_feat_test';
%testT = neur_label(:,2);
testY1 = net(testX1);
testIndices1 = vec2ind(testY1);
   if testIndices1==2
       fprintf('The observation using Neural Networks is closely related to FEAR \n')
   else 
       fprintf('The observation using Neural Networks closely related to NOT FEAR \n')
   end 

 %%  SVM Classifier 
 load svmStruct.mat
 result_class = svmclassify(svmStruct, Final_feat_test(:,12:13));
  if result_class==0
       fprintf('The observation using SVM is closely related to NOT FEAR \n')
   else 
       fprintf('The observation using SVM is closely related to FEAR \n')
  end 
