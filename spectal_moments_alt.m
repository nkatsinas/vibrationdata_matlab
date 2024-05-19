
% spectal_moments_alt.m  ver 1.0  by Tom Irvine

function[EP,vo,m0,m1,m2,m4,alpha2,e]=spectal_moments_alt(fi,ai,df)

m0=0;
m1=0;
m2=0;
m4=0;
%
num=length(ai);
%
for i=1:num
%    
    ddf=df;
    
    if(i==1 || i==num)
        ddf=df/2.;
    end

    m0=m0+ai(i)*ddf;
    m1=m1+ai(i)*fi(i)*ddf;
    m2=m2+ai(i)*fi(i)^2*ddf;
    m4=m4+ai(i)*fi(i)^4*ddf;
%    
end
%

vo=sqrt(m2/m0);
EP=sqrt(m4/m2);

alpha2=m2/sqrt(m0*m4);
e=sqrt(1-alpha2);
