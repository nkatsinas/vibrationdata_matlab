%
%  full_FFT_core_c.m  ver 1.0   by Tom Irvine
%
function[freq,full,phase,complex_FFT]=...
                                  full_FFT_core_c(m_choice,h_choice,amp,N,dt)
%
    if(h_choice==2)
        m_choice=1;
    end
%
    if(m_choice==1)
        mu=mean(amp);
        amp=amp-mu;
    end
%
    if(h_choice==2)
%
        ae=sqrt(8/3);
%%        disp(' Hanning window ');
        for i=1:N
            amp(i)=amp(i)*( ae*(sin( (i*pi/N) )^2) );       
        end
    end
%
%%    disp(' ')
%%    disp(' begin FFT ')
%%    disp(' ')
    Y = fft(amp,N);
%
    clear complex_FFT;
    complex_FFT=zeros(N,2);
    clear FF;
%
    df=1/(N*dt);
%%    out4 = sprintf(' df  = %8.4g Hz  ',df);
%%    disp(out4)
%
    FF=linspace(0,df*(N-1),N);
%
    complex_FFT(:,1)=FF';
    complex_FFT(:,2)=Y/N;
%
%%    disp(' scale for full FFT ')
%
    Nd2=N/2;
%
    Mag=abs(Y(1:Nd2));
    phase=zeros(Nd2,1);
    freq=zeros(Nd2,1);
%
    freq(1)=0;
    for i=2:Nd2
        aa=real(Y(i));
        bb=imag(Y(i));
%
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