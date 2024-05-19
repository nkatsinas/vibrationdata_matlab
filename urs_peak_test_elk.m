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

T=1000;

fn=250;


nt=round(T*sr);

damp=0.05;

num=4000;

 ax=0.632;
    
peak=zeros(num,1);

nx=zeros(num,1);

progressbar;

for i=1:num
    
    progressbar(i/num);
     
    clear base;
    [base]=simple_white_noise_LPF(mu,sigma,nt,dt,f);
    
    clear y;
    [Y]=arbit_function_accel(fn,damp,dt,base);
    
    peak(i)=max(abs(Y))/std(Y);
    
%%    
    if(i==1)
        [pszcr,peak_rate,pa]=zero_crossing_function(Y,T);

        no=pszcr;
    
        arg=fn*T;


        [r]=maximax_peak(fn,T);


        rl=r*sqrt(1-(log(ax)/log(arg)));
    end
       
%%    
    
    n=100*sum(peak>r)/i;    
    
    out1=sprintf(' %8.4g%%  > %8.4g ',n,r);
    disp(out1);
    
    nx(i)=n;
    
end 
pause(0.2);
progressbar(1);

peak = sortrows(peak);


figure(333);
histogram(peak)

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


