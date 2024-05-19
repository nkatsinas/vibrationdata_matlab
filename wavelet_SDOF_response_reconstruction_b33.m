clear y_resp_r;
clear base_r;
clear input_accel;


% FS = input(' Enter the matrix name:  ','s');

FS='zzz_33ffdee';
% FS='zzz_22';

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


fc=[793 879 915 976 1024];

nf=length(fc);


error_max=1.0e+90;                                  
                                  


peak=max(abs(input_accel));

maxf=1200; 
minf=500;
deltaf=maxf-minf;

nnn=ceil(num*0.05);
if(nnn<40)
    nnn=40;
end

fn=zeros(nf,1);
damp=zeros(nf,1);


num=100000;

nbase=40;


amp=zeros(nbase,1);
nhs=zeros(nbase,1);
freq=zeros(nbase,1);
delay=zeros(nbase,1);

amp_r=zeros(nbase,1);
nhs_r=zeros(nbase,1);
freq_r=zeros(nbase,1);
delay_r=zeros(nbase,1);


kflag=0;

N1=round(0.001*num);

progressbar;

for i=1:num
    
    progressbar(i/num);
    
%%%%

    for j=1:nf

        fn(j)=(0.995+0.01*rand())*fc(j);

        damp(j)=0.10*rand();
        if(damp(j)<0.001)
            damp(j)=0.001;
        end
        
    end    

%%%%

    % synthesize base
    
    for j=1:nbase
    
        amp(j)=peak*(-0.5+1.0*rand())/200;
        nhs(j)=2*ceil(38*rand())-1;
        if(nhs(j)<3)
            nhs(j)=3;
        end
        delay(j)=(dur*0.5)*(rand())^1.5;
    
        if(i==1)
            amp(j)=0;
        end
    
        iq=round(nf*rand());
        
        if(iq==0)
            iq=1;
        end
        
        freq(j)=fc(iq)*0.95+0.1*rand();
    end
    
    
    
    if(kflag==1 && rand()>0.65)

        for j=1:nf
            damp(j)=damp_r(j)*(0.95+0.1*rand());
            fn(j)=fn_r(j)*(0.995+0.01*rand());
        end
        
        for j=1:nbase
            freq(j)=freq_r(j)*(0.998+0.004*rand());
            amp(j)=amp_r(j)*(0.998+0.004*rand());
            
            
            nhs(j)=nhs_r(j);
            rr=rand();
            if(rr>0.8 && rr<=0.9)
                nhs(j)=nhs(j)-2;
            end
            if(rr>0.9)
               nhs(j)=nhs(j)+2;
            end
            
            
            delay(j)=delay_r(j)*(0.995+0.01*rand());
        end
        
    end
    
    for j=1:nf
        if(fn(j)<0.991*fc(j))
            fn(j)=0.991*fc(j);
        end
        if(fn(j)>1.009*fc(j))
            fn(j)=1.009*fc(j);
        end    
    end
    
    
    if(rand()>0.95)
        amp=amp_r;
        freq=freq_r;
        nhs=nhs_r;
        delay=delay_r; 
    end
    
    for j=1:nbase
        if(rand()>0.98)
            amp(j)=amp(j)*0.5;
        end
    end
    
    for j=1:nbase
        if(rand()>0.98)
            amp(j)=amp_r(j);
            freq(j)=freq_r(j);
            nhs(j)=nhs_r(j);    
            delay(j)=delay_r(j);             
        end
    end
    
    base=zeros(n,1);
    for j=1:nbase
        
        if(nhs(j)<3)
            nhs(j)=3;
        end
        
        if(abs(amp(j))>1.0e-04)
            [b]=generate_time_history_wavelet_table(freq(j),amp(j),nhs(j),delay(j),t);
            base=base+b;
        end
    end
    
    y_resp=zeros(n,1);
    for j=1:nf
        [yy]=arbit_function_accel(fn(j),damp(j),dt,base);
        y_resp=y_resp+yy;
    end
    
    
%    figure(2*i-1);
%    plot(t,y_resp)
%    xlabel('Time (sec)');
    
    error=std(input_accel-y_resp);
        
    if(error<error_max)
        error_max=error;
        
        out1=sprintf('\n %d  %11.7g   ',i,error_max);
        disp(out1);
        for j=1:nbase
            out1=sprintf('       %8.4g  %8.4g  %8.4g  %8.4g  ',freq(j),amp(j),nhs(j),delay(j));
            disp(out1);
        end
        for j=1:nf
            out1=sprintf('             %8.4g  %8.4g',fn(j),damp(j));
            disp(out1);
        end
        out1=sprintf(' %d  %11.7g   \n',i,error_max);
        disp(out1);
        
        base_r=base;
        y_resp_r=y_resp;
        damp_r=damp;
        fn_r=fn;
        amp_r=amp;
        freq_r=freq;
        nhs_r=nhs;
        delay_r=delay;  
        
        if(i>1)
            kflag=1;
        end
    end
    
%%%%

end    

progressbar(1);


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










