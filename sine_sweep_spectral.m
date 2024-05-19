disp(' ')
disp(' sine_sweep_spectral.m ')
disp(' ver 1.2  March 1, 2013')
disp(' by Tom Irvine  Email: tom@vibrationdata.com ')
disp(' ')
disp(' This program tracks the frequency and amplitude for  ')
disp(' a sine sweep signal.')  
disp(' ')
disp(' The time history must be in a two-column matrix format: ')
disp(' Time(sec)  & amplitude ')
disp(' ')
%
close all;
%
clear THM;
clear amp;
clear tim;
clear sd;
clear sds;
clear rms;
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
    THM = fscanf(fid,'%g %g',[2 inf]);
    THM=THM';
else
    THM = input(' Enter the matrix name:  ');
end
%
amp=THM(:,2);
tim=THM(:,1);
nn = size(amp);
n = nn(1);
%disp(' mean values ')
mu=mean(amp);
sd=std(amp);
mx=max(amp);
mi=min(amp);
rms=sqrt(sd^2+mu^2);
kt=0.;
tt_max=0.;
tt_min=0.;
%1
    for i=1:n
        if( amp(i)==mx)
            tt_max=tim(i);
        end
        if( amp(i)==mi)
            tt_min=tim(i);
        end
        kt=kt+amp(i)^4;
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
disp(' amplitude stats ')
disp(' ')
out0 = sprintf(' number of points = %d ',n);
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
disp(' ');
seg=input(' Enter segment duration (sec) ' );
%
ns=fix(sr*seg);
%
nnn=fix((tmx-tmi)/seg);
%
zc=zeros(nnn,1);
sds=zeros(nnn,1);
rms=zeros(nnn,1);
av=zeros(nnn,1);
peak=zeros(nnn,1);
tt=zeros(nnn,1);
%
j=1;
for i=1:nnn
    if((j+ns)>n)
        break;
    end
    clear x;
    zc(i)=0;
    x=amp(j:j+ns);   
    sds(i)=std(x);
    av(i)=mean(x);
    peak(i)=max(abs(x));
    rms(i)=sqrt( sds(i)^2 + av(i)^2 );
    tt(i)=(tim(j)+tim(j+ns))/2.;
%
    for(k=2:max(size(x)))
        if(x(k)*x(k-1)<0)
            zc(i)=zc(i)+1;
        end
    end
%
    j=j+ns;
end
%
freq=zc/(2*seg);
%
disp(' ')
disp(' Plot instantaneous time history file? ')
choice = input(' 1=yes 2=no ');
if(choice == 1)
    figure(1);
    plot(tim,amp)
    xlabel(' Time (sec)');
end
%
figure(2);
plot(tt,peak,tt,rms,tt,sds,'-.',tt,av);
legend ('peak','rms','std dev','average');    
xlabel(' Time (sec)');
grid;
ymax=max(av);
if( max(av) < max(peak))
    ymax=max(peak);
end
ymax=ymax*1.2;
ymin=min(av);
axis([tmi tmx ymin ymax]);  
%
figure(3);
plot(tt,freq);  
title('FREQUENCY');
xlabel(' Time(sec)');
ylabel(' Freq(Hz)');
grid;
ymax=max(freq)*1.2;
ymin=min(freq)*0.7;
axis([tmi tmx ymin ymax]);  
%
figure(4);
plot(freq,peak,'.');  
title('PEAK vs. FREQUENCY');
ylabel(' Peak');
xlabel(' Freq(Hz)');
grid;
ymax=max(peak)*1.2;
ymin=0;
fmi=min(freq);
fmx=max(freq);
axis([fmi fmx ymin ymax]);  
%