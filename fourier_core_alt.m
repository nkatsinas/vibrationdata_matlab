%
%  fourier_core_alt.m  ver 1.0  by Tom Irvine
%
function[z,zz,f_real,f_imag,ms,freq,ff,PSD,rms]=fourier_core_alt(df,y,mr_choice,h_choice)
%
tpi=2*pi;

n=length(y);
nhalf=floor(n/2);
mmm=n;

fprintf('\n length(y) = %d \n',n);


mu=mean(y);
if(mr_choice==1 || h_choice==2)
   y=y-mu;
%  y=detrend(y);
end
%
if(h_choice==2)
%   disp(' Hanning window '); 
    alpha=linspace(0,2*pi,mmm);
    H=0.5*(1-cos(alpha));
    ae=sqrt(8./3.);
%
    sz=size(H);
    if(sz(2)>sz(1))
        H=H';
    end
%    
    y=ae*y.*H;
end


%
f_real=zeros(1,n);
f_imag=zeros(1,n);
z=zeros(1,n);
freq=zeros(1,n);
zz=zeros(1,nhalf);
%
%    
for  k=0:(n-1)
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
zz(1)=z(1);
zz(2:nhalf)=2*z(2:nhalf);
%
ms=0.5*sum(zz(1:nhalf).^2);  % include peak to rms conversion
%
ff=freq(1:nhalf);

zz=zz/sqrt(2);
PS=zz.*zz/df;
rms=sqrt(sum(PS)*df);
ff=fix_size(ff);
PS=fix_size(PS);
PSD=[ff PS];