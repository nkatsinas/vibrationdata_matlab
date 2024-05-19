disp(' ');
disp(' bob.m  version 1.1   Nov 4, 2009');
disp(' By Tom Irvine   Email:  tomirvine@aol.com ');
disp(' ');
disp(' This program performs a sine curve-fit for an input file. ');
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
clear figure(1);
clear s_time;
clear t;
clear tt;
clear dt;
clear store_t;
clear store_a;
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
figure(1);
plot(THM(:,1),THM(:,2));
%
disp(' ');
ts=input(' Enter segment start time  ');
n=max(size(THM(:,1)));
te=n;
%
s_amp=THM(ts:te,2);
amp=s_amp;
store_a=s_amp;
a=s_amp;
%
n=max(size(s_amp));
np=n;
%
for(i=1:n)
    t(i)=i;
    s_time(i)=i;
    s_tim(i)=i;
    store_t(i)=i;
    tim(i)=i;
end
%
tmx=max(s_tim);
tmi=min(s_tim);
%
out1 = sprintf('\n  %d samples \n',n);
disp(out1)
%
dt=1;
drate=1;
sr=1./dt;
%
out1 = sprintf(' SR  = %g samples/sec    dt = %g sec \n',sr,dt);
out3 = sprintf(' start  = %g sec    end = %g sec            ',tmi,tmx);
disp(out1)
disp(out3)
%
out1 = sprintf(' np  = %d  \n',np);
disp(out1)
%
fmax=0.;
%
% nt=input(' Enter the number of trials per frequency ');
nt=10000;
%
nfr=input(' Enter the number of frequencies ');
%
for(i=1:nfr)
%
    out4 = sprintf(' Enter Frequency %d',i);
    disp(out4)
%%    fc= input(' ');
    fc=0.1;
%
    if(i==1)
        fc=0;
    end
%
    out4 = sprintf(' Enter Frequency Tolerance %d',i);
    disp(out4)
%%    tol= input(' ');
    tol=fc;
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
a=amp;
num2=length(t);
%
for(ie=1:nfr)
%
    x1r(ie)=0.;
    x2r(ie)=0.;
    x3r(ie)=0.;
%
    out4 = sprintf('\n frequency case %d \n',ie);
    disp(out4)    
%
    flow=fl(ie);
     fup=fu(ie);
%
   	 [a,x1r,x2r,x3r,error_rth,syna]=sfa_engine_stk(a,t,drate,num2,flow,fup,ie,nfr,nt,x1r,x2r,x3r);  
%
end
%
disp(' ');
disp(' Results');
disp(' ');
disp(' Case   Amplitude   fn(Hz)   Phase(rad)  ');
%
for(ie=1:nfr)
    out4 = sprintf('  %d  %10.4f  %10.4f  %10.4f  ',ie,x1r(ie),x2r(ie)/tp,x3r(ie));
    disp(out4)      
end    
%
syn=zeros(1,n);
%
for(ie=1:nfr)
%	
    for(i=1:n)
%
		tt=t(i);
		syn(i)=syn(i)+x1r(ie)*sin(x2r(ie)*tt-x3r(ie));
%				
    end
%
end
tend=tt;
%
clear tt;
clear syn2;
k=1;
N=1;
syn2=zeros(1,N);
for(ie=1:nfr)
%	
    for(i=1:N)
%
		tt(i)=(dt/10)*i+tend;
		syn2(i)=syn2(i)+x1r(ie)*sin(x2r(ie)*tt(i)-x3r(ie));
%				
    end
end
%
pdelta=syn2(1)-syn(n);
%
out1=sprintf(' pdelta=%8.4g \n',pdelta);
disp(out1);
if(pdelta==1)
    disp(' buy');
end
if(pdelta==0)
    disp(' hold');
end
if(pdelta<0)
    disp(' sell');
end
%
figure(2)
%
hold on;
plot(s_time,s_amp,'r');
plot(s_time,syn,'b');
plot(tt,syn2,'o');
hold off;
%
% plot(t,syn,'-.');
%
xlabel(' Time (sec) ');
legend ('Input Data','Synthesis');
tmin=0;
tmax=max(store_t)+2;
aa=max(s_amp);
if(aa<abs(min(s_amp)))
    ymax=abs(min(s_amp));
end
ymin=min(s_amp)-1;
ymax=max(s_amp)+1;
axis([tmin,tmax,ymin,ymax]);
grid on;
zoom on;