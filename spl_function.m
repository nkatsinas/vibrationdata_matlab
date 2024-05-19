%
% spl_function.m  ver 1.0  by Tom Irvinwe
%
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%     mr - mean removal - 1=yes  2=no
%     window - 1=rectangular  2=Hanning
%
%         Hanning window recommended for stationary vibration.
%         Use rectangular otherwise.
%
%     t1 & t2 - start and end times (sec) respectively
%
%     THM - time history - two columns - time(sec) & pressure(psi)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variables  Ref: 20 micro Pa
%
%      spl - one-third octave format - center frequency(Hz) & spl(dB)
%    oaspl - overall sound pressure level(dB) 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functinons
%
%     spl_core.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[spl,oaspl]=spl_function(mr,window,t1,t2,THM)

[~,i]=min(abs(t1-THM));
[~,j]=min(abs(t2-THM));

THM=THM(i:j,:);

tdif=diff(THM(:,1));

min_dt=min(tdif);
max_dt=max(tdif);

ratio=abs((max_dt-min_dt)/max_dt);

if(ratio>0.05)
    fprintf('\n\n min_dt=%8.4g  max_dt=%8.4g \n\n',min_dt,max_dt);
    warndlg('Time step must be constant');
    return;
end

t=THM(:,1);
amp=THM(:,2);

%%%%%

n=length(t);

dur=t(end)-t(1);
nj=floor(log2(n));

njt=min([12 nj]);

    num_seg=zeros(njt,1);
   time_seg=zeros(njt,1);
samples_seg=zeros(njt,1);
        ddf=zeros(njt,1);

for i=1:njt
    num_seg(i)=2^(i-1);
    time_seg(i)=dur/num_seg(i);
    samples_seg(i)=floor(n/num_seg(i));
    ddf(i)=1/time_seg(i);
end    

[~,nv]=min(abs( ddf-1));

df=ddf(nv);

NW=num_seg(nv);
mmm=samples_seg(nv);

fprintf('\n NW=%d  statdof=%d  df=%8.4g Hz  \n\n',NW,NW*2,df);

%%%%

[spl,oaspl]=spl_core(mmm,NW,mr,window,amp,df);


