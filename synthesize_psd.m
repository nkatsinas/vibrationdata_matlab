%
%  synthesize_psd.m  ver 1.0  by Tom Irvine 
%
function[synth]=synthesize_psd(psd,num,dt)

%  np = initial number of time history points for psd synthesis
%
    np=2^(floor(log2(2*num)));
%
%  generate initial white noise and perform conditioning
%
    rng(1);
    white_noise=randn(np,1);
%
    white_noise=white_noise-mean(white_noise);
%
    wnfft = fft(white_noise,np);
%
    df=1/(np*dt);
%
    FF=linspace(0,df*(np-1),np);
%
    complex_FFT(:,1)=FF';
    complex_FFT(:,2)=real(wnfft)/np;
    complex_FFT(:,3)=imag(wnfft)/np;
%
    XX=zeros(np,1);
%
    for i=1:np    
        aa1=complex_FFT(i,2);
        bb1=complex_FFT(i,3);
        alpha1=atan2(bb1,aa1);
        XX(i)=( cos(alpha1) + (1i)*sin(alpha1)); 
    end
%   
    white_noise=ifft(XX); 
%
%  Interpolate PSD spec
%
    [~,spec] = interpolate_PSD_arbitrary_frequency_f(psd(:,1),psd(:,2),FF);
    rms=sqrt(sum(spec*df));
%
    sq_spec=sqrt(spec);
%
%   Take FFT of white noise prior and scale amplitude
%
    YF = fft(white_noise,np);
    Y=sq_spec.*YF;
%
    Y_real = real(ifft(Y,'symmetric'));
%       
    Y_real=Y_real-mean(Y_real);
    synth=rms*Y_real/std(Y_real);
%
end