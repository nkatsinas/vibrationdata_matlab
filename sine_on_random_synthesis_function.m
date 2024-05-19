%
% sine_on_random_synthesis_function.m  ver 1.0  by Tom Irvine
%
%  Input variables:
%
%  dur = duration (sec)
%  psd = psd specification array with two columns: freq(Hz) & accel(G^2/Hz)  
%  sine = sine array with two columns: freq(Hz) & accel(G)
%
%  Output variables:
%
%  Syntehsized time histories
%
%  accel_th: time(sec) &  accel(G)
%    vel_th: time(sec) &  vel(in/sec)
%   disp_th: time(sec) &  disp(in)

%  The acceleration time history is corrected for zero net velocity & zero net
%  displacement
%
function[accel_th,vel_th,disp_th]=sine_on_random_synthesis_function(dur,psd,sine)
%
    sine = sortrows(sine,1);
%
% find maximum & minimum excitation frequencies
%
    max_freq=max([ psd(end,1) sine(end,1)]);
    min_freq=min([ psd(1,1) sine(1,1)]);
%
% sample rate
%
    sr=12*max_freq;
%
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
%  Synthesize sine time history
%
    f=sine(:,1);
    amp=sine(:,2);
    tpi=2*pi;
%
    number_sines=length(f);
%
%  The sine_synth array stores the amplitude at each time step
%
    sine_synth=zeros(num,1);
%
    for i=1:number_sines
        sine_synth=sine_synth+amp(i)*sin(tpi*f(i)*t);
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   synthesize time history for psd
%
    [psd_synth]=synthesize_psd(psd,num,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   combine sine & random
%
    total_synth=sine_synth+psd_synth(1:num);

    amp=total_synth;
    kvn=1;
    iunit=1;  % English unit
    
    [accel,velox,dispx]=velox_correction(amp,dt,kvn,min_freq,iunit);
    
    accel=fix_size(accel);
    velox=fix_size(velox);
    dispx=fix_size(dispx);

    accel_th=[t accel];
      vel_th=[t velox];
     disp_th=[t dispx];
    
end