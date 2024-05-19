disp(' ')
disp(' sine_sweep_spectral_phase.m ')
disp(' ver 1.0  May 3, 2012')
disp(' by Tom Irvine  Email: tomirvine@aol.com ')
disp(' ')
disp(' This program tracks the phase for two  ')
disp(' sine sweep signals.')  
disp(' ')
disp(' The time history must be in a three-column matrix format: ')
disp(' Time(sec)  & input amplitude  & response amplitude ')
disp(' ')
%
fig_num=1;
%
close all;
%
clear THM;
clear amp_a;
clear amp_b;
clear tim;
clear sd;
clear sds;
clear tt;
clear av;
clear tt_max;
clear tt_min;
clear nn;
%
clear tmi;
clear tmx;
clear ymin;
clear ymax;
clear peak;
clear freq;
clear zc;
clear phase;
%
clear tt_a;
clear tt_b;
clear peak_a;
clear peak_b;
clear freq_a;
clear freq_b;
%
tpi=2*pi;
%
disp(' Select file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
file_choice = input('');
%
if(file_choice==1)
    [filename, pathname] = uigetfile('*.*');
    filename = fullfile(pathname, filename);     
%    disp(' Enter the input filename ');
%    filename = input(' ','s');
    fid = fopen(filename,'r');
    THM = fscanf(fid,'%g %g  %g',[3 inf]);
    THM=THM';
else
    THM = input(' Enter the matrix name:  ');
end
%
amp_b=THM(:,3);
amp_a=THM(:,2);
tim=THM(:,1);
%
nn = size(tim);
n = nn(1);
mu=mean(amp_a);
sd=std(amp_a);
mx=max(amp_a);
mi=min(amp_a);
rms=sqrt(sd^2+mu^2);
kt=0.;
tt_max=0.;
tt_min=0.;
%1
    for i=1:n
        if( amp_a(i)==mx)
            tt_max=tim(i);
        end
        if( amp_a(i)==mi)
            tt_min=tim(i);
        end
        kt=kt+amp_a(i)^4;
    end      
    kt=kt/(n*sd^4);
%1
disp(' ')
disp(' time stats ')
disp(' ')
tmx=max(tim);
tmi=min(tim);
% disp(out0)
out3 = sprintf(' start  = %g sec    end = %g sec            ',tmi,tmx);
dt=(tmx-tmi)/n;
sr=1./dt;
out4 = sprintf(' SR  = %8.4g samples/sec    dt = %8.4g sec            ',sr,dt);
out5 = sprintf('\n number of samples = %d  ',n);
disp(out3)
disp(out4)
disp(out5)
disp(' ')
disp(' *** amplitude stats:  input signal *** ')
disp(' ')
out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
out2a = sprintf(' max  = %9.4g  at  = %8.4g sec            ',mx,tt_max);
out2b = sprintf(' min  = %9.4g  at  = %8.4g sec            ',mi,tt_min);
out5  = sprintf('\n kurtosis  = %8.4g ',kt);
%
disp(out1)
disp(out2a)
disp(out2b)
disp(out5)
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ')
disp(' *** amplitude stats:  response signal *** ')
disp(' ')
%
n = nn(1);
mu=mean(amp_b);
sd=std(amp_b);
mx=max(amp_b);
mi=min(amp_b);
rms=sqrt(sd^2+mu^2);
kt=0.;
tt_max=0.;
tt_min=0.;
%1
for i=1:n
    if( amp_b(i)==mx)
        tt_max=tim(i);
    end
    if( amp_b(i)==mi)
        tt_min=tim(i);
    end
end      
%
%1
out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
out2a = sprintf(' max  = %9.4g  at  = %8.4g sec            ',mx,tt_max);
out2b = sprintf(' min  = %9.4g  at  = %8.4g sec            ',mi,tt_min);
%
disp(out1)
disp(out2a)
disp(out2b)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
seg=input(' Enter segment duration (sec) ' );
%
ns=fix(sr*seg);
%
nnn=fix((tmx-tmi)/seg);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
zc_a=zeros(nnn,1);
sds_a=zeros(nnn,1);
av_a=zeros(nnn,1);
peak_a=zeros(nnn,1);
tt_a=zeros(nnn,1);
%
j=1;
for i=1:nnn
    if((j+ns)>n)
        break;
    end
    clear x;
    zc_a(i)=0;
    x=amp_a(j:j+ns);   
    sds_a(i)=std(x);
    av_a(i)=mean(x);
    peak_a(i)=max(abs(x));
    tt_a(i)=(tim(j)+tim(j+ns))/2.;
%
    for k=2:max(size(x))
        if(x(k)*x(k-1)<0)
            zc_a(i)=zc_a(i)+1;
        end
    end
%
    j=j+ns;
end
%
freq_a=zc_a/(2*seg);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
zc_b=zeros(nnn,1);
sds_b=zeros(nnn,1);
av_b=zeros(nnn,1);
peak_b=zeros(nnn,1);
tt_b=zeros(nnn,1);
%
j=1;
for i=1:nnn
    if((j+ns)>n)
        break;
    end
    clear x;
    zc_b(i)=0;
    x=amp_b(j:j+ns);   
    sds_b(i)=std(x);
    av_b(i)=mean(x);
    peak_b(i)=max(abs(x));
    tt_b(i)=(tim(j)+tim(j+ns))/2.;
%
    for k=2:max(size(x))
        if(x(k)*x(k-1)<0)
            zc_b(i)=zc_b(i)+1;
        end
    end
%
    j=j+ns;
end
%
freq_b=zc_b/(2*seg);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  phase
%
phase=zeros(nnn,1);
%
j=1;
for i=1:nnn
    if((j+ns)>n)
        break;
    end
    clear x;
    clear y;
    x=amp_a(j:j+ns);   
    y=amp_b(j:j+ns);   
%
    max_x=max(size(x));
%
    delay=0;
    nd=0;
%
    for k=2:max_x
        if(x(k)*x(k-1)<0 && x(k)>0)           
%            
%  find time for input zero cross            
%
            m=(x(k)-x(k-1))/dt;
            b=x(k-1);
            txc=(-b/m)+(k-1)*dt;
%
%  find time for input zero cross 
%
            for kb=k:max_x
%                
                if(y(kb)*y(kb-1)<0 && y(kb)>0)
%
                    m=(y(kb)-y(kb-1))/dt;
                    b=y(kb-1);  
                    tyc=(-b/m)+(kb-1)*dt;                    
%
                    delay=delay+(tyc-txc);
                    nd=nd+1;
%
                    break;
%
                end    
%
            end
%
        end
    end
%
    delay_ave=delay/nd;
%
    period=1./freq_a(i);
%
    phase(i)=(delay_ave/period)*360;
%
    j=j+ns;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ')
figure(fig_num);
fig_num=fig_num+1;
plot(tim,amp_a,tim,amp_b)
xlabel(' Time (sec)');            
legend('input','response');  
grid on;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
i=2;
while(  tt_a(i)>tt_a(i-1) && peak_a(i)>1.0e-05)
    j=i;
    i=i+1;
end
last=j;
%
temp=tt_a;
clear tt_a;
tt_a=temp(1:last);
%
temp=tt_b;
clear tt_b;
tt_b=temp(1:last);
%
temp=peak_a;
clear peak_a;
peak_a=temp(1:last);
%
temp=peak_b;
clear peak_b;
peak_b=temp(1:last);
%
temp=freq_a;
clear freq_a;
freq_a=temp(1:last);
%
temp=freq_b;
clear freq_b;
freq_b=temp(1:last);
%
temp=phase;
clear phase;
phase=temp(1:last);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
plot(tt_a,peak_a,tt_b,peak_b);
legend ('input','response');    
xlabel(' Time (sec)');
title('Peak Amplitude');
grid on;
%
ymax_a=max(peak_a);
ymax_b=max(peak_b);
ymax=max([ymax_a ymax_b]);
ymax=ymax*1.2;
ymin=0;
axis([tmi tmx ymin ymax]);  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
plot(tt_a,freq_a,tt_b,freq_b); 
legend ('input','response');   
title('FREQUENCY');
xlabel(' Time(sec)');
ylabel(' Freq(Hz)');
grid on;
ymax=max(freq_a)*1.2;
ymin=min(freq_a)*0.7;
axis([tmi tmx ymin ymax]);  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
plot(freq_a,peak_a,'.',freq_a,peak_b,'.');   % plot both vs. freq_a  
legend ('input','response'); 
title('PEAK vs. FREQUENCY');
ylabel(' Peak');
xlabel(' Freq(Hz)');
grid on;
%
ymax_a=max(peak_a);
ymax_b=max(peak_b);
ymax=max([ymax_a ymax_b]);
ymax=ymax*1.2;
ymin=0;
%
fmi=min(freq_a);
fmx=max(freq_a);
axis([fmi fmx ymin ymax]);  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%  phase
%
figure(fig_num);
fig_num=fig_num+1;
plot(tt_a,phase); 
title('Phase Angle  Response Lag ');
xlabel(' Time(sec)');
ylabel(' Phase(deg)');
grid on;