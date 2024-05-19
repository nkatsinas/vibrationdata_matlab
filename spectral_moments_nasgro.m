
%   spectral_moments_nasgro.m  ver 1.1  by Tom Irvine

%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions
% 
%      Dirlik_coefficients
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[m0,m1,m2,m4,M2m,Mkp2,m0p75,m1p5,vo,EP,alpha2,e,D1,D2,D3,Q,R]=...
                                      spectral_moments_nasgro(n,B,ai,fi,df)

m0=0;
m1=0;
m2=0;
m4=0;
M2m=0;
Mkp2=0;
m0p75=0;
m1p5=0;
%
m=B;
ae=2/m;
be=ae+2;
%
%
for i=1:n
%    
    m0=m0+ai(i)*df;
    m1=m1+ai(i)*fi(i)*df;
    m2=m2+ai(i)*fi(i)^2*df;
    m4=m4+ai(i)*fi(i)^4*df;
    
    M2m=M2m+ai(i)*fi(i)^ae*df;
    Mkp2=Mkp2+ai(i)*fi(i)^be*df;
%    
    m0p75=m0p75+ai(i)*fi(i)^0.75*df;
    m1p5=m1p5+ai(i)*fi(i)^1.5*df;
%
end
%
vo=sqrt(m2/m0);
alpha2=m2/sqrt(m0*m4);
e=sqrt(1-alpha2);

[D1,D2,D3,R,Q,EP]=Dirlik_coefficients(m0,m1,m2,m4);