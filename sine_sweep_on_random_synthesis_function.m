%
%  sine_sweep_on_random_synthesis_function.m  ver 1.0  by Tom Irvine
%
%  This script synthesizes a time history for a sine sweep-on-random specification
%
%  psd = psd specification array with two columns: freq(Hz) & accel(G^2/Hz)  
%  Input variables:
%
%  dur = duration (sec)
%  sine_sweep = sine sweep array with three columns: 
%                                  start freq(Hz), end freq (Hz) & accel(G)
%
%  rate='log' or 'lin' for sine sweep
%
%  Output variables
%
%  input_time_history = synthesized acceleration time history: 
%                                                   time(sec) &  accel(G)
%
%  The input_time_history is not corrected for zero net velocity & zero net
%  displacement
%
function[input_time_history]=sine_sweep_on_random_synthesis_function(dur,psd,sine_sweep,rate)
%
    sine_sweep = sortrows(sine_sweep,1);
%
% find maximum & minimum excitation frequencies
%
    max_freq=max([ psd(end,1) sine_sweep(end,2)]); 
%    min_freq=min([ psd(1,1) sine_sweep(1,1)]); 
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
    [psd_synth]=synthesize_psd(psd,num,dt);
%
    total_synth=sine_sweep_synth+psd_synth(1:num);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    input_time_history=[t total_synth];
    