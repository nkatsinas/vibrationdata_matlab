%
%  Dirlik_fds.m  ver 1.1   by Tom Irvine
%
function[d]=Dirlik_fds(THF,bex,T,df)
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
% [s,grms]=calculate_PSD_slopes(f,a);
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
m=bex;
A=1;
[d]=sf_Dirlik(m,A,T,m0,m1,m2,m4);
