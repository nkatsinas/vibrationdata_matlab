%
%  wnaccel_generic_psd_syn_correction.m  ver 1.2  by Tom Irvine
%
function[amp,velox,dispx,freq,full,tim,df]=...
      wnaccel_psd_syn_correction(nnt,amp,dt,spec_grms,NW,freq_spec,...
                          amp_spec,mr_choice,h_choice,TT,iunit,spec_rms)
%
tpi=2*pi;
%
fone=freq_spec(1);
%
delta=freq_spec(1)/30;
%
n=length(amp);
%
tim=fix_size(TT);
%
mmm = 2^floor(log(n/NW)/log(2));
mH=mmm/2;
%
df=1/(mmm*dt);
%
freq=zeros(mH,1);
for i=1:mH
    freq(i)=df*(i-1);
end
%
progressbar;
for kvn=1:nnt
    progressbar(kvn/nnt);
%
    clear amp_seg;
    clear mag_seg;
    clear full;
%
    ratio=(spec_grms/std(amp));
%    
    amp=amp*ratio;    
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
    den=df*(2*NW-1);
    full=full/den;
%
    nlen=length(full);
    
    if(nlen<=1)
        nlen
        disp('nlen warning');
    end
%
    for i=1:nlen-1
%%        out1=sprintf('%d %8.4g  %8.4g  %8.4g  nlen=%d %8.4g',i,freq(i),fone,freq(i+1),nlen,df);
%%        disp(out1);
        if( freq(i)<=fone && fone<=freq(i+1) )
            x=fone-freq(i);
            c2=x/(freq(i+1)-freq(i));
            c1=1-c2;
            psd1= c1*full(i) +c2*full(i+1);
            break;
        end
    end  
%
    sza=size(amp);
    na=sza(1);
%
    if(psd1<amp_spec(1) && kvn < nnt)
        ca=0.94*sqrt(2)*sqrt(amp_spec(1)*df-psd1*df);
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
        amp=amp+ca*sin(tpi*fff*tim(1:na)+pha);
%
    end
%
end
%
progressbar(1);
%
kvn=1;
[amp,velox,dispx]=velox_correction(amp,dt,kvn,freq_spec(1),iunit);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
amp=amp*(spec_grms/std(amp));
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
amp=fix_size(amp);