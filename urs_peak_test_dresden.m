%
%   urs_peak_test.m  ver 1.1  by Tom Irvine
%

clear peak;
clear fn;
clear n;
clear nx;
clear r;
clear rl;
clear c;
clear T;

mu=0;
sigma=1;

sr=10000;
dt=1/sr;
f=1000;

T=240;

fn=300;

dur=10;
nt=round(T*sr);

damp=0.05;

num=200;

 ax=0.632;
    
peak=zeros(num,1);

damage=zeros(num,1);

nx=zeros(num,1);
ku=zeros(num,1);
ov=zeros(num,1);
rc=zeros(num,1);

progressbar;

for i=1:num
    
    progressbar(i/num);
     
    clear base;
    [base]=simple_white_noise_LPF(mu,sigma,nt,dt,f);
    
    clear y;
    [Y]=arbit_function_accel(fn,damp,dt,base);
    
    [range_cycles,ddd]=rainflow_function_choice_damage(Y,2);
  
    rc(i)=max(range_cycles(:,1));
    
    damage(i)=ddd;
        
    peak(i)=max(abs(Y))/std(Y);
    
%%    
    if(i==1)
        [pszcr,peak_rate,pa]=zero_crossing_function(Y,T);

        no=pszcr;
    
        arg=no*T;

        e=1/arg;

        den=1-(1-ax)^e;
        r=sqrt(2*log(1/den));

        rl=r*sqrt(1-(log(ax)/log(arg)));
    end
       
%%    
    [amean,amax,amin,aabs,astd,arms,askew,akurt]=dstats(Y);
    ku(i)=akurt;
    ov(i)=astd;
    
    n=100*sum(peak>rl)/i;    
    
    out1=sprintf(' %8.4g%%  > %8.4g   damage=%8.4g  ov=%8.4g k=%8.4g',n,rl,damage(i),ov(i),ku(i));
    disp(out1);
    
    nx(i)=n;
    
end 
pause(0.2);
progressbar(1);

peak = sortrows(peak);


figure(333);
histogram(peak)

figure(334);
histogram(damage)

figure(335);
plot(ku,damage,'*');
title('kurtosis');

figure(336);
plot(ov,damage,'*');
title('std dev');

figure(337);
plot(rc,damage,'*');
title('max range cycle');

disp(' ');
disp(' * * * * ');
disp(' ');
out1=sprintf(' min=%8.4g  max=%8.4g  ',min(peak),max(peak));
disp(out1);
disp(' ');
out1=sprintf(' no+=%8.4g  ',no);
disp(out1);
disp(' ');

figure(4);
plot(nx)

for i=1:num
    vvv(i)=peak(i)^6.4/damage(i);
end


