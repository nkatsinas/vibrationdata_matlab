%
%  full_FFT_core._alt.m  ver 1.1   by Tom Irvine
%
function[freq,full,phase,complex_FFT]=full_FFT_core_alt(amp,N,df)
%
    Y = fft(amp,N);
%
    clear complex_FFT;
    complex_FFT=zeros(N,3);
    clear FF;
%
    FF=linspace(0,df*(N-1),N);
%
    complex_FFT(:,1)=FF';
    complex_FFT(:,2)=real(Y)/N;
    complex_FFT(:,3)=imag(Y)/N;
%
    try
        Nd2=floor(N/2);
    catch
        fprintf('\n Error:  N=%g  \n',N);
    end    
%
    Mag=abs(Y(1:Nd2));
    phase=zeros(Nd2,1);
    freq=zeros(Nd2,1);
%
    freq(1)=0;
    for i=2:Nd2
        aa=real(Y(i));
        bb=imag(Y(i));
        phase(i) =atan2(bb,aa);
        freq(i)=(i-1)*df;
    end
%
    full=2.*Mag/N;
    full(1)=0.;
    phase = phase*180/pi; 
%
    freq=fix_size(freq);
    full=fix_size(full);
    phase=fix_size(phase);