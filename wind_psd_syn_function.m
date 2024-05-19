%
% wind_psd_syn_function.m  ver 1.0  by Tom Irvine
%
%  This script synthesizes a time history to satisfy a wind psd
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input variables:
%
%      hours = duration in hours
%        psd = two column array:  freq(Hz) & pressure(psi^2/Hz)
%         sr = sample rate, should be >= 10x highest frequency
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output array:
%
%     psd_synthesis = two column array:  Time(sec) & pressure(psi)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  External arrays:
%
%    psd_syn_data_entry
%    PSD_syn_white_noise
%    interpolate_PSD_spec
%    PSD_syn_FFT_core
%    PSD_syn_scale_time_history
%    fix_size
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[psd_synthesis]=wind_psd_syn_function(hours,psd,sr)

tic

THM=psd; 
 
dur=3600;
 
dt=1/sr;

npd=ceil(dur/dt);

n=2^(ceil(log2(dur/dt)));
 
np=n; 

fprintf('\n dt=%8.4g   n=%8.4g   \n\n',dt,n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
if(THM(1,1)<1.0e-09)  % check for zero frequency
    THM(1,1)=10^(floor(-0.1+log10(THM(2,1))));
end
%
if(THM(1,2)<1.0e-30)  % check for zero amplitude
    noct=log(THM(2,1)/THM(1,1))/log(2);
    THM(1,2)=(noct/4)*THM(2,2);         % 6 db/octave 
end
%
nsz=max(size(THM));
freq=zeros(nsz+1,1);
amp=zeros(nsz+1,1);
%
k=1;
for i=1:nsz
    if(THM(i,1)>0)
        amp(k)=THM(i,2);
        freq(k)=THM(i,1);
        k=k+1;
    end
end  
%
freq(nsz+1)=freq(nsz)*2^(1/48);
amp(nsz+1)=amp(nsz);
%
%%%%%%%%%%%%%%%%%%%
%

[~,slope,rms] = psd_syn_data_entry(freq,amp,nsz,nsz);

freq=fix_size(freq);
 amp=fix_size(amp);

tmax=dur;

%
%  Interpolate PSD spec
%

df=1/(np*dt);
[~,spec]=interpolate_PSD_spec(np,freq,amp,slope,df);
%
fmax=max(freq);

nsegments = 1;
%
sq_spec=sqrt(spec);

rhd=ceil(hours);

for ijk=1:rhd
    
    fprintf('\n ** %d of %d **  \n',ijk,rhd);
    
%   
%  Generate White Noise 
%
    [np,white_noise,~]=PSD_syn_white_noise(tmax,dt,np);
    mmm=round(np/2); 

    [~,psd_th,~]=PSD_syn_FFT_core(nsegments,mmm,np,fmax,df,sq_spec,white_noise);
%
    [~,psd_th,~]=PSD_syn_scale_time_history(psd_th,rms,np,tmax);
    amp=psd_th;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    TT=(0:npd-1)*dt;
    psd_TH=amp;
%
    TT=fix_size(TT);
%
    psd_TH=fix_size(psd_TH);

    TTL=length(TT);
    
    if(ijk==1)
        psd_synthesis=zeros(TTL,2);
    end
    
    ia=TTL*(ijk-1)+1;
    ib=ia+TTL-1;
    psd_synthesis(ia:ib,:)=[TT psd_TH(1:TTL)];

end

TZ=length(psd_synthesis(:,1));
psd_synthesis(:,1)=(0:TZ-1)*dt;

toc

