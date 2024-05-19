clear y_resp_r;
clear base_r;
clear input_accel;


% FS = input(' Enter the matrix name:  ','s');

FS='zzz_22ffe';

THM=evalin('caller',FS);

t=THM(:,1);
t1=t(1);
t=t-t1;
n = length(t);
dur=t(n);

input_accel=THM(:,2);
%
tmx=max(t);
tmi=min(t);

dt=(tmx-tmi)/(n-1);
sr=1/dt;


% fn=input(' Enter frequency(Hz) ');
% damp=input(' Enter damping ');

fc=915.5;
fc=769;

nf=length(fc);


error_max=1.0e+90;                                  
                                  


peak=max(abs(input_accel));

maxf=1000; 
minf=10;

nnn=ceil(num*0.05);
if(nnn<40)
    nnn=40;
end

fn=zeros(nf,1);
damp=zeros(nf,1);


num=20000;

nbase=10;

amp=zeros(nbase,1);
nhs=zeros(nbase,1);
freq=zeros(nbase,1);
delay=zeros(nbase,1);

for i=1:num
    
%%%%

        fn=(0.995+0.01*rand())*fc;

        damp=0.10*rand();
        if(damp<0.001)
            damp=0.001;
        end

%%%%

    % synthesize base
    
    for j=1:nbase
    
        amp(j)=peak*(-0.5+1.0*rand())/100;
        nhs(j)=2*ceil(14*rand())-1;
        if(nhs(j)<3)
            nhs(j)=3;
        end
        freq(j)=fc*(0.95+0.10*rand());
        delay(j)=(dur*0.5)*(rand())^2;
    
    
        if(i==1)
            amp(j)=0;
        end
    
    end
    
    
    
    if(i>nnn && rand()>0.6)

        damp=damp_r*(0.99+0.02*rand());
        fn=fn_r*(0.995+0.01*rand());
        
        for j=1:nbase
            freq(j)=freq_r(j)*(0.99+0.02*rand());
            amp(j)=amp_r(j)*(0.98+0.04*rand());
            nhs(j)=nhs_r(j);
            delay(j)=delay_r(j)*(0.99+0.02*rand());
        end
        
    end
    
  
    if(fn<0.99*fc)
            fn=0.99*fc;
    end
    if(fn>1.01*fc)
            fn=1.01*fc;
    end    
    
    base=zeros(n,1);
    for j=1:nbase
        [b]=generate_time_history_wavelet_table(freq,amp,nhs,delay,t);
        base=base+b;
    end
    
    [y_resp]=arbit_function_accel(fn,damp,dt,base);
   
    
    
%    figure(2*i-1);
%    plot(t,y_resp)
%    xlabel('Time (sec)');
    
    error=std(input_accel-y_resp);
        
    if(error<error_max)
        error_max=error;
        
        out1=sprintf('\n %d  %11.7g  %8.4g  %8.4g  ',i,error_max,fn,damp);
        disp(out1);
        for j=1:nbase
            out1=sprintf('       %8.4g  %8.4g  %8.4g  %8.4g  ',i,freq(j),amp(j),nhs(j),delay(j));
            disp(out1);
        end
        
        base_r=base;
        y_resp_r=y_resp;
        damp_r=damp;
        fn_r=fn;
        amp_r=amp;
        freq_r=freq;
        nhs_r=nhs;
        delay_r=delay;   
    end
    
%%%%

end    


t=fix_size(t);
base_r=fix_size(base_r);
y_resp_r=fix_size(y_resp_r);


fig_num=1;
xlabel2='Time (sec)';
data1=[t base_r];
data2=[t y_resp_r];

ylabel1='Accel (G)';
ylabel2='Accel (G)';

t_string='zzz';

[fig_num]=subplots_two_linlin(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string);



figure(fig_num)
plot(t,y_resp_r,t,input_accel);










