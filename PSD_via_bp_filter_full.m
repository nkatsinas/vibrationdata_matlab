

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


ioct=1;

clear fc;
clear fl;
clear fu;

    oex=1/2;
	fc(1)=20.;
	fc(2)=2*fc(1);
	fc(3)=2*fc(2);
	fc(4)=2*fc(3);
	fc(5)=2*fc(4);
	fc(6)=2*fc(5);
	fc(7)=2*fc(6);
	fc(8)=2*fc(7);
	fc(9)=2*fc(8);

imax=length(fc);

fl=zeros(imax,1);
fu=zeros(imax,1);
fc=fix_size(fc);

	for i=1:imax
			fl(i)=fc(i)/(2.^oex);
	end
	for i=1:(imax-1)
			fu(i)=fl(i+1);	
	end
	fu(imax)=fc(i)*(2.^oex);
    

n=length(fc);

for i=1:n
    
    if(fc(i)>=10 && fc(i)<=3000)
        
        clear ms;
        
        [y,mu,sd,rms]=Butterworth_filter_function_alt(yy,dt,iband,fu(i),fl(i),iphase);
       
        ms=rms^2;  
        
        df=fu(i)-fl(i);
        out1=sprintf(' %8.5g %8.5g %8.5g %8.5g %8.5g %8.5g %8.5g ',fl(i),fc(i),fu(i),df,rms,ms,ms/df);
        disp(out1);
    end
    
end