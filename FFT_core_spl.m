%    
%   FFT_core_spl.m  version 1.7   by Tom Irvine 
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
%     window - 1=rectangular  2=Hanning
%
%         Hanning window recommended for stationary vibration.
%         Use rectangular otherwise.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variable
%
%     mag_seg = segment magnitude (unit peak)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[mag_seg]=FFT_core_spl(amp_seg,mmm,mH,mr_choice,h_choice)
%
clear mag_seg;
clear Y;
clear z;
clear H;
%
mu=mean(amp_seg);
if(mr_choice==1)
   amp_seg=amp_seg-mu;
%  amp_seg=detrend(amp_seg);
end
%
if(h_choice==2)
%   disp(' Hanning window '); 
    alpha=linspace(0,2*pi,mmm);
    H=0.5*(1-cos(alpha));
    ae=sqrt(8./3.);
%
    sz=size(H);
    if(sz(2)>sz(1))
        H=H';
    end
%    
    amp_seg=ae*amp_seg.*H;
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
mag_seg(2:mH)=(mag_seg(2:mH))/2;  