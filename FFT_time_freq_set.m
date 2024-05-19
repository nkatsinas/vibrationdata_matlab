%
%   FFT_time_freq_set.m  ver 1.0  October 18, 2012
%
function[mk,freq,time_a,dt,NW]=FFT_time_freq_set(mmm,NW,dt,df,tmi,io)
%
sr=1/dt;
maxf=sr/2;
%
md2=mmm/2;
freq=zeros(md2,1);
%
for i=1:md2
    freq(i)=(i-1)*df;
    if(freq(i)>maxf)
        freq(i)=[];
        break;
    end
end
mk=max(size(freq));
t1=tmi+(dt*mmm);
%
if(io==1)
    time_a=zeros(NW,1);
    time_a(1)=t1; 
    for i=2:NW
        time_a(i)=time_a(i-1)+dt*mmm;
    end
else
    NW=2*NW-1;
    time_a=zeros(NW,1);
    time_a(1)=t1;     
    dt=dt/2;
    for i=2:NW
        time_a(i)=time_a(i-1)+dt*mmm;
    end    
end