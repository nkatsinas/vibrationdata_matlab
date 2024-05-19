%
%  gust_PSD_syn_velox_correction.m  ver 1.2  November 16, 2012
%
function[amp,dispx,full,tim]=...
     gust_PSD_syn_velox_correction(nnt,amp,dt,spec_vrms,mH,NW,freq_spec,...
                                amp_spec,df,mr_choice,h_choice,den,freq,TT)
%
tpi=2*pi;
%
n=length(amp);
%
tim=fix_size(TT);
%
mmm = 2^fix(log(n/NW)/log(2));
%
progressbar;
for kvn=1:nnt
    progressbar(kvn/nnt);
%
    clear amp_seg;
    clear mag_seg;
    clear full;
%
    [amp,dispx]=gust_velox_correction(amp,dt,kvn,freq_spec(1));
%
      amp=fix_size(amp);
    dispx=fix_size(dispx);
%
    ratio=(spec_vrms/std(amp));
%    
    amp=amp*ratio;
    dispx=dispx*ratio;  
%
    full=zeros(mH,1);
%
    nov=0;
%
    for ijk=1:(2*NW-1)
%
        amp_seg=zeros(mmm,1);
        amp_seg(1:mmm)=amp((1+ nov):(mmm+ nov));  
        nov=nov+fix(mmm/2);
%
        [mag_seg]=FFT_core(amp_seg,mmm,mH,mr_choice,h_choice);
%
        mag_seg=fix_size(mag_seg);
%
        full=full+mag_seg(1:mH);
    end
%
    full=full/den;
%
    nlen=length(full);
%
    for i=1:nlen-1
        if( freq(i)<=freq_spec(1) && freq_spec(1)<=freq(i+1) )
            x=freq_spec(1)-freq(i);
            c2=x/(freq(i+1)-freq(i));
            c1=1-c2;
            psd1= c1*full(i) +c2*full(i+1);
            break;
        end
    end  
%
    if(psd1<amp_spec(1) && kvn < nnt)  % leave upper limit as is
        ca=sqrt(2)*sqrt(amp_spec(1)*df-psd1*df)/sqrt(3);
%
        pha=tpi*rand;
        fff=freq(i);
        amp=amp+ca*sin(tpi*fff*tim+pha);
%
        pha=tpi*rand;
        fff=freq_spec(1);
        amp=amp+ca*sin(tpi*fff*tim+pha);
%
        pha=tpi*rand;
        fff=freq(i+1);
        amp=amp+ca*sin(tpi*fff*tim+pha);
%
    end
%
end
%
progressbar(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
amp=amp*(spec_vrms/std(amp));
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
amp=fix_size(amp);