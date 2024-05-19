%
%  Dirlik_basic.m  ver 1.1  Tom Irvine
%
function[damage]=Dirlik_basic(duration,bex,m0,m1,m2,m4,EP,grms)
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
N=N*EP*duration;
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
cumu=fix_size(cumu);
S=fix_size(S);

A=[cumu S];


[b,m1,n1] = unique(A(:,1));

N=length(m1);
B=zeros(N,2);
for i=1:N
    B(i,:)=A(m1(i),:);
end

cumu=B(:,1);
S=B(:,2);


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
damage=0;
for i=1:length(amp)
    damage=damage+amp(i)^bex;
end    