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

fc=[305 403 524 769 880 916];

minf=250;
maxf=1000;
deltaf=maxf-minf;

nf=length(fc);


error_max=1.0e+90;                                  
                                  


peak=max(abs(input_accel));



nnn=ceil(num*0.05);
if(nnn<40)
    nnn=40;
end

fn=zeros(nf,1);
damp=zeros(nf,1);


num=10000;

nbase=10;

amp=zeros(nbase,1);
nhs=zeros(nbase,1);
freq=zeros(nbase,1);
delay=zeros(nbase,1);

amp_r=zeros(nbase,1);
nhs_r=zeros(nbase,1);
freq_r=zeros(nbase,1);
delay_r=zeros(nbase,1);

kflag=0;


progressbar;


for ijk=1:nbase
    
    progressbar(ijk/nbase);  
    
for i=1:num
    
   
    freq=freq_r;
    amp=amp_r;        
    nhs=nhs_r;
    delay=delay_r;
    
    
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
    

    
    amp(ijk)=peak*(-0.5+1.0*rand())/400;
    nhs(ijk)=2*ceil(14*rand())-1;
    if(nhs(ijk)<3)
        nhs(ijk)=3;
    end
    delay(ijk)=(dur*0.5)*(rand())^2;
    
    if(i==1 && ijk==1)
        amp(ijk)=0;
    end
   
    freq(ijk)=deltaf*rand()+minf;
   
    if(kflag==1 && rand()>0.6)

        for j=1:nf
            damp(j)=damp_r(j)*(0.99+0.02*rand());
            fn(j)=fn_r(j)*(0.995+0.01*rand());
        end
        
        freq(ijk)=freq_r(ijk)*(0.99+0.02*rand());
        amp(ijk)=amp_r(ijk)*(0.98+0.04*rand());
                
        nhs(ijk)=nhs_r(ijk);
        rr=rand();
        if(rr>0.8 && rr<=0.9)
                nhs(ijk)=nhs(ijk)-2;
                if(nhs(ijk)<3)
                    nhs(ijk)=3;
                end
        end
        if(rr>0.9)
               nhs(ijk)=nhs(ijk)+2;
        end
                
        delay(ijk)=delay_r(ijk)*(0.99+0.02*rand());
        
    end
    
    
    base=zeros(n,1);
        
    for j=1:ijk
        
        if(freq(j)<minf)
            freq(j)=deltaf*rand()+minf;
        end
        if(nhs(j)<3)
            nhs(j)=3;
        end        
        
        [b]=generate_time_history_wavelet_table(freq(j),amp(j),nhs(j),delay(j),t);
        base=base+b;
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
        
        base_r=base;
        y_resp_r=y_resp;
        damp_r=damp;
        fn_r=fn;
        
        amp_r(ijk)=amp(ijk);
        freq_r(ijk)=freq(ijk);
        nhs_r(ijk)=nhs(ijk);
        delay_r(ijk)=delay(ijk);  
        
        if(i>1)
            kflag=1;
        end
    end
    
%%%%

end    



end

progressbar(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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










