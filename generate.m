disp(' ')
disp(' generate.m  ver 3.4   October 11, 2018 ')
disp(' By Tom Irvine   Email:  tom@irvinemail.org ')
disp(' ')
%
close all;
%
clear TT;
clear td;
clear a;
clear b;
clear d;
clear v;
clear sum;
clear tmax;
clear sr;
clear dt;
clear np;
clear arg;
clear t;   
%
fig_num=1;
%
disp(' ')
disp('  Enter the signal type ')
disp('  1=sine ');
disp('  2=cosine ');
disp('  3=damped sine  ')
disp('  4=sine sweep  ')
disp('  5=white noise ')
disp('  6=terminal sawtooth pulse')
disp('  7=symmetric sawtooth pulse')
disp('  8=half-sine pulse ')
disp('  9=versed sine pulse');
disp('  10=wavelet ')
disp('  11=rectangular pulse ')
disp('  12=beat frequency ');
%
type=input(' '); 
%
clear t;
%
if( type==1)  % sine
%
    peak = input('  Enter peak amplitude ');  
    tmax = input('  Enter the duration (sec) ');    
    sr = input('  Enter the sample rate (samples/seconds) ');
    dt=1./sr;
    disp(' ')
    freq = input('  Enter the frequency (Hz) ');
    omega=2.*pi*freq;
    omegan=omega;
    phase = input('  Enter the phase angle (deg) ');
    phase=phase*pi/180.;
%    
    if(freq>(sr/20))
       sr=freq*20;
       dt=1/sr;
       disp('Note: sample rate increased ');
       disp(' ');
    end    
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1));  
%    
    a=peak*sin(omega*TT+phase);
%
end
if( type==2)  % cosine
%   
    peak = input('  Enter peak amplitude ');  
    tmax = input('  Enter the duration (sec) ');
    sr = input('  Enter the sample rate (samples/seconds) ');
    dt=1./sr;
    disp(' ')
    freq = input('  Enter the frequency (Hz) ');
    omega=2.*pi*freq;
    omegan=omega;
%    
    if(freq>(sr/20))
       sr=freq*20;
       dt=1/sr;
       disp('Note: sample rate increased ');
       disp(' ');
    end    
%
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1)); 
    arg = zeros(1,(np+1));  
%
    a=peak*cos(omega*TT);
%
end
if( type==3)  % damped sine
    peak = input('  Enter peak amplitude ');      
    disp(' ')
    t1 = input('  Enter the start time (sec) ');
    disp(' ')
    t2 = input('  Enter the end time (sec) ');
    disp(' ')  
%
    if(t2<=t1)
        disp(' Time Input Error ');
        exit;
    end
%
    td = input('  Enter the delay (sec) ');
%
    sr = input('  Enter the sample rate (samples/seconds) ');
    dt=1./sr;
%
    disp(' ')
    freq = input('  Enter the frequency (Hz) ');
    omega=2.*pi*freq;
    omegan=omega;
%    
    if(freq>(sr/20))
       sr=freq*20;
       dt=1/sr;
       disp('Note: sample rate increased ');
       disp(' ');
   end
%
    np=fix((t2-t1)/dt);
    TT=linspace(0,np*dt,(np+1)); 
    TT=TT+t1;
%    
    disp(' ')
    damp = input('  Enter the damping ratio  ');    
%
    omegad=omegan*sqrt(1-damp^2);
    out5 = sprintf('\n omegad= %8.4g rad/sec ',omegad);
    disp(out5);      
% 
    td=td+t1;
    for i=1:(np+1)
        if(TT(i)>td)
            a(i)=peak*sin(omegad*(TT(i)-td));
            arg=-omegan*damp*(TT(i)-td);
            a(i)=a(i)*exp(arg);
        else
            a(i)=0;
        end
    end
end
if( type==4)   % sine sweep  
   tmax = input('  Enter the duration (sec) ');
   [TT,a,~] = sweep(tmax);
end
if( type==5)   % random white noise
    tmax = input('  Enter the duration (sec) '); 
    sr = input('  Enter the sample rate (samples/seconds) ');
    dt=1./sr;   
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1));
    np=length(TT);
%     
    sigma=1;
    [a]=simple_white_noise(mu,sigma,np);
    TT=fix_size(TT);
%
end
if( type==6)   % terminal sawtooth pulse
    peak = input('  Enter peak amplitude ');  
    sr = input('  Enter the sample rate (samples/seconds) ');
    dt=1./sr;    
