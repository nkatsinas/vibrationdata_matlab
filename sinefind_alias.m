disp(' ');
disp(' sinefind_alias.m  version 2.3   June 15, 2007');
disp(' By Tom Irvine   Email:  tomirvine@aol.com ');
disp(' ');
disp(' This program performs a sine curve-fit for an input file. ');
%
clear t;
clear a;
clear tim;
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
clear figure(1);
clear figure(2);
clear tt;
clear syn;
clear s_amp;
clear s_tim;
clear error_rth;
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
k=1
for(i=1:n)
    if(s_tim(i)>=ts & s_tim(i)<=te)
        amp(k)=s_amp(i);
        tim(k)=s_tim(i);
        k=k+1;
    end
end
%
np=length(tim);
n=np;
%
out1 = sprintf(' np  = %d  \n',np);
disp(out1)
%
fmax=0.;
%
nt=input(' Enter the number of trials per frequency ');
%
nfr=input(' Enter the number of frequencies ');
%
for(i=1:nfr)
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
num2=length(t);
%
clear THM;
%
drate=1;
%
for(ie=1:nfr)
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
	 [a,x1r,x2r,x3r,error_rth,syna]=sfa_engine(a,t,drate,num2,flow,fup,ie,nt,x1r,x2r,x3r);
%
end
%
disp(' ');
disp(' Results');
disp(' ');
disp(' Case   Amplitude   fn(Hz)      Phase(rad) ');
%
for(ie=1:nfr)
    out4 = sprintf('  %d  %10.4f  %10.4f  %10.4f  %10.4f  ',ie,x1r(ie),x2r(ie)/tp,x3r(ie));
    disp(out4)      
end    
%
% syn=zeros(1,n);
%
disp(' ');
out4 = sprintf(' Input sample rate = %10.4g  ',sr);
disp(out4)    
disp(' ');
sr=input(' Enter sample rate for output ');
dt=1./sr;
tmx=max(tim);
tmi=min(tim);
% tt(1)=ts;
tt(1)=0;
i=1;
while(1) 
%
    syn(i)=0;
    ta=tt(i); 
    for(ie=1:nfr)
		syn(i)=syn(i)+x1r(ie)*sin(x2r(ie)*ta-x3r(ie));
    end
%
    if((ta)>=tmx-tmi)
        break;
    end   
%
    tt(i+1)=+i*dt;
    i=i+1;   
%    
end
tt=tt+tmi;
%
figure(2)
plot(tt,syn,'b',s_tim,s_amp,'r:+');
%
xlabel(' Time (sec) ');
legend ('Input Data','Synthesis');
tmin=ts;
tmax=te;
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
%
figure(3)
plot(tim,amp,'r',tt,syn,'b');
%
xlabel(' Time (sec) ');
legend ('Input Data','Synthesis');
axis([tmin,tmax,ymin,ymax]);
zoom on;
%
synthesis=[tt',syn'];