disp(' ')
disp(' std_dev_th.m ')
disp(' ver 1.2 November 16, 2010 ')
disp(' by Tom Irvine  Email: tomirvine@aol.com ')
disp(' ')
disp(' This program calculates the standard deviation time history ')
disp(' for an instantaneous time history. ')  
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
j=1;
clear av;
for(i=1:nnn)
    if((j+ns)>n)
        break;
    end
    clear x;
    x=amp(j:j+ns);   
    sds(i)=std(x);
    av(i)=mean(x);
    tt(i)=(tim(j)+tim(j+ns))/2.;
    j=j+ns;
end
%
disp(' ')
disp(' Plot standard deviation time history file? ')
choice = input(' 1=yes 2=no ');
if(choice == 1)
    figure(2);
    plot(tt,sds,tt,av,'-.')
    legend ('std dev','average');    
    xlabel(' Time (sec)');
    grid;
    ymax=max(av);
    if( max(av) < max(sds))
        ymax=max(sds);
    end
    ymax=ymax*1.3;
    ymin=min(av);
    axis([tmi tmx ymin ymax]);  
%    ylabel(' Std Dev ');  
end
%
sz=size(tt);
if(sz(2)>sz(1))
    tt=tt';
end
%
sz=size(sds);
if(sz(2)>sz(1))
    sds=sds';
end
%
sz=size(av);
if(sz(2)>sz(1))
    av=av';
end
%
clear sd;
clear ad;
sd=[tt sds];
ad=[tt av];
%