%
%    sf_engine3_ndel_alt_delay.m  ver 2.3  by Tom Irvine
%
function[av,Ar,Br,omeganr,dampr,delayr]=sf_engine3_ndel_alt_delay(dur,av,t,dt,md1,md2,fmax)

Ar=0;
Br=0;
omeganr=0;
dampr=0;
delayr=0;

error_rth=av;

t=t-t(1);

%
tp=2*pi;
%

fft_freq=0;

%
    amp=av-mean(av);

    [zcf,~,~]=zero_crossing_function(amp,dur);
    
%
    m_choice=1;  % mean removal
    h_choice=1;  % rectangual window
%    
    n=length(amp); 
    N=2^floor(log(n)/log(2));
    [freq,full,~,~]=full_FFT_core(m_choice,h_choice,amp,N,dt);    
%
    magnitude_FFT=[freq full];
%    
    try
        [~,fft_freq]=find_max(magnitude_FFT);
%
        fprintf(' zero crossing frequency = %8.4g Hz \n',zcf); 
        fprintf(' FFT frequency = %8.4g Hz \n',fft_freq);
    
    catch
        warndlg('FFT Error');
    end
%


%
errormax=std(amp);
%
disp(' ');
disp('  Trial     Error      Amplitude   Freq(Hz)   Phase(rad)   damp   delay(sec)');
%
%
Y=amp;
Y=fix_size(Y);
%

%
%  f(t)=A*cos(omegan*t) + B*sin(omegan*t) + C;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tpi=2*pi;

dmin=min([md1 md2]);
dmax=max([md1 md2]);

nt=1500;

nh=round(nt/4);

progressbar;

for ijk=1:nt

    progressbar(ijk/nt);

    damp=(dmax-dmin)*rand()+dmin;
    delay=dur*(rand())^2;
    
    if(ijk>nh && rand()>0.5)
        damp=dampr*(0.95+0.1*rand());
    end
    if(ijk>nh && rand()>0.5)
        delay=delayr*(0.95+0.1*rand());
    end

    
      
    if(delay>dur)
        delay=dur*0.5*rand();
    end

    if(damp<dmin)
        damp=dmin;
    end
    if(damp>dmax)
        damp=dmax;
    end
    
    for j=1:2
    
        if(j==1)
            freq_est=zcf;
        else
            freq_est=fft_freq;
        end
        
        if(freq_est>fmax || freq_est<0.01)
            freq_est=(0.1+0.9*rand())*fmax;
        end
    
        omegan=tp*freq_est;
          
        if(ijk>nh && rand()>0.5)     
            omegan=omeganr*(0.98+0.04*rand());
        end
        
        if(omegan>tpi*fmax)
            omegan=(0.1+0.9*rand())*omeganr;
        end
        
        
        [A,B]=damped_sine_lsf_function_alt_3_delay(Y,t,omegan,damp,delay);
        
        [errormax,error_rth,Ar,Br,omeganr,delayr,dampr]=...
              sfxxd_error_core(n,t,omegan,delay,damp,errormax,error_rth,amp,A,B,j,Ar,Br,omeganr,delayr,dampr);

    end
   
end

pause(0.2);
progressbar(1);

%   
av=error_rth;
%
ave=mean(av);  
sd=std(av);
%	
fprintf('\n  ave=%12.4g  sd=%12.4g \n\n',ave,sd);
%



function[errormax,error_rth,Ar,Br,omeganr,delayr,dampr]=...
          sfxxd_error_core(n,t,omegan,delay,damp,errormax,error_rth,amp,A,B,j,Ar,Br,omeganr,delayr,dampr)

    tp=2*pi;
    
    
    
    
        y=zeros(n,1);
        error=zeros(n,1);
        
        tt=t-t(1);
    
        for i=1:n
        
            if(tt(i)>=delay)
            
                tq=tt(i)-delay;
    
                y(i)=exp(-damp*omegan*tq)*(A*cos(omegan*tq) + B*sin(omegan*tq)); 
                
            end
            
            error(i)=amp(i)-y(i);
    
        end
        
        sd_error=std(error);
    
    
        
%
        if(sd_error<errormax)
%
            error_rth=error;
            errormax=sd_error;

            Ar=A;
            Br=B;
            omeganr=omegan;
            dampr=damp;
            delayr=delay;
%

            x1=sqrt(A^2+B^2);
            x2=omegan;
            x3=atan2(A,B);
            x4=damp;
            x5=delay;
  
            out4 = sprintf(' %6ld  %13.5e  %10.4g %9.4f %9.4f %9.4f %9.4f',j,errormax,x1,x2/tp,x3,x4,x5);
            disp(out4);
          
        end