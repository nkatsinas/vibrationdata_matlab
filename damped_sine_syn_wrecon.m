% 
%  SRS Synthesis using Damped Sinusoids with Wavelet Reconstruction
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' damped_sine_syn_wrecon.m  ver 3.7  October 8, 2012 ');
disp(' by Tom Irvine');
disp(' Email:  tomirvine@aol.com ');
disp(' ');
disp(' This program synthesizes a time history to satisfy a shock');
disp(' response spectrum specification.  Damped sinusoids are used');
disp(' for the synthesis. ');
disp(' ');
%
close all;
%
clear a;
clear f;
clear ra;
clear rf;
clear rff;
clear slope;
clear THF;
clear tt;
clear store;
clear max;
clear THM;
clear xmin;
clear xmax;
clear resp;
%
clear acceleration;
clear velocity;
clear displacement;
clear accel_ds;
clear accel;
tic
%
MAX=400;
FMAX=400;
TMAX=100000;
%
tpi=2.*pi;
octave=(2.^(1./12.));
%
errlit=1.0e+90;
syn_error = 1.0e+91;  
%
f=zeros(MAX,1);
a=zeros(MAX,1);
slope=zeros(MAX,1);
%
disp(' Select data input method.');
disp('  1=keyboard  ');
disp('  2=internal Matlab array  ');
disp('  3=external ASCII file   ');
imethod=input(' ');
disp(' ');
%  
if(imethod==1)
%
    n=0;
    while(n < 2)
        disp('  How Many Breakpoints (min=2)? ');
        n=input(' ');
    end
%  
    disp('  Enter Points (free-format)');
    disp('  Natural Freq(Hz)  SRS(G)   ');
%   
    for i=1:n
        out1=sprintf(' Enter natural frequency %d:  ',i);
        f(i)=input(out1);
        out2=sprintf(' Enter SRS(G) %d:  ',i);
        a(i)=input(out2);  
        disp(' ')
    end
%
end
%
if(imethod==2)
    disp('The array must have two columns:  Natural Freq(Hz)  SRS(G)   ');
    THM=input(' Enter the array name:  ');
    f=THM(:,1);
    a=THM(:,2);
    clear length;
    n=length(a);
end
%
if(imethod==3)
%
    [filename, pathname] = uigetfile('*.*');
    filename = fullfile(pathname, filename); 
    fid = fopen(filename,'r');
    THF = fscanf(fid,'%g %g',[2 inf]);
    THF=THF';   
    f=THF(:,1);
    a=THF(:,2);
    clear sz;
    sz=(size(f));
    n=sz(1);
    if(sz(2)>sz(1))
        n=sz(2);
    end
%
end
%
ffirst=f(1);
flast=f(n);
last_f=f(n);
last_a=a(n); 
%
%  disp('  Ref 2');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%seed=input(' Enter an arbitrary integer ');
%
%%for(i=1:seed)
%%   dr=rand();
%%end
%
for i=1:(n-1)
    slope(i)=log(a(i+1)/a(i))/log(f(i+1)/f(i));
end
%
%
dre=4/fspec(1);
disp(' ');
disp(' Enter duration (sec): ');
out1=sprintf(' (recommend >= %8.4g) ',dre);
disp(out1);
dur=input('  ');
%
first=0.15*dur;
%
sr=10*last_f;
%
out1=sprintf(' \n Recommend sample rate = %12.6g samples/sec\n',sr);
disp(out1);
%
iasa=input(' Accept recommended rate?  1=yes 2=no ');
%
if(iasa~=1)
    disp(' ');
    sr=input(' Enter sample rate  ');
end
%
dt=1./sr;
ns=round(sr*dur)+20;
%
if(ns > TMAX)
    disp('  Warning: Excessive number of samples. ');
end
%
out1=sprintf(' \n sample rate = %12.4g samples/sec\n ',sr);
disp(out1);
%
idamp=input(' Enter damping format:  1=damping ratio   2=Q ');
%
if(idamp == 1 )
    damp=input(' Enter damping ratio (typically 0.05) ');
