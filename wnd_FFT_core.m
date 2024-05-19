%    
%   wnd_FFT_core.m  version 1.0    March 10, 2014 ')
%
function[mag_seg]=wnd_FFT_core(amp_seg,mmm,mH,mr_choice,h_choice)
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
Y = fft(amp_seg,mmm);
%
Ymag=abs(Y);
mag_seg(1)=sqrt(Ymag(1))/mmm;
mag_seg(1)=mag_seg(1)^2; 
%
mag_seg(2:mH)=2*Ymag(2:mH)/mmm;
mag_seg(2:mH)=(mag_seg(2:mH).^2)/2.;  