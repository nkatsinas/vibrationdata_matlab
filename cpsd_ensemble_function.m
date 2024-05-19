%
%   cpsd_ensemble_function.m  ver 1.0  by Tom Irvine
%
%   This script calculates the cross spectral density between
%   two time histories
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%     mr:     mean removal - 1=yes  2=no
%     window: 1=rectangular  2=Hanning
%
%         Hanning window recommended for stationary vibration.
%         Use rectangular otherwise.
%
%     dur:  duration(sec)
%
%     A:  signal A's amplitude(units)
%     B:  signal B's amplitude(units)
%
%     df  - desired frequency step (Hz) 
%         - the script will come as close to this step as possible
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variables
%
%     CPSD:  freq(Hz) & amp(units^2/Hz) & Phase(deg)
%     COH:   freq(Hz) & coherence
%     PSD_A:  freq(Hz) & amp(units^2/Hz)
%     PSD_B:  freq(Hz) & amp(units^2/Hz)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions
%
%     CFFT_core.m
%     fix_size.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[CPSD,COH,PSD_A,PSD_B]=cpsd_ensemble_function(mr,window,dur,A,B,df)

n=length(A);

dt=dur/(n-1);


i=1;
while(1)
    
    p=2^i;
    q(i,1)=floor(n/p);
    q(i,2)=1/(p*dt);
    
    if(p>n)
        break;
    end
    i=i+1;
end

[~,ij]=min(abs( q(:,2)-df));
NW=q(ij,1);
df=q(ij,2);

mmm = 2^fix(log(n/NW)/log(2));
%
df=1/(mmm*dt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  mH=((mmm/2)-1);
%
    nov=0;
%
    CPSD=zeros(mmm,1); 
    PSD_A=zeros(mmm,1); 
    PSD_B=zeros(mmm,1); 
%
    for ijk=1:(2*NW-1)
%
        amp_seg_A=zeros(mmm,1);
        amp_seg_A(1:mmm)=A((1+ nov):(mmm+ nov));  
%
        amp_seg_B=zeros(mmm,1);
        amp_seg_B(1:mmm)=B((1+ nov):(mmm+ nov));  
%
        nov=nov+fix(mmm/2);
%
        [complex_FFT_A]=CFFT_core(amp_seg_A,mmm,mH,mr,window);
        [complex_FFT_B]=CFFT_core(amp_seg_B,mmm,mH,mr,window);        
%
        CPSD=CPSD+(conj(complex_FFT_A)).*complex_FFT_B;   % two-sided
        PSD_A=PSD_A+(conj(complex_FFT_A)).*complex_FFT_A;
        PSD_B=PSD_B+(conj(complex_FFT_B)).*complex_FFT_B;
%
    end
%
    den=df*(2*NW-1);
    
    CPSD=CPSD/den;   
    PSD_A=PSD_A/den;
    PSD_B=PSD_B/den;  
    
    CPSD(2:mH)=2*CPSD(2:mH);
    CPSD(mH+1:end)=[];   
    
    PSD_A(2:mH)=2*PSD_A(2:mH);
    PSD_A(mH+1:end)=[];
    
    PSD_B(2:mH)=2*PSD_B(2:mH);
    PSD_B(mH+1:end)=[];    

    fmax=(mH-1)*df;
    freq=linspace(0,fmax,mH);
    ff=freq;
    ff=fix_size(ff);
        
%
    CPSD_mag=abs(CPSD);
    CPSD_phase=(180/pi)*atan2(imag(CPSD),real(CPSD));
%
    COH=zeros(mH,1);
    for i=1:mH
        COH(i)=CPSD_mag(i)^2/( PSD_A(i)*PSD_B(i) );
    end
    
    CPSD=[ff CPSD_mag CPSD_phase];
    COH=[ff COH];
    PSD_A=[ff PSD_A];
    PSD_B=[ff PSD_B];