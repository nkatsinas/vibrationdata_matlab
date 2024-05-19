%
%   fft_function.m  ver 1.1  by Tom Irvine 
%
%   One-sided, Full-amplitude Discrete Fast Fourier Transform 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Input variable
%
%     mr - mean removal - 1=yes  2=no
%     window - 1=rectangular  2=Hanning
%
%     amp = amplitude
%      dt = time step (sec) should be constant
%
%    yname = Y-axis label such as 'Accel (G)'
%
%    fmax = maximum plot frequency (Hz) should be <= Nyquist frequency
%                   where Nyquist is one-half the sample rate    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variables
%
%      magnitude_fft = frequency(Hz) & magnitude(unit)
%      magnitude_phase_fft = frequency(Hz) & magnitude(unit) & phase(deg)
%      complex_fft = frequency(Hz) & complex(unit)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External function
%
%      full_FFT_core.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[magnitude_fft,magnitude_phase_fft,complex_fft]=...
                                  fft_function(mr,window,amp,dt,yname,fmax)

N=length(amp);

[freq,full,phase,complex_fft]=full_FFT_core(mr,window,amp,N,dt);    
%    
magnitude_fft=[freq full];
%
magnitude_phase_fft=[freq full phase];

[~,I]=max(magnitude_fft(:,2));
fmaxp=magnitude_fft(I,1);

figure(1);
plot(magnitude_fft(:,1),magnitude_fft(:,2));
out1=sprintf('Fourier Transform Magnitude  Max Peak at %8.4g Hz',fmaxp);
title(out1);
ylabel(yname);
xlabel('Frequency (Hz)');
xlim([0 fmax]);
grid on;     
            
md=4;
ylab=yname;
fmin=0;
            

t_string=sprintf('Fourier Transform Magnitude & Phase  Max Peak at %8.4g Hz',fmaxp);

fig_num=2;
[fig_num]=...
   plot_magnitude_phase_function_linear(fig_num,t_string,fmin,fmax,freq,phase,full,ylab,md);            
            
