

%    iband:   1=lowpass  2=highpass  3=bandpass 
%
%    iphase=1  for refiltering for phase correction
%          =2  for no refiltering
%
clear length;

iband=3;
iphase=2;

FS = 'accel_synth';
THM=evalin('base',FS);

%
t=THM(:,1);
yy=THM(:,2);
%
n=length(t);
dt=(t(n)-t(1))/(n-1);


[fl,fc,fu,imax]=one_third_octave_frequencies();

n=length(fc);

for i=1:n
    
    if(fc(i)>=20 && fc(i)<=2100)
        
        clear ms;
        
        [y,mu,sd,rms]=Butterworth_filter_function_alt(yy,dt,iband,fu(i),fl(i),iphase);
       
        ms=rms^2;  
        
        df=fu(i)-fl(i);
        out1=sprintf(' %8.5g %8.5g %8.5g %8.5g %8.5g %8.5g %8.5g ',fl(i),fc(i),fu(i),df,rms,ms,ms/df);
        disp(out1);
    end
    
end