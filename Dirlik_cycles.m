%
%  Dirlik_cycles.m  ver 1.2   Tom Irvine
%
%  Dirlik rainflow cycle counting from a PSD
%
function[range,amp,EP]=Dirlik_cycles(THF,T)
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
difff=diff(f);
dfmin=min(difff);
dfmax=max(difff);
%
if( abs(dfmax-dfmin) > 1.25*dfmin)
    
    df=f(1)/20;
    if(df==0)
        df=0.1;
    end
    
    [s,grms]=calculate_PSD_slopes(f,a);
    [fi,ai]=interpolate_PSD(f,a,s,df);
else
    np=length(f);
    df=(f(np)-f(1))/(np-1);
    fi=f;
    ai=a;
end    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear sum;
grms=sqrt(sum(ai)*df);  % grms is the RMS value of PSD
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear length;

%
[EP,vo,m0,m1,m2,m4]=spectal_moments(fi,ai,df);
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
end
%
N=N*EP*T;
%
for i=1:n
    area=area+N(i)*ds;
    cumu(i)=area;
end
%
%  The following steps are performed to interpolate the cumulative
%  histogram function to find the amplitude of each cycle.
%
%  The goal is to effectively interpolate the cumulative histogram so
%  that each bin has only one additional cycle.  The corresponding 
%  amplitude is then taken as the upper limit of each bin.
%
%   xq is running sum of the cycles 
%  vq1 is the range (peak-valley) for each cycle
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
A(any(isnan(A),2),:)=[];  % This is done to eliminate rows with NaN
%
%  The interpolated cumulative histogram could be plotted as: 
%  plot(A(:,2),A(:,1))
%
range=A(:,2);
range=sort(range,'descend');
amp=range/2;
%
%% out1=sprintf('\n Number of expected acceleration range = %d \n',num);
%% disp(out1);
%
%% disp(' ');
%% disp(' The following arrays are stored in descending order:');
%% disp(' ');
%% disp(' The range values     (peak-valley)    : range ');
%% disp(' The amplitude values (peak-valley)/2  : amp ');
%