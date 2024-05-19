close all;

fig_num=1;

num=input(' enter num ')

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


ax=0.5;
[ps]=risk_overshoot(fn,tmax,ax);

QC=zeros(num,5);

disp(' i   Trial   Mean    Median   Expected 50%');

progressbar;

for i=1:num    

    progressbar(i/num);
    
    Q=[1+99*rand()];
    
    if(i==1)
        Q=1;
    end
    if(i==2)
        Q=50;
    end
    if(i==3)
        Q=100;
    end
        
    
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
    
    
    
    out1=sprintf(' %d  %8.4g   %8.4g  ',i,Q,crest);
    disp(out1);
    
end
pause(0.2);
progressbar(1);


figure(fig_num);
fig_num=fig_num+1;
plot(QC(:,1),QC(:,2),'.');
grid on;
xlabel('Amplification Factor Q');
ylabel('Crest Factor');
title('Crest Factor vs. Q');

x=QC(:,1);
y=QC(:,2);
P = polyfit(x,y,1);
yfit = P(1)*x+P(2);
P(1)
P(2)


figure(fig_num);
fig_num=fig_num+1;
hold on;
plot(QC(:,1),QC(:,2),'.');
plot(x,yfit,'linewidth',1.0);
grid on;
xlabel('Amplification Factor Q');
ylabel('Crest Factor');
title('Crest Factor vs. Q');
hold off;


figure(fig_num);
fig_num=fig_num+1;
plot(QC(:,2),QC(:,3),'.');
grid on;
xlabel('Crest Factor');
ylabel('pzcr');
title('pzcr vs Crest Factor');

figure(fig_num);
fig_num=fig_num+1;
plot(QC(:,2),QC(:,3),'.'); 
grid on;
xlabel('Crest Factor');
ylabel('peak rate');
title('peak rate vs Crest Factor');

figure(fig_num);
fig_num=fig_num+1;
plot(QC(:,1),QC(:,3),'.');
grid on;
xlabel('Q');
ylabel('pzcr');
title('pzcr vs. Q');

figure(fig_num);
fig_num=fig_num+1;
plot(QC(:,1),QC(:,4),'.');
grid on;
xlabel('Q');
ylabel('peak rate');
title('peak rate vs. Q')

figure(fig_num);
fig_num=fig_num+1;
plot(QC(:,1),QC(:,5),'.');
grid on;
xlabel('Q');
ylabel('Kurtosis');
title('Kurtosis vs. Q')

x=QC(:,1);
y=QC(:,5);
P = polyfit(x,y,1);
yfit = P(1)*x+P(2);
P(1)
P(2)

figure(fig_num);
fig_num=fig_num+1;
hold on;
plot(QC(:,1),QC(:,5),'.');
plot(x,yfit);
grid on;
xlabel('Amplification Factor Q');
ylabel('Kurtosis');
title('Kurtosis vs. Q');
hold off;