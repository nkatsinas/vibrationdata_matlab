%
%   interpolate_PSD_spec_ers.m  ver 1.0  November 3, 2015
%
function[fft_freq,spec]=interpolate_PSD_spec_ers(np,freq,amp,slope,df)
%
%% out5 = sprintf('\n Interpolating specification ');
%% disp(out5);
%
fft_freq = linspace(0,(np-1)*df,np);
fft_freq = fft_freq';
%
spec=zeros(np,1);
%
ls=length(freq);
%
x=zeros((ls+4),1);
y=(1.0e-30)*ones((ls+4),1);
%
x(3:(ls+2))=freq;
y(3:(ls+2))=amp;
%
x(1)=1.0e-90;
x(2)=x(3)*0.999;
x(ls+3)=x(ls+2)*1.00001;
x(ls+4)=x(ls+3)*10000;
%
x=log10(x);
Y=log10(y);
%
fft_freq(1)=1.0e-80;
%
xi=log10(fft_freq);
%
nx=length(x);
for i=2:nx
    if(x(i)<=x(i-1))
        x(i)=x(i-1)+0.0001;
    end
end

nxi=length(xi);
for i=2:nxi
    if(xi(i)<=xi(i-1))
        xi(i)=xi(i-1)+0.0001;
    end
end

%
%% disp(' ');
%% disp('   interp1 ');
yi = interp1(x,Y,xi);
%
%% disp('   calculate spec ');
%
spec=10.^yi;
%
%% disp('   check spec ');
%
for i=1:length(yi);
    if(spec(i)>=0 && spec(i)<=1.0e+20)
    else
        spec(i)=0;
    end    
end
%
%% disp('   end interpolation ');