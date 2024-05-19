%
%   SSOR_synth_function_alt.m  ver 1.0  by Tom Irvine
%

function[total_synth,velox,dispx,fig_num]=SSOR_synth_function_alt(psd,sine_sweep,fig_num,dur,rate)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fstart=sine_sweep(:,1);
fend=sine_sweep(:,2);
amp=sine_sweep(:,3);

ss_fmax=max(fend);
psd_fmax=max(psd(:,1));

sr=12*max([ ss_fmax  psd_fmax ]);

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
    t=zeros(num,1);
    for i=1:num
        t(i)=(i-1)*dt;
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Synthesize sine sweep time history
%
    [sine_sweep_synth]=sine_sweep_synth_function(sine_sweep,rate,t);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
  
    fq=psd(1,1)/2^(1/6);
    
    psd=[ fq  psd(1,2) ;  psd ];

    [psd_synth]=synthesize_psd(psd,num,dt);
%
    total_synth=sine_sweep_synth+psd_synth(1:num);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

disp(' Overall Levels (GRMS)');
disp(' ');
fprintf('  Sine Sweep:  %7.3g  \n',std(sine_sweep_synth));
fprintf('   PSD Synth:  %7.3g  \n',std(psd_synth));
fprintf(' Total Synth:  %7.3g  \n',std(total_synth));

amp=total_synth;
iunit=1;
freq_spec(1)=psd(1,1);
kvn=1;

[amp,velox,dispx]=velox_correction(amp,dt,kvn,freq_spec(1),iunit);

amp=fix_size(amp);

total_synth=[t amp];
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

unit='G';
aat=sprintf('Base Input Acceleration Time History  %7.3g %s rms',std(amp),unit);
ay=sprintf('Acceleration (%s)',unit);

if(iunit==1)
    unit='in/sec';
else
    unit='cm/sec';    
end
vvt=sprintf('Base Input Velocity Time History %7.3g %s rms',std(velox),unit);
vy=sprintf('Velocity (%s)',unit);

if(iunit==1)
    unit='in';
else
    unit='mm';    
end
ddt=sprintf('Base Input Displacement Time History  %7.3g %s rms',std(dispx),unit);
dy=sprintf('Displacement (%s)',unit);

tt=t;
a=amp;
v=velox;
d=dispx;
[fig_num,hp]=plot_avd_time_histories_subplots_altp_titles(fig_num,tt,a,v,d,ay,vy,dy,aat,vvt,ddt);
