%
%  sf_Dirlik_function.m  ver 1.1  by Tom Irvine
%
%  Dirlik rainflow cycle counting from a PSD
%

function[DDK]=sf_Dirlik(m,A,T,m0,m1,m2,m4)

%
EP=sqrt(m4/m2);
%
x=(m1/m0)*sqrt(m2/m4);
gamm=m2/(sqrt(m0*m4));
%
D1=2*(x-gamm^2)/(1+gamm^2);
R=(gamm-x-D1^2)/(1-gamm-D1+D1^2);
D2=(1-gamm-D1+D1^2)/(1-R);
D3=1-D1-D2;
%
Q=1.25*(gamm-D3-D2*R)/D1;
%
%%%%%%%%%
%



arg=m+1;
gf1=gamma(arg);

arg=0.5*m+1;
gf2=gamma(arg);

t1=D1*(Q^m)*gf1;

t2=(sqrt(2)^m)*gf2*( D2*(abs(R))^m  + D3 );

mh=m/2;

DDK=(EP*T/A)*(m0^mh)*( t1 + t2 );

