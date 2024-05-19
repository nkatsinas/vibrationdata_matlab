disp(' ');
disp(' sinefind.m  version 2.0   June 15, 2007');
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
clear THM;
s_amp=zeros(65,1);
s_tim=zeros(65,1);
THM = 'd';
%
s_amp=THM(:,2);
store_a=THM(:,2);
%
s_tim=THM(:,1);
store_t=THM(:,1);
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
te=ts+29;
% te=input(' Enter segment end   time  ');
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
%
s_tim(n1:n2)=s_tim(n1:n2)-s_tim(n1);
tim=s_tim(n1:n2)';
np=length(tim);
n=np;
%
out1 = sprintf(' np  = %d  \n',np);
disp(out1)
%
fmax=0.;
%
% nt=input(' Enter the number of trials per frequency ');
nt=10000;
%
% nfr=input(' Enter the number of frequencies ');
nfr=40;
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
		tt=dt*(i-1)+t(1);
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
N=3;
syn2=zeros(1,N);
for(ie=1:nfr)
%	
    for(i=1:N)
%
		tt(i)=dt*i+tend;
		syn2(i)=syn2(i)+x1r(ie)*sin(x2r(ie)*tt(i)-x3r(ie));
%				
    end
end
%
adelta=store_a(n2+1)-store_a(n2);
pdelta=syn2(1)-syn(n);
%
polarity=adelta*pdelta;
%
store_a(n2)
out1=sprintf(' %8.4g  %8.4g \n',adelta,pdelta);
disp(out1);
if(polarity>=0)
    disp(' correct ');
else
    disp(' incorrect ');
end
%
figure(2)
t=t+1;
tt=tt+1;
store_t=store_t-n1+2;
plot(store_t,store_a,'b',t,syn,'r',tt,syn2,'o');
%
% plot(t,syn,'-.');
%
xlabel(' Time (sec) ');
legend ('Input Data','Synthesis');
tmin=0;
tmax=max(store_t);
aa=max(s_amp);
if(aa<abs(min(s_amp)))
    ymax=abs(min(s_amp));
end
ymin=min(s_amp)-1;
ymax=max(s_amp)+1;
axis([tmin,tmax,ymin,ymax]);
grid on;
zoom on;