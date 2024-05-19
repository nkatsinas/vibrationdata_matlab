%
%  SOR_synth_function.m  ver 1.0  by Tom Irvine
%
function[total_synth,fig_num]=SOR_synth_function(psd,fsine,amp,phase,fig_num,dur,iunit)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=length(fsine);

s_fmax=max(fsine);
psd_fmax=max(psd(:,1));

sr=12*max([ s_fmax  psd_fmax ]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% time step
%
    dt=1/sr;
%
%  total number of steps
%
    num=floor(dur/dt);
%
%  define time vector
%
    t=(0:1:num-1)*dt;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Synthesize sine time history
%   
    num=length(t);
    sine_synth=zeros(num,1);

    omega=2*pi*fsine;
    
    t=fix_size(t);
    
    for i=1:N
        arg=omega(i)*t+phase(i);
        sine_synth(:,1)=sine_synth(:,1)+amp(i)*sin(arg);
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
  
    fq=psd(1,1)/2^(1/6);
    
    psd=[ fq  psd(1,2) ;  psd ];

    [psd_synth]=synthesize_psd(psd,num,dt);
%
    total_synth=sine_synth+psd_synth(1:num);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

disp(' Input Overall Levels (GRMS)');
disp(' ');
fprintf('  Sine Synth:  %7.3g  \n',std(sine_synth));
fprintf('   PSD Synth:  %7.3g  \n',std(psd_synth));
fprintf(' Total Synth:  %7.3g  \n',std(total_synth));

amp=total_synth;
freq_spec(1)=psd(1,1);
kvn=1;

[amp,velox,dispx]=velox_correction(amp,dt,kvn,freq_spec(1),iunit);

t=fix_size(t);
amp=fix_size(amp);

total_synth=[t amp];

unit='G';
aat=sprintf('Acceleration Time History Synthesis  %7.3g %s rms',std(amp),unit);
ay=sprintf('Acceleration (%s)',unit);

if(iunit==1)
    unit='in/sec';
else
    unit='cm/sec';    
end
vvt=sprintf('Velocity Time History Synthesis  %7.3g %s rms',std(velox),unit);
vy=sprintf('Velocity (%s)',unit);

if(iunit==1)
    unit='in';
else
    unit='mm';    
end
ddt=sprintf('Displacement Time History Synthesis  %7.3g %s rms',std(dispx),unit);
dy=sprintf('Displacement (%s)',unit);

tt=t;
a=amp;
v=velox;
d=dispx;
[fig_num,hp]=plot_avd_time_histories_subplots_altp_titles(fig_num,tt,a,v,d,ay,vy,dy,aat,vvt,ddt);


            