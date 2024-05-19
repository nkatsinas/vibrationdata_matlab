%
%  fourier_core.m  ver 1.1   by Tom Irvine
%
function[z,zz,f_real,f_imag,ms,freq,ff]=fourier_core(n,nhalf,df,y)
%
tpi=2*pi;
%
f_real=zeros(1,n);
f_imag=zeros(1,n);
z=zeros(1,n);
freq=zeros(1,n);
zz=zeros(1,nhalf);
%
disp(' ');
progressbar % Create figure and set starting time
%    
for  k=0:(n-1)
        progressbar(k/n) % Update figure    
%
        clear sum_c;
        clear sum_s;
        clear ccc;
        clear sss;
%
        f_real(k+1)=0.;
        f_imag(k+1)=0.;  
%   
        arg = linspace(0,tpi*k*(n-1)/n,n); 
%
        ccc=y.*cos(arg)';
        sss=y.*sin(arg)';
%
        sum_c=sum(ccc);
        sum_s=sum(sss);
%
        f_real(k+1)=f_real(k+1)+sum_c;
        f_imag(k+1)=f_imag(k+1)+sum_s;
%
        freq(k+1)=k*df;
%       
        f_real(k+1)=f_real(k+1)/n;
        f_imag(k+1)=f_imag(k+1)/(-n);
%
        z(k+1)=((f_real(k+1)^2) + (f_imag(k+1)^2))^(1/2);   
%		  
end
%
progressbar(1);
pause(0.3)
%
zz(1)=z(1);
zz(2:nhalf)=2*z(2:nhalf);
%
ms=0.5*sum(zz(1:nhalf).^2);  % include peak to rms conversion
%
ff=freq(1:nhalf);

z=fix_size(z);
zz=fix_size(zz);
freq=fix_size(freq);
ff=fix_size(ff);
f_imag=fix_size(f_imag);
f_real=fix_size(f_real);