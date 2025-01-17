%
fix later...

%  sine_sweep_on_random_fds_function.m  ver 1.0  by Tom Irvine
%
%  This script calculates the vibration response spectrum for a 
%  sine sweep-on-random specification
%
%  psd = psd specification array with two columns: freq(Hz) & accel(G^2/Hz)  
%  Input variables:
%
%  dur = duration (sec)
%  sine_sweep = sine sweep array with three columns: start freq(Hz), end freq (Hz) & accel(G)
%  rate='log' or 'lin' for sine sweep
%
%  Q = amplification factor (typically Q=10)
%
%  Output variables
%
%  VRS is the vibration response spectrum and is a function of natural
%  frequency
%
%  fn = natural frequency (Hz)
%  accel_vrs_rms = acceleration VRS (GRMS) 
%  accel_vrs_peak = acceleration VRS (G peak) 
%  
%  pv_vrs_rms = pseudo velocity VRS (in/sec) RMS 
%  pv_vrs_peak = pseudo velocity (in/sec) peak
%
%  input_time_history = synthesized acceleration time history: 
%                                                   time(sec) &  accel(G)
%
%  The input_time_history is not corrected for zero net velocity & zero net
%  displacement
%
function[fn,accel_vrs_peak,accel_vrs_accel_rms,pv_vrs_peak,pv_vrs_rms,input_time_history]=...
                                   sine_sweep_on_random_fds_function(dur,psd,sine_sweep,rate,Q,b)
%
    sine_sweep = sortrows(sine_sweep,1);
%
% find maximum & minimum excitation frequencies
%
    max_freq=max([ psd(end,1) sine_sweep(end,2)]); 
    min_freq=min([ psd(1,1) sine_sweep(1,1)]); 
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
    
%
%  Set natural frequencies at 1/24 octave steps
%
    fn(1)=min_freq;
    oct=2^(1/24);
%
    while(1)
        fn(end+1)=fn(end)*oct;   
        if(fn(end)>=max_freq)
            fn(end)=max_freq;
            break;
        end
    end

    num_fn=length(fn);

    sz=size(fn);
    if(sz(2)>sz(1))
        fn=transpose(fn);
    end
%
%  vrs calculation via srs
%
    [accel_vrs_peak,accel_vrs_accel_rms,pv_vrs_peak,pv_vrs_rms]=vrs_srs_fds(Q,fn,num_fn,total_synth,dt);

end
