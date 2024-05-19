
% =spectal_moments_oct.m  ver 1.0  by Tom Irvine

function[EP,vo,m0,m1,m2,m4]=spectal_moments_oct(fi,ai)

m0=0;
m1=0;
m2=0;
m4=0;
%
num=length(ai);
%
for i=1:num
%    
    if(i==1)
        ddf=fi(2)-fi(1);
    end
    if(i>=2 && i<=(num-1))
        f1=fi(i-1);
        f2=fi(i);
        f3=fi(i+1);
        ddf=sqrt(f3*f2)-sqrt(f2*f1);
    end    
    if(i==num)
        ddf=fi(num)-fi(num-1);
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