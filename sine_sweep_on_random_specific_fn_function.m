%
%  sine_sweep_on_random_function_specific_fn.m  ver 1.0  by Tom Irvine
%
%  This script calculates the vibration response spectrum for a 
%  sine sweep-on-random specification
%
%  Input variables:
%
%  dur = duration (sec)
%  psd = psd specification array with two columns: freq(Hz) & accel(G^2/Hz)  
%  sine_sweep = sine sweep array with three columns: start freq(Hz), end freq (Hz) & accel(G)
%  rate='log' or 'lin' for sine sweep
%
%  fn = natural frequency (Hz)
%  Q = amplification factor (typically Q=10)
%
%  Output variables
%
%  accel_rms = acceleration response overall level (GRMS)  
%  accel_peak = accleration response peak(G)
%
%  pv_rms = pseudo velocity response overall level (in/sec) RMS  
%  pv_peak = pseudo velocity response peak (in/sec) 
%
%  input_time_history = synthesized acceleration time history: 
%                                                   time(sec) &  accel(G)
%
%  The input_time_history is not corrected for zero net velocity & zero net
%  displacement
%
function[accel_rms,accel_peak,pv_rms,pv_peak,input_time_history]=sine_sweep_on_random_specific_fn_function(dur,psd,sine_sweep,rate,fn,Q)
%
    sine_sweep = sortrows(sine_sweep,1);
%
% find maximum & minimum excitation frequencies
%
    max_freq=max([ psd(end,1) sine_sweep(end,2)]);  
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
%  Synthesize sine sweep time history
%
    [sine_sweep_synth]=sine_sweep_synth_function(sine_sweep,rate,t);
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
    total_synth=sine_sweep_synth+psd_synth(1:num);
    input_time_history=[t total_synth];
%
%   response calculation
%
    num_fn=length(fn); 
    [accel_peak,accel_rms,pv_peak,pv_rms]=vrs_srs(Q,fn,num_fn,total_synth,dt);

  
  
end