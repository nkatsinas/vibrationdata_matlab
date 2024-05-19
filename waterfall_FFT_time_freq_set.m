%
%   waterfall_FFT_time_freq_set.m  ver 1.1   by Tom Irvine
%
function[mk,freq,time_a,dt,NW]=...
                      waterfall_FFT_time_freq_set(mmm,NW,dt,df,maxf,tmi,io)
%
md2=floor(mmm/2);
freq=zeros(md2,1);
for i=1:md2
    freq(i)=(i-1)*df;
    if(freq(i)>maxf)
        break;
    end
end
mk=max(size(freq));
t1=tmi+(dt*mmm/2);


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
