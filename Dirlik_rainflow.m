disp(' ')
disp(' Dirlik_rainflow.m   ver 1.6   July 1, 2014')
disp(' by Tom Irvine   Email: tom@vibrationdata.com')
disp(' ')
disp(' This program calculates the Dirlik rainflow range histogram for a ');
disp(' response power spectral density. ');
disp(' ');
disp(' The response power spectral density may vary arbitrarily with frequency. ');
disp(' The input file must have two columns: frequency(Hz) & psd(units^2/Hz)');
disp(' ')
%
close all;
%
clear cumu;
clear N;
clear S;
clear THF;
%
fig_num=1;
%
disp(' Select file input method       ');
disp('   1=external ASCII file        ');
disp('   2=file preloaded into Matlab ');
file_choice = input('');
%
if(file_choice==1)
    [filename, pathname] = uigetfile('*.*');
    filename = fullfile(pathname, filename);
    fid = fopen(filename,'r');
    THF = fscanf(fid,'%g %g',[2 inf]);
    THF=THF';
end
if(file_choice==2)
    THF = input(' Enter the matrix name:  ');
end
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
%
if(f(1)>=10)
    df=1;
else
    df=10^(floor(log10(f(1))));
end    
[fi,ai]=interpolate_PSD(f,a,s,df);
%
disp(' ');
T=input(' Enter the duration (sec)   ');
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
    m0=m0+ai(i)*df;
    m1=m1+ai(i)*fi(i)*df;
    m2=m2+ai(i)*fi(i)^2*df;
    m4=m4+ai(i)*fi(i)^4*df;
end

%
[D1,D2,D3,R,Q,EP]=Dirlik_coefficients(m0,m1,m2,m4);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
maxS=8*grms;
%
ds=maxS/800;
%
n=round(maxS/ds);
%
N=zeros(n,1);
S=zeros(n,1);
cumu=zeros(n,1);
%
area=0;
cum=0;
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
figure(fig_num);
fig_num=fig_num+1;
%
plot(THF(:,1),THF(:,2));
out1=sprintf('Response Power Spectral Density  Overall Level=%8.3g RMS',grms);
title(out1);
xlabel('Frequency (Hz)');
ylabel('PSD (units^2/Hz)');
grid;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
figure(fig_num);
fig_num=fig_num+1;
plot(S,N);
title('Histogram of Range (peak-valley)');
xlabel('Range');
ylabel('Counts');
grid on;
%
figure(fig_num);
fig_num=fig_num+1;
plot(S,cumu);
title('Cumulative Histogram of Range (peak-valley)');
xlabel('Range');
ylabel('Count Running Sum');
grid on;
%
ts=[cumu S];
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
out1=sprintf('\n Number of expected acceleration range = %d \n',num);
disp(out1);
%
disp(' ');
disp(' The following arrays are stored in descending order:');
disp(' ');
disp(' The range values     (peak-valley)    : range ');
disp(' The amplitude values (peak-valley)/2  : amp ');
%
disp(' ');
disp(' Calculate relative fatigue damage index?  1=yes 2=no ');
ifat=input(' ');
%
clear length;
clear b;
if(ifat==1)
    disp(' ');
    b=input(' Enter fatigue exponent b   ');
    d=0;
    for i=1:length(amp)
        d=d+amp(i)^b;
    end    
    disp(' ');
    out1=sprintf(' Relative fatigue damage index from amplitude = %8.4g  ',d);
    disp(out1);
end
%
clear length;
c=ones(length(amp),1);
dirlik_amp_cycles=[amp c];
%
fd=0;
for i=1:n
    S(i)=(i-1)*ds;
    fd=fd+(S(i)^b)*N(i)*ds;
end
fd=fd/(2^b)