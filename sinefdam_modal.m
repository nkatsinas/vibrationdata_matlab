disp(' ');
disp(' sinefdam_modal.m  version 1.1   January 21, 2012');
disp(' By Tom Irvine   Email:  tomirvine@aol.com ');
disp(' ');
disp(' This program performs a damped sine curve-fit for an ');
disp(' impulse response function file. ');
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
clear figure(1);
clear length;
%
disp(' ');
disp(' Input type: ');
disp('  1=receptance ');
disp('  2=mobility ');
disp('  3=accelerance ');
itype=input(' ');
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
grid on;
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
%% ts=input(' Enter segment start time  ');
ts=0;
te=input(' Enter segment end time for curve-fit  ');
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
%
out1 = sprintf(' np  = %d  \n',np);
disp(out1)
%
nt=input(' Enter the number of trials per frequency ');
%
nfr=input(' Enter the number of frequencies ');
%
fmax=0.;
%
 low_f=input(' Enter the starting frequency (Hz) ');
high_f=input(' Enter the ending frequency (Hz) ');
%
for(i=1:nfr)  
%         
    fl(i)=low_f;
    fu(i)=high_f;
%              
end
%
num2=length(tim);
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
drate=fix(sr/(fmax*16.));
%
if(drate <2)
    drate=1;
end    
if(drate > 8)
    drate=8;
end    
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
	 [a,x1r,x2r,x3r,x4r]=sf_engine_modal(a,t,drate,num2,flow,fup,ie,nt,dur,x1r,x2r,x3r,x4r,itype);
%
end
%
disp(' ');
disp(' Results');
disp(' ');
disp(' Case   Amplitude     fn(Hz)       damp      Phase(rad)  ');
%
for(ie=1:nfr)
    out4 = sprintf('  %d     %9.3g  %9.4g  %10.4f  %10.4f  %9.4g ',ie,x1r(ie),x2r(ie)/tp,x4r(ie),x3r(ie));
    disp(out4)      
end    
%
syn=zeros(1,n);
%    
for(ie=1:nfr)
    domegan=x4r(ie)*x2r(ie);
    omegad=x2r(ie)*sqrt(1.-x4r(ie)^2);
%	
    for(i=1:n)
%
		tt=t(i)-t(1);
%
        ta=tt;
		syn(i)=syn(i)+x1r(ie)*exp(-domegan*ta)*sin(omegad*ta-x3r(ie));

%				
    end
%
end
%
ymax=1.3*max(abs(s_amp));
ymin=-ymax;
%
figure(2)
nt=length(t);
plot(s_tim(1:nt),s_amp(1:nt),'b');
axis([0,t(nt),ymin,ymax]);
hold on
plot(t,syn,'r');
grid on;
%
%
% plot(t,syn,'-.');
%
xlabel(' Time (sec) ');
legend ('Input Data','Synthesis');
zoom on;
hold off;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
norg=length(s_amp);
for(i=1:50)
    if(norg<2^i)
        nq=2^i;
        break;
    end
end
%
nhalf=nq/2;
%
fmax=1/dt;
freq=linspace(0,fmax,nq);
%
input_ft=fft(s_amp(1:nt),nq);
response_ft=fft(syn,nq);
%
Z_input=abs(input_ft);
Z_response=abs(response_ft);
%
ph_input   =(180/pi)*atan2(imag(input_ft),   real(input_ft));               
ph_response=(180/pi)*atan2(imag(response_ft),real(response_ft)); 
%
freq=fix_size(freq);
Z_input=fix_size(Z_input);
Z_response=fix_size(Z_response);
ph_input=fix_size(ph_input);
ph_response=fix_size(ph_response);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
fmax=2.5*(max(x2r)/tp);
%
figure(3)
subplot(3,1,1);
plot(freq(1:nhalf),ph_input(1:nhalf),freq(1:nhalf),ph_response(1:nhalf));
ylabel('Phase (deg)');
title('Frequency Response Function');
grid on;
legend ('Input Data','Synthesis');
axis([0,fmax,-180,180]);
set(gca,'ytick',[-180 -90 0 90 180])
%
subplot(3,1,[2 3]);
plot(freq(1:nhalf),Z_input(1:nhalf),freq(1:nhalf),Z_response(1:nhalf));
ylabel('Magnitude');
xlabel('Frequency (Hz)');
grid on;
legend ('Input Data','Synthesis');
ymax=1.1*max(Z_input(1:nhalf));
%
    for(i=1:40)
        level = 10^(i-20);
        if(ymax < level)
            ymax=level;  
            break;
        end
    end
%    
ymin=ymax;
for(i=1:nhalf)
    if(freq(i)>fmax)
        break;
    end
    if(Z_input(i)<ymin)
        ymin=Z_input(i);
    end
end
%
    for(i=1:40)
        level = 10^(i-20);
        if(ymin < level)
            ymin=level/10;  
            break;
        end
    end
%
axis([0,fmax,ymin,ymax]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
%