%
    t1=input(' Enter pre-pulse duration (sec)  ');
    t2=input(' Enter pulse duration     (sec)  ');
    t3=input(' Enter post-pulse duration(sec)  ');
    t12=t1+t2;   
%
    tmax=t1+t2+t3;
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1)); 
    a = zeros(1,(np+1));   
    for i=1:np
        t=TT(i);
        if(t>=t1 && t<=t12)
            a(i) = (t-t1)/t2;
        end
        if(t>=t12)
            break;
        end
    end
    a=a*peak;
end
if( type==7)   % symmetric sawtooth pulse
    peak = input('  Enter peak amplitude ');  
    sr = input('  Enter the sample rate (samples/seconds) ');
    dt=1./sr;    
%
    t1=input(' Enter pre-pulse duration (sec)  ');
    t2=input(' Enter pulse duration     (sec)  ');
    t3=input(' Enter post-pulse duration(sec)  ');
    t12=t1+t2;   
    t2half=t2/2;
    t12h=t1+t2half;
%
    tmax=t1+t2+t3;
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1)); 
    a = zeros(1,(np+1));   
    for i=1:np
        t=TT(i);
        if(t>=t1 && t<t12h)
            a(i) = (t-t1)/t2half;
        end
        if(t>=t12h && t<t12)
            a(i) = 1-((t-t12h)/t2half);
        end 
        if(t>=t12)
            break;
        end
    end
    a=a*peak;
end
if( type==8)   % half-sine pulse
    peak = input('  Enter peak amplitude ');  
    sr = input('  Enter the sample rate (samples/seconds) ');
    dt=1./sr;    
%
    t1=input(' Enter pre-pulse duration (sec)  ');
    t2=input(' Enter pulse duration     (sec)  ');
    t3=input(' Enter post-pulse duration(sec)  ');
    t12=t1+t2;   
%
    tmax=t1+t2+t3;
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1)); 
    a = zeros(1,(np+1));   
    for i=1:np
        t=TT(i);
        if(t>=t1 && t<=t12)
            a(i) = sin(pi*(t-t1)/t2);
        end
        if(t>=t12)
            break;
        end
    end
    a=a*peak;
end
if( type==9)   % versed sine pulse
    peak = input('  Enter peak amplitude ');      
    sr = input('  Enter the sample rate (samples/seconds) ');
    dt=1./sr;    
%%
    t1=input(' Enter pre-pulse duration (sec)  ');
    t2=input(' Enter pulse duration     (sec)  ');
    t3=input(' Enter post-pulse duration(sec)  ');
    t12=t1+t2;
%
    tmax=t1+t2+t3;
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1)); 
    a = zeros(1,(np+1));   
    for i=1:np
        t=TT(i);
        if(t>=t1 && t<=t12)
            a(i) = 1-cos(2*pi*(t-t1)/t2);
        end
        if(t>=t12)
            break;
        end
    end
%%
    a=a*peak/2;
%
end
if( type==10)   % wavelet pulse 
    peak = input('  Enter peak amplitude ');  
    sr = input('  Enter the sample rate (samples/seconds) ');
    dt=1./sr;
%    
    disp(' ')
    freq = input('  Enter the frequency (Hz) ');
    omega=2.*pi*freq;
    omegan=omega;
%    
    if(freq>(sr/20))
       sr=freq*20;
       dt=1/sr;
       disp('Note: sample rate increased ');
       disp(' ');
    end    
%
    iflag=0;
    while(iflag==0)
        N=input(' Enter number of half-sines, odd integer >=3 ');
%    
        for i=3:2:100
            if(N==i)
                iflag=1;
                break;
            end
        end
    end
%
    td = input('  Enter the delay (sec) ');
    tmax=N/(2*freq)+td;  
%
    disp(' ')
    t1 = input('  Enter the start time (sec) ');
    disp(' ')
    out1=sprintf('  Enter the end time (sec)  suggest >= %8.4g ',tmax);
    disp(out1);
    t2=input(' ');
    disp(' ')
%
    if(t2<=t1)
        disp(' Time Input Error ');
        exit;
    end
%
    if(td>t2)
        disp(' ');   
        disp(' Warning: delay time > end time ');
        disp(' ');
    end
%
    np=fix((t2-t1)/dt);
    TT=linspace(0,np*dt,(np+1)); 
    TT=TT+t1;
