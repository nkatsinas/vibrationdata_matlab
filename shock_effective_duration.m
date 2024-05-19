disp(' ')
disp(' shock_effective_duration.m ')
disp(' ver 1.0 September 1, 2008 ')
disp(' by Tom Irvine  Email: tomirvine@aol.com ')
disp(' ')
disp(' This program calculates the effective durations TE & Te of a shock pulse ')
disp(' for an instantaneous time history. ')  
disp(' Reference:  MIL-STD-810F, Method 516.5, Figure 516.5-2 ');
disp(' ')
disp(' The time history must be in a two-column matrix format: ')
disp(' Time(sec)  & amplitude ')
disp(' ')
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
amax=abs(mx);
if( amax < abs(mi))
    amax=abs(mi);
end
%
TE=0;
for(i=1:nn)
    if(amp(i)>(amax/3))
        TE=tim(i);
    end
end
%
seg=((tmx-tmi)/50);  % This parameter can be varied according to the desired resolution.
%
ns=fix(sr*seg);
%
nnn=fix((tmx-tmi)/seg);
%
progressbar % Create figure and set starting time
%
for(i=1:n-ns)
%
    progressbar(i/(n-ns)) % Update figure    
%
    clear x;
    x=amp(i:i+ns);   
    sds(i)=std(x);
    av(i)=mean(x);
    rms(i)=sqrt(sds(i)^2+av(i)^2);
    tt(i)=(tim(i)+tim(i+ns))/2.;
end
%
rms_max=max(rms);
%
Te=0;   % fix here
for(i=1:n-ns)
    if(rms(i)>(rms_max/10))
        Te=tt(i);
    end
end
out1 = sprintf('\n Effective Duration TE = %8.5g sec ',TE);
out2 =   sprintf('                       = %8.5g msec',TE*1000);
disp(out1);
disp(out2);
disp(' ');
out1 = sprintf('\n Effective Duration Te = %8.5g sec ',Te);
out2 =   sprintf('                       = %8.5g msec\n',Te*1000);
disp(out1);
disp(out2);
%
disp(' ');
disp(' Plot instantaneous time history file? ')
choice = input(' 1=yes 2=no ');
if(choice == 1)
    plot(tim,amp)
    xlabel(' Time (sec)');
end
%
disp(' ')
disp(' Plot RMS time history file? ')
choice = input(' 1=yes 2=no ');
if(choice == 1)
    plot(tt,sds,tt,av,'-.')
    legend ('RMS','average');    
    xlabel(' Time (sec)');
    grid;
    ymax=max(rms);
    ymax=ymax*1.3;
    ymin=0;
    axis([tmi tmx ymin ymax]);  
%    ylabel(' Std Dev ');  
end