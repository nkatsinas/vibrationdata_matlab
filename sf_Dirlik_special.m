%
%  sf_Dirlik_function.m  ver 1.0  July 7, 2014
%
%  Dirlik rainflow cycle counting from a PSD
%
function[DDK]=sf_Dirlik_special(fi,ai,m,A,df,grms,T,EP,m0,m1,m2,m4)
%
[D1,D2,D3,R,Q,EP]=Dirlik_coefficients(m0,m1,m2,m4);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Note that range = (peak-valley)
%
%  maxS is the assumed upper limit of the the histogram.
%
%  The value 8*grms is used as conservative estimate of the upper
%  range maxS for all cycles.  
%
%  The histogram will have 400 bins.  This number is chosen
%  via engineering judgement.
%
%    ds is the bin range width       
%     n is the number of bins
%     N is the cycle count per bin
%     S is the range level for each bin
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
    area=area+(S(i)^m)*N(i)*ds;
end
%
tau=T;
EP_tau=EP*tau;

out1=sprintf(' max(N)=%7.3g  sum(N)=%7.3g \n',max(N),sum(N));
disp(out1);

out1=sprintf(' m0=%8.4g \n m1=%8.4g  \n m2=%8.4g  \n m4=%8.4g \n',m0,m1,m2,m4);
disp(out1);

out1=sprintf(' EP_tau=%7.3g maxS=%7.3g ds=%7.3g  ',EP_tau,maxS,ds);
disp(out1);

DDK=(area*EP_tau/A)/(2^m);
%
figure(907)
plot(S,N*EP_tau);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
grid;