%
    beta= (2*pi*freq);
    alpha= beta/N;    
%
    np=max(size(TT));
    for(i=1:np)
        t=TT(i);
        a(i)=0.;
        v(i)=0.;
        d(i)=0.;
        if(t>=td && t<= tmax)
            a(i) = sin(pi*t/tmax);
            apb=alpha+beta;
            amb=alpha-beta;
            ttd=t-td;
%            
            at=alpha*(ttd);
            bt= beta*(ttd);
%
            a(i)= sin(at)*sin(bt);
            v(i)=-(sin(apb*ttd)/apb) + (sin(amb*ttd)/amb);
            d(i)=+((cos(apb*ttd)-1)/apb^2)-((cos(amb*ttd)-1)/amb^2);
        end
    end
    a= a*peak;
    v= v*peak/2;
    d= d*peak/2;
end
if( type==11)   % rectangular pulse 
    peak = input('  Enter peak amplitude ');  
    sr = input('  Enter the sample rate (samples/seconds) ');
    dt=1./sr;
%
    disp(' ');
    t1=input('  Enter pre-pulse duration (sec)  ');
    t2=input('  Enter pulse duration (sec)      ');
    t3=input('  Enter post-pulse duration (sec) ');
%
    t12=t1+t2;
%
    ttt=t1+t2+t3;
    nnn=round(ttt*sr);
%
    a=zeros(nnn,1);
    TT=zeros(nnn,1);
 %   
    for i=1:nnn
        t=(i-1)*dt;
        TT(i)=t;
        if(t>=t1 && t<=t12)
            a(i)=peak;
        end
    end
%
end    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if( type==12)  % beat frequency
%
    disp(' ');
    N=input(' Enter the number of sines ');
%
    for i=1:N
        disp(' ');
        freq(i) = input(' Enter frequency (Hz)  ');
        peak(i) = input('  Enter peak amplitude '); 
    end    
%
    disp(' ');
    tmax = input('  Enter the duration (sec) ');    
    sr = input('  Enter the sample rate (samples/seconds) ');
    dt=1./sr;
    disp(' ')
%    
    omega=2.*pi*freq;
    omegan=omega;
%    
    fmax=max(freq);
    if(fmax>(sr/20))
       sr=fmax*20;
       dt=1/sr;
       disp('Note: sample rate increased ');
       disp(' ');
    end    
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1)); 
    a = zeros(1,(np+1));  
%    
    for i=1:N
        a=a+peak(i)*sin(omega(i)*TT);
    end    
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output options
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(TT,a);
    xlabel('Time(sec)');
    grid on;
    zoom on;   
%    
    if( type==4)    
        out5 = sprintf(' Sine Time History   std dev=%8.3g ',std(a));
        title(out5);   
    end
    if( type==4)    
        out5 = sprintf(' Cosine Time History   std dev=%8.3g ',std(a));
        title(out5);   
    end
    if( type==4)    
        out5 = sprintf(' Damped Sine Time History ');
        title(out5);   
    end
    if( type==4)    
        out5 = sprintf(' Sine Sweep Time History   std dev=%8.3g ',std(a));
        title(out5);   
    end
    if( type==5)    
        out5 = sprintf(' White Noise Time History   std dev=%8.3g ',std(a));
        title(out5);   
    end
    if( type==6)    
        out5 = sprintf(' Terminal Sawtooth Pulse ');
        title(out5);   
    end
    if( type==7)    
        out5 = sprintf(' Symmetric Sawtooth Pulse ');
        title(out5);   
    end   
    if( type==8)    
        out5 = sprintf(' Half-Sine Pulse ');
        title(out5);   
    end
    if( type==9)    
        out5 = sprintf(' Versed Sine Time History ');
        title(out5);   
    end
    if( type==10)    
        out5 = sprintf(' Wavelet Time History ');
        title(out5);   
    end    
    if( type==11)    
        out5 = sprintf(' Rectangular Pulse ');
        title(out5);   
    end     
    if( type==12)    
        out5 = sprintf(' Beat Frequency ');
        title(out5);   
    end      
%    
    xlabel(' Time (sec)');
%
    disp(' ');
    disp(' Invert time history? ');
    disp(' 1=yes 2=no ');
    iv=input(' ');
    if(iv==1)
        a=-a;
        if( type==10)    
            v=-v;
            d=-d;
        end
        plot(TT,a);   
    end
    disp(' ')
    disp(' Plot histogram? ')
    choice = input(' 1=yes 2=no ');
