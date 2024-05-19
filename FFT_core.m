%    
%   FFT_core.m  version 1.9   by Tom Irvine 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%     amp_seg = segment amplitude (unit)
%
%        mmm = samples per segment
%         mH = floor((mmm/2)-1) - half the number of samples rounded down
%
%     mr - mean removal - 1=yes  2=no
%     window - 1=Rectangular  2=Hanning   3=Flat Top
%
%         Hanning window recommended for stationary vibration.
%         Use rectangular otherwise.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variable
%
%     mag_seg = segment power spectrum (unit rms)^2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External Function
%
%       mean_removal_Hanning
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[mag_seg]=FFT_core(amp_seg,mmm,mH,mr_choice,h_choice)
%
clear mag_seg;
clear Y;
clear z;
clear H;
%
mu=mean(amp_seg);
if(mr_choice==1 && h_choice==1)
   amp_seg=amp_seg-mu;
end
%
if(h_choice>=2)
    [amp_seg]=mean_removal_Hanning(amp_seg,mr_choice,h_choice);
end
%
%disp(' ')
%disp(' begin FFT ')
%disp(' ')
%
Y = fft(amp_seg);
%
Ymag=abs(Y);
mag_seg(1)=(Ymag(1)/mmm)^2; 
%
mag_seg(2:mH)=2*Ymag(2:mH)/mmm;
mag_seg(2:mH)=(mag_seg(2:mH).^2)/2.;  