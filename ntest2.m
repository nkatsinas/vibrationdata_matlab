close all;

fig_num=1;

num=input(' enter num ')

Q=input(' enter Q ');

tmax=1200;
sr=20000;
fl=1600;
sigma=1;

m=1;

dt=1/sr;   
np=ceil(tmax/dt);
TT=linspace(0,(np-1)*dt,np); 
  
%%%    [a] = normrnd_function(sigma,np);
 
clear length;
np=length(TT);
 
fn=500;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nbars=60;

ds=8/nbars;

Tcfh=zeros(nbars,1);

upper=zeros(nbars,1);
lower=zeros(nbars,1);
center=zeros(nbars,1);

for i=1:nbars
    upper(i)=ds*i;
    lower(i)=ds*(i-1);
    center(i)=mean([ lower(i) upper(i)]);
end

edges=lower;
edges(end+1)=lower(end)+ds;

ax=0.5;
[ps]=risk_overshoot(fn,tmax,ax);

QC=zeros(num,5);

disp(' i   Trial   Mean    Median   Expected 50%');

progressbar;

for i=1:num    

    progressbar(i/num);
    
    damp=1/(2*Q);

%
%  Initialize coefficients
%
[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt); 
    
    a=randn(np,1);
%
    a=fix_size(a);
%
    a=a-mean(a);
    a=a*sigma/std(a);
%
    if(m==1)
%
%    iband:   1=lowpass  2=highpass  3=bandpass 
%
%    iphase=1  for refiltering for phase correction
%          =2  for no refiltering
%
      iband=1;
      fh=0;
%
    end
  
    if(m<=2)
        
      tstring='Band-limited White Noise';
      
      iphase=2;     
      [a,~,~,~]=Butterworth_filter_function_alt(a,dt,iband,fl,fh,iphase);      
        
%    scale for the std deviation
%
      ave=mean(a);
      stddev=std(a);
      sss=sigma/stddev;
%    
      a=(a-ave)*sss;        
        
    end   
    
    [a_resp,a_pos,a_neg]=arbit_engine(a1,a2,b1,b2,b3,a);
    
     maxa=max([ a_pos  a_neg  ]);
    crest=maxa/std(a_resp);
    
    [pszcr,peak_rate,pa]=zero_crossing_function(a_resp,tmax);
    
    [mu,sd,rms,sk,kt]=kurtosis_stats(a_resp);

    
    QC(i,:)=[Q crest pszcr peak_rate kt];
    
% Peak histogram

    cf=pa/std(a_resp);
    
    L=length(cf);
    
    [cfh,edges] = histcounts(cf,edges);
    cfh=fix_size(cfh);
    
    cfh=cfh/(L*ds);
    
    Tcfh=Tcfh+cfh;
    
    out1=sprintf(' %d  %8.4g   %8.4g  ',i,Q,crest);
    disp(out1);
    
end
pause(0.2);
progressbar(1);

Tcfh=Tcfh/num;

figure(88);
plot(center,Tcfh);
grid on;
title('Absolute Peak Probability Density Function');
xlabel('A');
ylabel('Probability p(A)');

Tcfh=[center Tcfh];
