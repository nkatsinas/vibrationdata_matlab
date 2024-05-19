%
%  sine_on_random_generate_function.m  ver 1.0  by Tom Irvine
%
%  This script synthesizes a time history for a sine-on-random specification
%
%  The assumed amplitude dimension is acceleration.  
%  But the dimension could also be in terms of force or pressure.
%
%  Input variables:
%
%  dur = duration (sec)
%  psd = psd specification array with two columns: freq(Hz) & accel(G^2/Hz)  
%  sine = sine array with two columns: freq(Hz) & accel(G)
%
%  Output variables
% 
%  input_time_history = synthesized acceleration time history: 
%                                                   time(sec) &  accel(G)
%
%  The input_time_history is not corrected for zero net velocity & zero net
%  displacement
%
function[input_time_history]=sine_on_random_generate_function(dur,psd,sine)
%
    sine = sortrows(sine,1);
%
% find maximum & minimum excitation frequencies
%
    max_freq=max([ psd(end,1) sine(end,1)]);  
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
    [psd_synth]=synthesize_psd(psd,num,dt);
%
    total_synth=sine_synth+psd_synth(1:num);
%
    input_time_history=[t total_synth];
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   interpolate_PSD_arbitrary_frequency_f.m  ver 1.0   by Tom Irvine
%
function[fi,ai] = interpolate_PSD_arbitrary_frequency_f(f,a,new_freq)
%
    if(f(1) < .0001)
        f(1)=[];
        a(1)=[];
    end
%
    m=length(f);
%
%   calculate slopes
%
    s=zeros(m-1,1);

    for i=1:m-1
        s(i)=log(  a(i+1) / a(i)  )/log( f(i+1) / f(i) );
    end    
%
    np = length(new_freq);
%
    ai=zeros(np,1);
%
	fi=new_freq; 
    
    for  i=1:np 
%       
        for j=1:(m-1)
%
            if(fi(i)==f(j))
                ai(i)=a(j);
                break;
            end
            if(fi(i)==f(end))
                ai(i)=a(end);
                break;
            end            
%
            if( ( fi(i) >= f(j) ) && ( fi(i) <= f(j+1) )  )
				ai(i)=a(j)*( ( fi(i) / f(j) )^ s(j) );
				break;
            end
        end
%               
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Synthesize psd time history
%
function[synth]=synthesize_psd(psd,num,dt)

%  np = initial number of time history points for psd synthesis
%
    np=2^(floor(log2(2*num)));
%
%  generate initial white noise and perform conditioning
%
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