%
    if(choice == 1)
       [fig_num]=plot_histogram(a,'Amplitude',fig_num);       
    end
%
%  Rename matlab matrices with descriptive names
%
np=size(TT);
if(type==1)
    clear sine;
    sine=[TT;a]'; 
    out5 = sprintf('\n\n The time history is renamed as "sine" ');
    disp(out5);     
end
if(type==2)
    clear cosine;
    cosine=[TT;a]'; 
    out5 = sprintf('\n\n The time history is renamed as "cosine" ');
    disp(out5);     
end
if(type==3)
    clear damped_sine;
    damped_sine=[TT;a]';  
    out5 = sprintf('\n\n The time history is renamed as "damped_sine" ');
    disp(out5);       
end
if(type==4)
    clear sine_sweep;
    sine_sweep=[TT;a]'; 
    out5 = sprintf('\n\n The time history is renamed as "sine_sweep" ');
    disp(out5);    
end
if(type==5)
    clear white_noise;
    white_noise=[TT;a]'; 
    out5 = sprintf('\n\n The time history is renamed as "white_noise" ');
    disp(out5);       
end
if(type==6)
    clear terminal_sawtooth_pulse;
    terminal_sawtooth_pulse=[TT;a]'; 
    out5 = sprintf('\n\n The time history is renamed as "terminal_sawtooth" ');
    disp(out5);       
end
if(type==7)
    clear symmetric_sawtooth_pulse;
    symmetric_sawtooth_pulse=[TT;a]'; 
    out5 = sprintf('\n\n The time history is renamed as "terminal_sawtooth_pulse" ');
    disp(out5);       
end
if(type==8)
    clear half_sine_pulse;
    half_sine_pulse=[TT;a]'; 
    out5 = sprintf('\n\n The time history is renamed as "half_sine_pulse" ');
    disp(out5);       
end
if(type==9)
    clear versed;
    versed=[TT;a]'; 
    out5 = sprintf('\n\n The time history is renamed as "versed" ');
    disp(out5);       
end
if(type==10)
    clear wavelet_acc;
    clear wavelet_vel;
    clear wavelet_disp;    
    wavelet_acc=[TT;a]'; 
    wavelet_vel=[TT;v]'; 
    wavelet_disp=[TT;d]';      
    disp(' The output time histories are: ');
    disp('    wavelet_acc ');
    disp('    wavelet_vel   ');
    disp('    wavelet_disp  ');    
end
if(type==11)
    clear rectangular;
    sz=size(a);
    if(sz(2)>sz(1))
        a=a';
    end
    rectangular=[TT a]; 
    out5 = sprintf('\n\n The time history is renamed as "rectangular" ');
    disp(out5);       
end
if(type==12)
    clear beat;
    beat=[TT;a]'; 
    out5 = sprintf('\n\n The time history is renamed as "beat" ');
    disp(out5);       
end
%
clear amp;
clear length;
amp=a;
%
    n = length(amp);

    
    [mu,sd,rms,sk,kt]=kurtosis_stats(amp);
    [tt_max,tt_min,mx,mi]=max_min_times(TT,amp);
%
%
    disp(' ')
    disp(' Amplitude Stats ')
     out0 = sprintf(' number of points = %d ',n);
    out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
    out2a = sprintf(' max  = %9.4g  at  = %8.4g sec             ',mx,tt_max);
    out2b = sprintf(' min  = %9.4g  at  = %8.4g sec            \n',mi,tt_min);
    disp(out0);
    disp(out1);
    disp(out2a);
    disp(out2b);
%
    amax=abs(mx);
    amin=abs(mi);
    if(amax<amin)
        amax=amin;
    end
    crest=amax/rms;
    out4 = sprintf(' crest factor = %8.4g ',crest);
    out5 = sprintf(' skewness = %8.4g  kurtosis  = %8.4g ',sk,kt);
    disp(out4);
    disp(out5);
%
%
%
disp(' ')
disp(' Save output time history to ASCII text file? ');
choice=input(' 1=yes   2=no  ' );
disp(' ')   
if choice == 1 
        disp(' Enter output filename ');
        g_filename = input(' ','s');
%
        fid = fopen(g_filename,'w');
        np=max(size(a));       
        for j=1:np
            fprintf(fid,'%16.8e \t %10.4e \n',TT(j),a(j));
        end
        fclose(fid);   
%       load(g_filename);
end    