%
%  wnb_PSD_syn_velox_correction.m  ver 1.0  March 10, 2014
%
function[amp,full,tim]=...
      wnb_PSD_syn_velox_correction(nnt,amp,spec_grms,mH,NW,freq_spec,...
                          amp_spec,df,mr_choice,h_choice,den,freq,TT)
%
tpi=2*pi;
%
delta=freq_spec(1)/30;
%
n=length(amp);
%
tim=double(TT(1:n));
tim=fix_size(TT);
%
mmm = 2^fix(log(n/NW)/log(2));
mH=mmm/2;
%
progressbar;
for kvn=1:nnt
    progressbar(kvn/nnt);
%
    clear amp_seg;
    clear mag_seg;
    clear full;
%
%%%    [amp,velox,dispx]=velox_correction(amp,dt,kvn,freq_spec(1),iunit);
%
      amp=fix_size(amp);
%%%    velox=fix_size(velox);
%%%    dispx=fix_size(dispx);
%
    ratio=(spec_grms/std(amp));
%    
    amp=amp*ratio;
%%%    velox=velox*ratio;
%%%    dispx=dispx*ratio;    
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
        [mag_seg]=wnd_FFT_core(amp_seg,mmm,mH,mr_choice,h_choice);
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
    if(nlen<=1)
        nlen
        disp('nlen error');
    end
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
    if(psd1<amp_spec(1) && kvn < nnt)
        ca=sqrt(2)*sqrt(amp_spec(1)*df-psd1*df);
%
        pha=tpi*rand;
%
        fff=freq_spec(1)+(-0.5+rand)*delta;
%
        if(kvn==1)
            fff=freq_spec(1);           
        end
        if(kvn==2)
            fff=freq_spec(1)+delta/2;
        end        
        if(kvn==3)
            fff=freq_spec(1)-delta/2;
        end
%
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
amp=amp*(spec_grms/std(amp));
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
amp=fix_size(amp);