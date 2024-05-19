%
%  psd_core.m  ver 1.4  by Tom Irvine
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  External functions
%
%    fix_size.m
%    FFT_core.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[freq,full,rms]=FFT_core(mmm,NW,mr_choice,h_choice,amp,df)
%
%%%  begin overlap
%
    mH=floor((mmm/2)-1);
%
    full=zeros(mH,1);
%
    nov=0;
%
    clear amp_seg
%
    for ijk=1:(2*NW-1)
%
        amp_seg=zeros(mmm,1);
%
        try 
            amp_seg(1:mmm)=amp((1+ nov):(mmm+ nov));
        catch
            fprintf(' ijk=%d  NW=%d  mmm=%d  nov=%d  length(amp)=%d \n',ijk,NW,mmm,nov,length(amp));
            warndlg(' amp_seg error ');
            return;
        end
%
        nov=nov+fix(mmm/2);
%
        [mag_seg]=FFT_core(amp_seg,mmm,mH,mr_choice,h_choice);
%
        mag_seg=fix_size(mag_seg);
%
        full=full+mag_seg(1:mH);
    end
%
    den=df*(2*NW-1);
    fmax=(mH-1)*df;
    freq=linspace(0,fmax,mH);
    full=full/den;
    clear sum;
    ms=sum(full);
%
    rms=sqrt(ms*df);
    
    freq=fix_size(freq);
    full=fix_size(full);