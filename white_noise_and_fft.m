
%  white_noise_and_fft.m  ver 1.1  by Tom Irvine

function[white_noise,complex_FFT]=white_noise_and_fft(tmax,m_choice,h_choice,np,dt)

[np,white_noise,~]=PSD_syn_white_noise(tmax,dt,np);
[~,~,~,complex_FFT]=full_FFT_core_notext(m_choice,h_choice,white_noise,np,dt);

XX=zeros(np,1);

for i=1:np    
    aa1=complex_FFT(i,2);
    bb1=complex_FFT(i,3);
    alpha1=atan2(bb1,aa1);
    XX(i)=( cos(alpha1) + (1i)*sin(alpha1)); 
end
   
white_noise=ifft(XX); 
