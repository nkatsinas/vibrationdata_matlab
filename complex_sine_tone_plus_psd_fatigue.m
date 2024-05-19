%
%   complex_sine_tone_plus_psd_fatigue.m  ver 1.0  by Tom Irvine
%
%            f = frequency (Hz)
%
%   sine_force = complex force response array, with one row per sine tone 
%                & two columns
%                First column is real force  
%                Second column is imaginary force 
%
%    psd_force = force response psd: frequency (Hz) & (force unit^2/Hz)
%
%            b = fatigue exponent (typically: 4 <= b <= 8 )
%            T = duration (sec)
%
%       damage = relative damage, dimension: (response amplitude unit)^b
%        ycomp = worst case composite sine time history with two columns:
%                time(sec) & force
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Task instruction:
%
%   There will be between 1 to 3 inputs of the form shown above.  
%   If there are 2 or more inputs, it is requested to clock these inputs 
%   every 45 degrees (0,45,90,135,180,225,270,315 degrees).  
%   Then provide the results from the worst clocking combination.
%
function[ycomp,damage]=complex_sine_tone_plus_psd_fatigue(f,sine_force,psd_force,T,b)
%
    omega=2*pi*f;
    sr=max([20*f 12*psd_force(end,1)]);
    dt=1/sr;
%
%  The duration is normalized to 60 seconds for computational speed if it
%  is > 60 sec
%  The damage is multiplied by a scale factor to calculate the damage for the
%  original duration.
%
    if(T>60)
        tscale=T/60;
        T=60;
    else
        tscale=1;
    end
%    
    num_times=floor(T/dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    if(psd_force(1,1) < .0001)
        psd_force(1,:)=[];
    end   
%
    m=length(psd_force(:,1));

    amin=1.0e-50;
    
    for i=1:m
        if(psd_force(i,2)<amin)
            psd_force(i,2)=amin;
        end
    end

    [yrand]=synthesize_psd(psd_force,num_times,dt);
    t=yrand(:,1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    sz=size(sine_force);
%
    num_rows=sz(1);
%
    A=zeros(num_rows,1);
    phase=zeros(num_rows,1);

    for i=1:num_rows
        complex_force=complex(sine_force(i,1),sine_force(i,2));
        A(i)=abs(complex_force);
        phase(i)=angle(complex_force);
    end
%

    dmax=0;

%%%

    if(num_rows==1)
        for i=1:8
            alpha=phase(1)+(i-1)*pi/4;
            yt1=A(1)*sin(omega*t+alpha);
        
            x=yrand+yt1;
            c=rainflow(x);
            cycles=c(:,1);
            amp=c(:,2)/2;
            d=sum( cycles.*amp.^b );
            
            if(d>dmax)
                ycomp=x;
                dmax=d;
            end        
        
        end
    end

%%%

    if(num_rows==2)
        for i=1:8
            alpha=phase(1)+(i-1)*pi/4;
            yt1=A(1)*sin(omega*t+alpha);
        
            for j=1:8
                beta=phase(2)+(j-1)*pi/4;
                yt2=A(2)*sin(omega*t+beta);
        
                x=yrand+yt1+yt2;
            
                c=rainflow(x);
                cycles=c(:,1);
                amp=c(:,2)/2;
                d=sum( cycles.*amp.^b );
                        
                if(d>dmax)
                    ycomp=x;
                    dmax=d;
                end        
            end
        end
    end

%%%

    if(num_rows==3)
        for i=1:8
            alpha=phase(1)+(i-1)*pi/4;
            yt1=A(1)*sin(omega*t+alpha);
        
            for j=1:8
                beta=phase(2)+(j-1)*pi/4;
                yt2=A(2)*sin(omega*t+beta);
                
                for k=1:8
                    theta=phase(3)+(k-1)*pi/4;
                    yt3=A(3)*sin(omega*t+theta);
  
                    x=yrand+yt1+yt2+yt3;
            
                    c=rainflow(x);
                    cycles=c(:,1);
                    amp=c(:,2)/2;
                    d=sum( cycles.*amp.^b );
        
                    if(d>dmax)
                        ycomp=x;
                        dmax=d;
                    end                         
                    
                    
                end
                
            end
            
        end
    end

%%%
    damage=dmax*tscale;

    fprintf('\n Calculation complete.  Damage = %8.4g \n',damage);
    
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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