else
    damp=input(' Enter amplification factor Q (typically 10) ');
    damp = 1./(2.*damp);
end
Q=1./(2.*damp);
%
iamax=input(' Enter number of iterations for outer loop (min=10 max=5000) ');
%
if(iamax < 10 )
    iamax=10;
end
if(iamax > 5000 )
    iamax=5000;
end
%
ntt=80;  % number of iterations for inner loop
%
out1=sprintf('\n  ns=%ld \n',ns);
disp(out1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(' ');
disp('  Interpolating reference. ');
%
rf=zeros(FMAX,1);
ra=zeros(FMAX,1);
%
rf(1)=f(1);
ra(1)=a(1);
%
for i=2:FMAX
%
    rf(i)=rf(i-1)*octave;
%
    if( rf(i) == max(f) )
    break;
    end
    if( rf(i) > max(f) )
        rf(i)=max(f);
        break;
    end
end
last=i;
%
out1=sprintf(' \n last = %ld   flast = %12.4g\n',last,rf(last));
disp(out1);
%
for i=1:last
%
    for j=1:n
%
        if( rf(i) > f(j) && rf(i) <f(j+1))
            ra(i)=a(j)*( (rf(i)/f(j))^slope(j) );
            break;
        end
%
        if( rf(i)==f(j))
            ra(i)=a(j);
            break;
        end
%
        if( rf(i)==f(j+1))   
            ra(i)=a(j+1);
            break;
        end
    end
end
%
rf(last)=last_f;
ra(last)=last_a;
%
out1=sprintf(' \n last=%ld ',last);
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
jkj=1;
%
best_amp=zeros(last,1);
best_phase=zeros(last,1);
best_delay=zeros(last,1);
best_dampt=zeros(last,1);
%
freq=rf;
clear omega;
omega=tpi*rf;
%
progressbar;
for ia=1:iamax
    progressbar(ia/iamax);
    iflag=0;
%
% disp('  Calculating damped sine parameters.');
    [amp,phase,delay,dampt,sss,first]=...
    DSS_sintime(ns,dt,dur,tpi,ia,iamax,ra,omega,last,syn_error,best_amp,best_phase,best_delay,best_dampt,first);
%
%disp('  Synthesizing initial time history. ');
    [sum,sym]=DSS_th_syn(ns,amp,sss,last);
%
    [xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,sum);
%
    for ijk=1:ntt
%
        for i=1:last
            xx = (xmax(i) + abs(xmin(i)))/2.; 
            if(xx <1.0e-90)
                iflag=1;
            end
            amp(i)=amp(i)*((ra(i)/xx)^0.25);
        end
 %   
        if(iflag==1)
            disp(' ref 1 ');
            break;
        end
%
        [sym,sum]=DSS_scale_th(ns,last,sum,amp,sss);
%
        nk=round(0.9*ns);
        length=ns-nk;
        for i=nk:ns
            x=(i-nk);
            sum(i)=sum(i)*(1-(x/length));
        end
%
        [xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,sum);
%
        [syn_error,iflag]=DSS_srs_error(last,xmax,xmin,ra,iflag);
%
        if(iflag==1)
            disp(' ref 2 ');
            break;
        end
%
        sym= 20*log10(abs(max(sum)/min(sum)));
        sym=abs(sym);
        if( (syn_error < errlit) && (sym < 2.5) || ia==1)
%
            iacase =ia;
            icase = ijk;
%
            errlit = syn_error;
%
            out1=sprintf(' \n %ld %ld  best= %12.4g  sym= %12.4g',ia,ijk,syn_error,sym);
            disp(out1)
            for k=1:last
                best_amp(k)=amp(k);
                best_phase(k)=phase(k);
                best_dampt(k)= dampt(k);
                best_delay(k)=delay(k);
            end
            store=sum;
%
        end
%
        out1=sprintf(' %ld %ld  error= %12.4g   best= %12.4g  ',ia,ijk,syn_error,errlit);
        disp(out1);
%
        if(ijk>8 && syn_error > error_before)  
            break;
        end
        if(ijk>8 && sym>3.0)  
            break;
        end   
        if(ijk>1 && syn_error > 1.0e+90)
            break;
        end
%
        error_before=syn_error;
    end
    disp(' ');
%
    if(jkj==1)
        jkj=2;
    else
        jkj=1;
    end
end
pause(0.5);
progressbar(1); 
%
out1=sprintf(' \n\n Best case is %ld %ld ',iacase,icase);
disp(out1);
%
sum=store;
%
[xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,sum);
%
for i=1:max(size(store))
    tt(i)=(i-1)*dt;
end
%%figure(1);
%%plot(tt,sum);
%%ylabel('Accel(G)');
%%xlabel('Time(sec)');
%%grid on;
%
%%figure(2);
%%plot(freq,xmax,freq,xmin,rf,ra);
%%ylabel('Peak Accel (G)');
%%xlabel('Natural Frequency (Hz)');
%%set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');  
%%out5 = sprintf(' Shock Response Spectrum Q=%g ',Q);
%%title(out5);   
%%grid on;
%
disp(' ');
disp(' Acceleration matrix name: accel_ds ');
%
sz=size(sum);
if(sz(2)>sz(1))
    sum=sum';
end
sz=size(tt);
if(sz(2)>sz(1))
    tt=tt';
end
time_history=[tt sum];
accel_ds=time_history;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 clear dis;
 clear THM; 
 clear aaa;
 clear amp;
 clear amp_original;
 clear ddd;
 clear delay;
 clear disp;
 clear duration;
 clear error;
 clear f;
 clear fl;
 clear fmax;
 clear freq;
 clear fu;
 clear iunit;
 clear mm;
 clear nfr;
 clear nhs;
 clear nt;
 clear num2;
 clear out1;
 clear p;
 clear residual;
 clear sd;
 clear sr;
 clear t;
 clear tp;
 clear tpi; 
 clear velox;
 clear vlast;
 clear vvv;
 clear x1r;
 clear x2r;
 clear x3r;
 clear x4r;
 clear y;
 clear ffmax;
 clear ffmin;
%
MAX=50000;
MAXP=1000;
%
tp=2.*pi;
tpi=tp;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
iscale=1.;
iunit=1;
%
THM = time_history;
%
t=double(THM(:,1));
y=double(THM(:,2));
clear yy;
yy=y;
amp=y;
amp_original=y;
%
ffmin=ffirst;
ffmax=flast;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Perform waveform reconstruction? ');
disp(' 1=yes  2=no ');
wc=input(' ');
%
if(wc==2)
    accel=time_history;
    disp(' ');
    disp(' Acceleration array name: accel ');
%
    figure(1);
    plot(accel(:,1),accel(:,2));
    title(' Acceleration Time History ');
    xlabel(' Time(sec)');
    grid on;
    if(iunit==1)
        ylabel(' Accel(G)');
    else
        ylabel(' Accel(m/sec^2)');  
    end
%
else
%
    ik=0;
%  
    x1r=zeros(MAXP,1);
    x2r=zeros(MAXP,1);
    x3r=zeros(MAXP,1);
    x4r=zeros(MAXP,1);
%
    disp(' ');
    nt=input(' Enter the number of trials per frequency. (suggest 5000) ');
%
    disp(' ');
    nfr=input(' Enter the number of frequencies. (suggest 400) ');
%
    if(nfr>MAXP)
        nfr=MAXP;
    end
%   
    fmax=0.;
%
    residual=y;
%
    num2=max(size(y));
%
    clear y;
%
    out1=sprintf(' number of input points= %d ',num2);
    disp(out1);
%
    duration=t(num2)-t(1);
%
    sr=duration/(num2-1);
    sr=1./sr;
%
    out1=sprintf(' sample rate = %10.4g \n',sr);
    disp(out1);
%
    fl=3./duration;
    fu=sr/5.;
%
    clear y;
%
    progressbar;
    for ie=1:nfr
%
        progressbar(ie/nfr);
%
        out1=sprintf(' frequency case %d ',ie);
        disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        disp(' ref 1');
        [x1r,x2r,x3r,x4r]=...
        DSS_wgen(num2,t,residual,duration,sr,x1r,x2r,x3r,x4r,fl,fu,nt,ie,ffmin,ffmax,first);
        disp(' ref 2');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        if(x2r(ie)<ffmin*tp)
            x2r(ie)=ffmin*tp;
            x1r(ie)=1.0e-20;    
            x3r(ie)=3;
            x4r(ie)=0;
        end
%
        for i=1:num2
%
            tt=t(i);
%
            t1=x4r(ie) + t(1);
            t2=t1 + tp*x3r(ie)/(2.*x2r(ie));
%
            y=0.;
%
            if( tt>= t1 && tt <= t2)
%
                arg=x2r(ie)*(tt-t1);  
                y=x1r(ie)*sin(arg/double(x3r(ie)))*sin(arg);   
%
                residual(i)=residual(i)-y;
            end
        end   
        ave=mean(residual); 
        sd=std(residual);
%
        out1=sprintf(' ave=%12.4g  sd=%12.4g \n\n',ave,sd);
        disp(out1);   
% 
    end
    pause(0.5);
    progressbar(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    clear aaa;
    clear vvv;
    clear ddd;
    clear mm;
%
    aaa=zeros(num2,1); 
    vvv=zeros(num2,1); 
    ddd=zeros(num2,1); 
%
    disp(' ');
%
    kk=0;
%
    for i=1:nfr
%
        if(x2r(i)<ffmin*tp)
            x2r(i)=ffmin*tp;
            x1r(i)=1.0e-20;
            x3r(i)=3;
            x4r(i)=0;
        end
%
        out1=sprintf(' amp=%10.4f   freq=%10.3f Hz   nhs=%d   delay=%10.4f ',x1r(i),x2r(i)/tp,x3r(i),x4r(i));
        disp(out1);
%
        wavelet_table(i,1)=i;
        wavelet_table(i,2)=x2r(i)/tpi;   
        wavelet_table(i,3)=x1r(i);
        wavelet_table(i,4)=x3r(i); 
        wavelet_table(i,5)=x4r(i);  
%
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tf=0.;
%
    vlast=zeros(num2,1);
%
%%num2
%%nfr
%%iscale
    for k=1:num2
%
        tt=t(k);
%  
        for j=1:nfr
%
            w=0.;
            v=0.;
            d=0.;
%
            v1=0.;
            v2=0.;
%
            d1=0.;
            d2=0.;
%
            t1=x4r(j)+t(1);
%
            if(x2r(j)>=1.0e-10)
%
            else
                x2r(j)=ffmin*tp;
                x1r(j)=1.0e-20;
                x3r(j)=3;
                x4r(j)=0;
                t1=x4r(j)+t(1);  
            end
            t2=tp*x3r(j)/(2.*x2r(j))+t1; 
%
            if( tt>=t1  && tt <=t2  )
%
                arg=x2r(j)*(tt-t1);  
%
                w=  x1r(j)*sin(arg/double(x3r(j)))*sin(arg);
%
                aa=x2r(j)/double(x3r(j));
                bb=x2r(j);
%
                te=tt-t1;
%
                alpha1=aa+bb;
                alpha2=aa-bb;
%
                alpha1te=alpha1*te;
                alpha2te=alpha2*te;   
%
                v1= -sin(alpha1te)/(2.*alpha1);
                v2= +sin(alpha2te)/(2.*alpha2);
%
                d1= +(cos(alpha1te)-1)/(2.*(alpha1^2));
                d2= -(cos(alpha2te)-1)/(2.*(alpha2^2));
%
                v=(v2+v1)*iscale*x1r(j);
                d=(d2+d1)*iscale*x1r(j);
%
                vlast(j)=v;
%
            end
%
            aaa(k)=aaa(k)+w; 
            vvv(k)=vvv(k)+v;
            ddd(k)=ddd(k)+d;
%
            amp(k)=amp(k)-w;
%
            if(x3r(j)<1)
                printf(' error x3r ');
                break;
            end
%
        end
%
%%   out1=sprintf(' %d t=%8.4g  %8.4g  %8.4g  %8.4g ',k,t(k),aaa(k),vvv(k),ddd(k));
%%   disp(out1);
    end
%%
    error=[t,amp];
%
    if(iunit==1)
        vvv=vvv*386;
        ddd=ddd*386;
    end
%
    acceleration=[t,aaa];
    velocity=[t,vvv];
    displacement=[t,ddd];
%
    disp(' ');
    disp(' Matlab array names: ');
    disp('  ');
    disp('   acceleration ');
    disp('   velocity ');
    disp('   displacement  ');
%
%%%%%%%%%%%%%%%%%%%%
    figure(1)
    plot(acceleration(:,1),acceleration(:,2));
    title('Acceleration');
    ylabel('Accel(G)');
    xlabel('Time(sec)');
    grid on;
    figure(2)
    plot(velocity(:,1),velocity(:,2));
    title('Velocity');
    if(iunit==1)
        ylabel('Velocity(in/sec)');
    else
        ylabel('Velocity(m/sec)'); 
    end
    xlabel('Time(sec)');
    grid on;
    figure(3)
    plot(displacement(:,1),displacement(:,2));
    title('Displacement');
    if(iunit==1)
        ylabel('Disp(inch)');
    else
        ylabel('Disp(m)');
    end
    xlabel('Time(sec)');
    grid on;
%%%%%%%%%%%%%%%%%%%%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear xmax;
clear xmin;
clear length;
clear freq;
%
xmax=zeros(last,1);
xmin=zeros(last,1);
%
if(wc==1)
    yy=acceleration(:,2);
end
freq=rf;
last=length(freq);
%
clear a1;
clear a2;
clear b1;
clear b2;
clear b3;
%
%*********************** initialize filter coefficients ***************/
%
[a1,a2,b1,b2,b3,~,~,~,~,~]=srs_coefficients(freq,damp,dt);   
%
for j=1:last
% 
    clear resp;
    clear forward;
    clear back;
%   
    forward=[ b1(j),  b2(j),  b3(j) ];
    back   =[ 1, -a1(j), -a2(j) ];
%
    resp=filter(forward,back,yy);
%
    xmax(j)= abs(max(resp));
    xmin(j)= abs(min(resp));
end 
%
if(wc==1)
    figure(4);
else
    figure(2);
end
%
clear rff;
clear raa;
clear length;
%
j=1;
for i=1:length(rf)
    if(rf(i)>1.0e-10)
        rff(j)=rf(i);
        raa(j)=ra(i);
        j=j+1;
    end
end
%
sz=size(xmax);
nmm=sz(1);
clear fff;
fff=freq(1:nmm);
%
plot(fff,xmax,fff,xmin,rff,raa);
ylabel('Peak Accel (G)');
xlabel('Natural Frequency (Hz)');
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');  
out5 = sprintf(' Shock Response Spectrum Q=%g ',Q);
title(out5);   
legend ('positive','negative','spec');   
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(wc==1)
    disp(' ');
    disp(' Export to ASCII text ');
    disp(' 1=yes  2=no ');
    et=input(' ');
    if(et==1)
%
        out1=sprintf('\n Enter the acceleration time history output filename: ');
        disp(out1);
        output_filename1 = input(' ','s');
        out1=sprintf('\n Enter the velocity time history output filename: ');
        disp(out1);
        output_filename2 = input(' ','s');
%
        out1=sprintf('\n Enter the displacement time history output filename: ');
        disp(out1);
        output_filename3 = input(' ','s');
%
        out1=sprintf('\n Enter the wavelet table output filename: ');
        disp(out1);
        output_filename4 = input(' ','s');
%
        save(output_filename1,'acceleration','-ASCII')
        save(output_filename2,'velocity','-ASCII')
        save(output_filename3,'displacement','-ASCII')
        save(output_filename4,'wavelet_table','-ASCII')
%
    end
end
toc
%%%%%%%%%%%%%%%%%%%%