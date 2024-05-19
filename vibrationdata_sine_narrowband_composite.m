%
%   vibrationdata_sine_narrowband_composite.m  ver 1.2  by Tom Irvine
%
function[nb_psd_amp]=vibrationdata_sine_narrowband_composite(fc,f1,f2,T,A,b,Q)
%
fn=fc;

% R = response accel

R=Q*A;

damp=1/(2*Q);

sine_damage=(fc*T)*R^b;

psd_amp=1;

%%%

f(1)=f1;

u=2^(1/(2*96));

for i=2:200
    f(i)=f(i-1)*u;
    if( f(i)>=f2)
        break;
    end
end

nF=length(f);

opsd=zeros(nF,1);

%%%

k=(u-(1/u))/2;

for j=1:nF 
%
    rho = f(j)/fn;
	tdr=2.*damp*rho;
%
    c1= tdr^ 2.;
	c2= (1.- (rho^2.))^ 2.;
%
	trans = (1.+ c1 ) / ( c2 + c1 );
%
    opsd(j)=trans*psd_amp;   
%
end


%%%

m0=0;
m1=0;
m2=0;
m4=0;

for i=1:nF
%    
    df=f(i)*k;

    m0=m0+opsd(i)*df;
    m1=m1+opsd(i)*f(i)*df;
    m2=m2+opsd(i)*f(i)^2*df;
    m4=m4+opsd(i)*f(i)^4*df;
end

EP=sqrt(m4/m2);

grms=sqrt(m0);

[psd_damage]=Dirlik_basic(T,b,m0,m1,m2,m4,EP,grms);


scale=(sine_damage/psd_damage)^(1/b);

nb_psd_amp=psd_amp*scale^2;
