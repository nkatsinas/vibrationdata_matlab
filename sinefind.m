disp(' ');
disp(' sinefind.m  version 2.2   April 26, 2013');
disp(' By Tom Irvine   Email:  tom@vibrationdata.com ');
disp(' ');
disp(' This program performs a sine curve-fit for an input file. ');
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
clear THM;
clear dt;
clear sr;
clear num2;
clear original;
clear running_sum;
%    
tp=2.*pi;    
%%%
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
xlabel('Time (sec)');
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
dur=te-ts;
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
original=amp;
running_sum=amp*0;
%
out1 = sprintf(' np  = %d  \n',np);
disp(out1)
%
fmax=0.;
%
nt=input(' Enter the number of trials per frequency (suggest > 5000) ');
%
nfr=input(' Enter the number of frequencies ');
%
fl=zeros(nfr,1);
fu=zeros(nfr,1);
%
disp(' ');
disp(' Select strategy ');
disp('  1=manually enter frequency estimates ');
disp('  2=automatically estimate frequencies from zero-crossings ');
istr=input(' ');
%

for i=1:nfr
%
    if(istr==1)
        out4 = sprintf(' Enter Center Frequency %d',i);
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
    else
%
        fl(i)=0;
        fu(i)=sr/8;
%
    end
%
end
%
t=tim;
a=amp;
dur=max(t)-min(t);
num2=length(t);
%
clear THM;
%
drate=fix(sr/(fmax*16.));
%
if(drate <2)
    drate=1;
end    
if(drate > 10)
    drate=10;
end    
%
x1r=zeros(nfr,1);
x2r=zeros(nfr,1);
x3r=zeros(nfr,1);
%
for ie=1:nfr
%
    out4 = sprintf('\n frequency case %d \n',ie);
    disp(out4)    
%
    flow=fl(ie);
     fup=fu(ie);
%
   	 [a,x1r,x2r,x3r,error_rth,syna,running_sum]=...
          sfa_engine(dur,a,t,drate,num2,flow,fup,ie,nt,x1r,x2r,x3r,...
                     original,running_sum,istr);  
%
end
%
disp(' ');
disp(' Results');
disp(' ');
disp(' Case   Amplitude   fn(Hz)   Phase(rad)  ');
%
for ie=1:nfr
    out4 = sprintf('  %d  %10.4f  %10.4f  %10.4f  ',ie,x1r(ie),x2r(ie)/tp,x3r(ie));
    disp(out4)      
end    
%
syn=zeros(1,n);
%    
for ie=1:nfr
%	
    for i=1:n
%
		tt=t(i)-t(1);
		syn(i)=syn(i)+x1r(ie)*sin(x2r(ie)*tt-x3r(ie));
%				
    end
%
end
%
figure(3)
plot(s_tim,s_amp,'b',t,syn,'r');
%
% plot(t,syn,'-.');
%
xlabel(' Time (sec) ');
legend ('Input Data','Synthesis');
tmin=tmi;
tmax=tmx;
%
ymax=1.5*max(s_amp);
ymin=1.5*min(s_amp);
axis([tmin,tmax,ymin,ymax]);
zoom on;