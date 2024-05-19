%
%  sf_Zhao_Baker_function.m  ver 1.0  July 14, 2014
%
%  Zhao_Baker rainflow cycle counting from a PSD
%
function[DZB]=sf_Zhao_Baker(fi,ai,m,A,df,grms,T,EP,m0,m1,m2,m4,alpha_2)
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
alpha=8-7*alpha_2;
%
if(alpha_2 < 0.9)
    beta=1.1;
else
    beta=1.1+9*(alpha_2-0.9);
end
%
wn=1-alpha_2;
wd=1-sqrt(2/pi)*gamma(1+(1/beta))*alpha^(-1/beta);
w=wn/wd;
%
sqrt_m0=sqrt(m0);
%
area=0;
for i=1:n
%    
    S(i)=(i-1)*ds;
%
    Z=S(i)/sqrt_m0;
    dZ=ds/sqrt_m0;
%    
    N(i)=w*alpha*beta*(Z^(beta-1))*exp(-alpha*Z^beta) + (1-w)*Z*exp(-Z^2/2);
    area=area+(Z^m)*N(i)*dZ;
end
%
DZB=(area*EP*T/A)*(sqrt_m0^m);
%