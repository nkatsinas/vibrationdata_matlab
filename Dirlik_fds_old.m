%
%  Dirlik_fds.m  ver 1.0  November 9, 2013
%
function[d]=Dirlik_fds(THF,bex,oct,T,df)
%
size(THF);
f=THF(:,1);
a=THF(:,2);
%
if(f(1)<=1.0e-20)
    f(1)=[];
    a(1)=[];
end
%
[s,grms]=calculate_PSD_slopes(f,a);
fi=f;
ai=a;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear length;
n=length(fi);
%
m0=0;
m1=0;
m2=0;
m4=0;
for i=1:n
%    
    m0=m0+a(i)*df;
    m1=m1+ai(i)*fi(i)*df;
    m2=m2+ai(i)*fi(i)^2*df;
    m4=m4+ai(i)*fi(i)^4*df;
end
%
%% out1=sprintf(' m0=%8.4g  m1=%8.4g  m2=%8.4g  m4=%8.4g ',m0,m1,m2,m4);
%% disp(out1);
%
[D1,D2,D3,R,Q,EP]=Dirlik_coefficients(m0,m1,m2,m4);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
maxS=8*grms;
%
ds=maxS/400;
%
n=round(maxS/ds);
%
N=zeros(n,1);
S=zeros(n,1);
cumu=zeros(n,1);
%
area=0;
for i=1:n
    S(i)=(i-1)*ds;
    Z=S(i)/(2*sqrt(m0));
%    
    t1=(D1/Q)*exp(-Z/Q);
    a=-Z^2;
    b=2*R^2;
%    
    t2=(D2*Z/R^2)*exp(a/b);
    t3=D3*Z*exp(-Z^2/2);
%    
    pn=t1+t2+t3;
    pd=2*sqrt(m0);
    p=pn/pd;
%    
    N(i)=p;
end
N=N*EP*T;
%
for i=1:n
    area=area+N(i)*ds;
    cumu(i)=area;
end
%
num=ceil(cumu(n));
%
xq=zeros(num,1);
for i=1:num
    xq(i)=i;
end
%
vq1 = interp1(cumu,S,xq);
%
clear A;
clear range;
clear amp;
%
A=[xq vq1];
A(any(isnan(A),2),:)=[];
range=A(:,2);
range=sort(range,'descend');
amp=range/2;
%
d=0;
for i=1:length(amp)
    d=d+amp(i)^bex;
end    