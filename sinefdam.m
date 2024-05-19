disp(' ');
disp(' sinefdam.m  version 1.7   April 26, 2013');
disp(' By Tom Irvine   Email:  tom@vibrationdata.com ');
disp(' ');
disp(' This program performs a damped sine curve-fit for an input file. ');
%
close all;
%
clear t;
clear a;
clear amp;
clear damp;
clear delay;
clear f;
clear p;
clear fl;
clear fu;
clear s_amp;
clear s_tim;
clear THM;
clear tim
clear dt;
clear sr;
clear num2;
clear length;
clear original;
clear running_sum;
%
close all;
%    
tp=2.*pi;    
%    
disp(' The time history must be in a two-column matrix format: ')
disp(' Time(sec)  & amplitude ')
disp(' ')
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
s_amp=THM(:,2);
s_tim=THM(:,1);
%
figure(1);
plot(s_tim,s_amp);
xlabel('Time (sec) ');
%
n = length(s_amp); 
%
tmx=max(s_tim);
tmi=min(s_tim);
%
out1 = sprintf('\n  %d samples \n',n);
disp(out1)
%
dt=(tmx-tmi)/(n-1);
sr=1./dt;
%
out1 = sprintf(' SR  = %g samples/sec    dt = %g sec \n',sr,dt);
out3 = sprintf(' start  = %g sec    end = %g sec            ',tmi,tmx);
disp(out1)
disp(out3)
%
disp(' ');
ts=input(' Enter segment start time  ');
te=input(' Enter segment end   time  ');
disp(' ');
%
if(ts>tmx)
    ts=tmx;
end
if(te<tmi)
    ts=tmi;
end
%
n1=fix((ts-tmi)/dt);
n2=fix((te-tmi)/dt);
%
if(n1<1)
    n1=1;
end
%
if(n2>n)
    n2=n;
end
%
if(n1>n2)
    n2=n1;
end
%
amp=s_amp(n1:n2)';
tim=s_tim(n1:n2)';
np=length(tim);
n=np;
num2=np;
original=amp;
running_sum=amp*0;
%
out1 = sprintf(' np  = %d  \n',np);
disp(out1)
%
nt=input(' Enter the number of trials per frequency (suggest > 50000) ');
%
nfr=input(' Enter the number of frequencies ');
%
fmax=0.;
%
for i=1:nfr
%
    out4 = sprintf(' Enter Frequency %d',i);
    disp(out4)
    fc= input(' ');
%
    out4 = sprintf(' Enter Frequency Tolerance %d',i);
    disp(out4)
    tol= input(' ');  
 %         
    fl(i)=fc-tol;
    fu(i)=fc+tol;
%
    if(fc>fmax)
        fmax=fc;
    end
%              
end
%
t=tim;
a=amp;
%
clear THM;
%
dur=t(num2)-t(1);
%
dt=dur/(num2-1);
sr=1./dt;  
%    
for ie=1:nfr
%
    x1r(ie)=0.;
    x2r(ie)=0.;
    x3r(ie)=0.;
    x4r(ie)=0.;
    x5r(ie)=0.;
%
    out4 = sprintf('\n frequency case %d \n',ie);
    disp(out4)    
%
    flow=fl(ie);
     fup=fu(ie);
%
	 [a,x1r,x2r,x3r,x4r,x5r,running_sum]=...
        sf_engine(a,t,num2,flow,fup,ie,nt,dur,x1r,x2r,x3r,x4r,...
                                                 x5r,running_sum,original);
%
end
%
disp(' ');
disp(' Results');
disp(' ');
disp(' Case   Amplitude   fn(Hz)       damp      Phase(rad)  Delay(sec) ');
%
for ie=1:nfr
    out4 = sprintf('  %d  %10.4f  %10.4f  %10.4f  %10.4f  %10.4f ',...
                            ie,x1r(ie),x2r(ie)/tp,x4r(ie),x3r(ie),x5r(ie));
    disp(out4)      
end    
%
syn=zeros(1,n);
%    
for ie=1:nfr
    domegan=x4r(ie)*x2r(ie);
    omegad=x2r(ie)*sqrt(1.-x4r(ie)^2);
%	
    for i=1:n
%
		tt=t(i)-t(1);
%
		if( tt > x5r(ie) )
            ta=tt-x5r(ie);
			syn(i)=syn(i)+x1r(ie)*exp(-domegan*ta)*sin(omegad*ta-x3r(ie));
        end
%				
    end
%
end
%
ymax=1.5*max(s_amp);
ymin=1.5*min(s_amp);
%
figure(3)
plot(s_tim,s_amp,'b');
xlabel('Time (sec)');
hold on
plot(t,syn,'r');
xlabel(' Time (sec) ');
legend ('Input Data','Synthesis');
tmin=tmi;
tmax=tmx;
aa=max(s_amp);
if(aa<abs(min(s_amp)))
    ymax=abs(min(s_amp));
end
aa=min(s_amp);
if(aa<abs(max(s_amp)))
    ymin=abs(max(s_amp));
end
ymax=1.5*max(s_amp);
ymin=1.5*min(s_amp);
axis([tmin,tmax,ymin,ymax]);
zoom on;
hold off;