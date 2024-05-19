% 
%  SRS Synthesis using Damped Sinusoids with Wavelet Reconstruction
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' damped_sine_syn.m  ver 3.8  October 8, 2012 ');
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
clear sum;
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
%
clear velox;
clear ddisp;
%
clear store_a;
clear store_v;
clear store_d;
%
fig_num=1;
%
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
fspec=f;
aspec=a;
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
dre=4/fspec(1);
disp(' ');
disp(' Enter duration (sec): ');
out1=sprintf(' (recommend >= %8.4g) ',dre);
disp(out1);
dur=input('  ');
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
    [amp,phase,delay,dampt,sss]=...
    DSS_sintime(ns,dt,dur,tpi,ia,iamax,ra,omega,last,syn_error,best_amp,best_phase,best_delay,best_dampt);
%
%disp('  Synthesizing initial time history. ');
    [accel,sym]=DSS_th_syn(ns,amp,sss,last);
%
    [xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,accel);
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
        [sym,accel]=DSS_scale_th(ns,last,accel,amp,sss);
%
        nk=round(0.9*ns);
        length=ns-nk;
        for i=nk:ns
            x=(i-nk);
            accel(i)=accel(i)*(1-(x/length));
        end
%
        [accel,velox,ddisp]=DSS_velocity_correction(dt,accel);
%
        [xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,accel);
%
        [syn_error,iflag]=DSS_srs_error(last,xmax,xmin,ra,iflag);
%
        if(iflag==1)
            disp(' ref 2 ');
            break;
        end
%
        sym= 20*log10(abs(max(accel)/min(accel)));
        sym=abs(sym);
        if( (syn_error < errlit) && (sym < 1.8) || ia==1)
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
            store_a=accel;
            store_v=velox;
            store_d=ddisp;
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
for i=1:max(size(store_a))
    tt(i)=(i-1)*dt;
end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
accel=store_a;
velox=store_v;
ddisp=store_d;
%
conv=386;
%
tt=fix_size(tt);
accel=fix_size(accel);
velox=fix_size(velox);
ddisp=fix_size(ddisp);
%
    acceleration=[tt accel];
        velocity=[tt velox*conv];
    displacement=[tt ddisp*conv];
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,accel);
%
%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%
%
iunit=1;
%
figure(fig_num);
fig_num=fig_num+1;
plot(acceleration(:,1),acceleration(:,2));
title('Acceleration');
ylabel('Accel(G)');
xlabel('Time(sec)');
grid on;
figure(fig_num);
fig_num=fig_num+1; 
plot(velocity(:,1),velocity(:,2));
title('Velocity');
if(iunit==1)
        ylabel('Velocity(in/sec)');
else
        ylabel('Velocity(m/sec)'); 
end
xlabel('Time(sec)');
grid on;
figure(fig_num);
fig_num=fig_num+1;
plot(displacement(:,1),displacement(:,2));
title('Displacement');
if(iunit==1)
        ylabel('Disp(inch)');
else
        ylabel('Disp(m)');
end
xlabel('Time(sec)');
grid on;
%
%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
sz=size(xmax);
nmm=sz(1);
clear fff;
fff=freq(1:nmm);
%
plot(fff,xmax,'b',fff,xmin,'r', fspec,aspec,'k',fspec,1.414*aspec,'k',fspec,0.7071*aspec,'k');
ylabel('Peak Accel (G)');
xlabel('Natural Frequency (Hz)');
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');  
out5 = sprintf(' Shock Response Spectrum Q=%g ',Q);
title(out5);   
legend ('positive','negative','spec & 3 dB tol');   
grid on;
%
fff=fix_size(fff);
xmax=fix_size(xmax);
xmin=fix_size(xmin);
%
shock_response_spectrum=[fff xmax xmin];
%
toc
%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Output arrays ')
disp(' ');
disp('   acceleration ');
disp('   velocity ');
disp('   displacement ');
disp('   shock_response_spectrum ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

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
        save(output_filename1,'acceleration','-ASCII')
        save(output_filename2,'velocity','-ASCII')
        save(output_filename3,'displacement','-ASCII')
%
end