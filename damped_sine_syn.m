% 
%  SRS Synthesis using Damped Sinusoids with Wavelet Reconstruction
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' damped_sine_syn.m  ver 4.2  March 4, 2014 ');
disp(' by Tom Irvine');
disp(' Email:  tom@vibrationdata.com ');
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
clear srs_syn;
%
fig_num=1;
%
iunit=1;
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
while(1)
    disp(' Select units ');
    disp('  1=English: accel(G), vel(in/sec),  disp(in)  ');
    disp('  2=metric : accel(G), vel(m/sec),  disp(mm)  '); 
    iunit=input(' ');
    if(iunit==1 || iunit==2)
        break;
    end
end	
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
srs_spec=[f a];
%
ffirst=f(1);
flast=f(n);
last_f=f(n);
last_a=a(n);
%
ffmin=ffirst;
ffmax=flast;
%
%
for i=1:(n-1)
    slope(i)=log(a(i+1)/a(i))/log(f(i+1)/f(i));
end
%
%
dre=4/f(1);
disp(' ');
disp(' Enter duration (sec): ');
out1=sprintf(' (recommend >= %8.4g) ',dre);
disp(out1);
dur=input('  ');
%
%% first=0.15*dur;
first=0;
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
iamax=input(' Enter number of iterations for outer loop (min=10 max=5000)');
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    DSS_sintime(ns,dt,dur,tpi,ia,iamax,ra,omega,last,syn_error,...
                          best_amp,best_phase,best_delay,best_dampt,first);
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
        fper=3;
        fper=fper/100;
%
%        n=length(y);
        n=ns;
%
        na=round(fper*n);
        nb=n-na;
        delta=n-nb;
%
        for i=1:na
            arg=pi*(( (i-1)/(na-1) )+1); 
            sum(i)=sum(i)*0.5*(1+(cos(arg)));
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
            out1=sprintf(' \n %ld %ld  best= %12.4g  sym= %12.4g',ia,...
                                                        ijk,syn_error,sym);
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
        out1=sprintf(' %ld %ld  error= %12.4g   best= %12.4g  ',ia,ijk,...
                                                         syn_error,errlit);
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
store;
%
[xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,store);
%
freq=fix_size(freq);
xmin=fix_size(xmin);
xmax=fix_size(xmax);
%
clear length;
nnn=length(xmax);
ff=freq(1:nnn);
clear freq;
freq=ff;
%
srs_syn=[freq xmin xmax];
%
clear tr;
clear store_recon;
%
tr=linspace(0,(ns-1)*dt,ns);
store_recon=store;
%
[acceleration]=add_pre_shock(store,dur,dt);
%
clear store;
%
tt=acceleration(:,1);
store=acceleration(:,2);
%
[v]=integrate_function(store,dt);
%
[d]=integrate_function(v,dt);
%
v=fix_size(v);
d=fix_size(d);
velocity=[tt v];
displacement=[tt d];
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Perform waveform reconstruction? ');
disp(' 1=yes  2=no ');
wc=input(' ');
%
if(wc==1)
%
    [acceleration,velocity,displacement,srs_syn,wavelet_table]=...
    DSS_waveform_reconstruction(tr,store_recon,dt,first,freq,ffmin,...
                                                         ffmax,damp,iunit);
%
    [acceleration]=add_pre_shock(acceleration(:,2),dur,dt);
    [velocity]    =add_pre_shock(velocity(:,2),dur,dt);
    [displacement]=add_pre_shock(displacement(:,2),dur,dt);
%    
end
toc
%
[fig_num]=...
plot_avd_srs_damped_sine(acceleration,velocity,displacement,srs_syn,...
                                              srs_spec,damp,fig_num,iunit);
%
%%%%%%%%%%%%%%%%%%%%
%
clear shock_response_spectrum;
%
shock_response_spectrum=srs_syn;
%
disp(' ');
disp(' Matlab array names: ');
disp('  ');
disp('   acceleration ');
disp('   velocity ');
disp('   displacement  ');
disp('   shock_response_spectrum  ');
disp('   wavelet_table ');
%
%%%%%%%%%%%%%%%%%%%%
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
        out1=sprintf('\n Enter the shock response spectrum output filename: ');
        disp(out1);
        output_filename4 = input(' ','s');
%
        if(wc==1)
            out1=sprintf('\n Enter the wavelet table output filename: ');
            disp(out1);
            output_filename5 = input(' ','s');
        end
%
        save(output_filename1,'acceleration','-ASCII')
        save(output_filename2,'velocity','-ASCII')
        save(output_filename3,'displacement','-ASCII')
        save(output_filename4,'shock_response_spectrum','-ASCII')
        if(wc==1)
            save(output_filename5,'wavelet_table','-ASCII')
        end
%
end