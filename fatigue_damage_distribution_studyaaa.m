%
%   fatigue_damage_distribution_study.m  ver 1.0
%
% ntrials=input(' Enter number of trials ');

disp(' ');

clear fn;
clear damp;
clear dt;
clear abs_peak;
clear damage;


ntrials=1000;
numcycles=10000;

fn=100;
f=fn*10;

damp=0.05;


sr=20*fn;
dt=1/sr;
T=1/fn;
dur=numcycles*T;
nt=round(dur/dt);
sigma=1;
mu=0;
exponent=4;



%  damage depends on response std dev, (zero-crossing * dur ),exponent



[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);



abs_peak=zeros(ntrials,1);
damage=zeros(ntrials,1);

    
dchoice=-1.; % needs to be double
%
bex=9;

tic

progressbar;

for i=1:ntrials
    
    progressbar(i/ntrials);

%    white

    [X]=simple_white_noise_LPF(mu,sigma,nt,dt,f);
    
%    arbit

     forward=[ b1,  b2,  b3 ];    
     back   =[  1, -a1, -a2 ];    
%    
     y=filter(forward,back,X);

%    rainflow
%    rel damage
% 
    
    [ac1,ac2,nkv]=rainflow_basic_dyn_mex(y);                     
  
    arf1=ac1(1:nkv);
    arf2=ac2(1:nkv);
    
    D=sum((arf1.^bex).*arf2);
    
    abs_peak(i)=max(abs(y));
    damage(i)=D;
    
    out1=sprintf(' %d  %8.4g  %8.4g ',i,abs_peak(i),damage(i));  
    disp(out1);

end
pause(0.2);
progressbar(1);

nbins=40;

figure(1);
hist(abs_peak,nbins);
title('Absolute Peak');

figure(2);
hist(damage,nbins);
title('Damage');


[N,edges] = histcounts(damage,nbins);

NL=length(N);

bc=zeros(NL,1);
c_elements=zeros(NL,1);

c_elements(1)=N(1);

for i=1:NL
    
    bc(i)=mean([edges(i) edges(i+1)]);
    
    if(i>=2)
        c_elements(i)=c_elements(i-1)+N(i);
    end
    
end    


nc_elements=c_elements/c_elements(NL);

figure(3);
plot(bc,nc_elements);




clear amp;
amp=damage-mean(damage);
[n] = signal_function_stats_one(amp);


toc
