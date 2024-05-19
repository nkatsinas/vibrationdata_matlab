%
%  two_generic_psd_syn_function.m  ver 1.2  by Tom Irvine
%
%  This script synthesizes time histories to satisfy two generic psds
%  with specified phase angle
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input variables:
%
%   duration = sec
%        psd = four column array:

%
%         sr = sample rate, should be >= 10x highest frequency
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output array:
%
%     psd_synthesis = three column array:  
%                        Time(sec) & amplitude1(unit) & amplitude2(unit)
%
%     psd_synthesis1 = two column array:
%                        Time(sec) & amplitude1(unit)
% 
%     psd_synthesis2 = two column array:
%                        Time(sec) & amplitude2(unit)
%'
%     pszcr1 = positive slope zero crossing rate for psd_synthesis1
%     pszcr2 = positive slope zero crossing rate for psd_synthesis2
%     
%     rho = Pearson correlation coefficient
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  External arrays:
%
%    PSD_syn_white_noise
%    interpolate_PSD_spec
%    PSD_syn_FFT_core
%    PSD_syn_scale_time_history
%    linear_interpolation_function
%
%    fix_size - changes input array to column format if needed
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[psd_synthesis,psd_synthesis1,psd_synthesis2,pszcr1,pszcr2,rho]=...
                              two_generic_psd_syn_function(duration,psd,sr)

tic

dur=duration;
hours=duration/3600;
 
% Time step dt is inverse of sample rate
dt=1/sr;    

% Number of points to generate npd
npd=ceil(dur/dt);   

% Number of points is raised to 2^n where n is an integer for FFT
% computation

np=2^(ceil(log2(dur/dt)));   
 
fprintf('\n dt=%8.4g   n=%8.4g   \n\n',dt,np);


% df is the FFT frequency step
df=1/(np*dt);

% An extra psd point is added at 1/12 octave below first frequency
fa=psd(1,1)/2^(1/12);

if(fa>0.01)
    psd=[fa psd(1,2) psd(1,3) psd(1,4); psd];
end


THM1=[psd(:,1) psd(:,2)];  % first  psd specification
THM2=[psd(:,1) psd(:,3)];  % second psd specification

% Change phase angle from degrees to radians
phase=psd(:,4)*pi/180;  

% Frequency array fp
fp=THM1(:,1);
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Check for zero frequencies and zero amplitudes
[~,~,freq1,amp1,slope1,rms1]=THM_check(THM1);
[~,~,freq2,amp2,slope2,rms2]=THM_check(THM2);

%
%  Interpolate each psd specification according the FFT frequency step df
%
[fx1,spec1]=interpolate_PSD_spec(np,freq1,amp1,slope1,df);
[~,spec2]=interpolate_PSD_spec(np,freq2,amp2,slope2,df);

% fmax is the maximum specification frequency
fmax=max(freq1);

f1=freq1;

nsegments = 1;

% calculate the Fourier magnitude for each psd point
% Ignore the "per Hz" denominator
%
sq_spec1=sqrt(spec1);
sq_spec2=sqrt(spec2);

% Number of hours raised to next highest integer
% Typically rhd=1
%
% This script was adapted from a script that synthesizes wind time
% histories for several hours
%
rhd=ceil(hours); 

for ijk=1:rhd
    
    fprintf('\n ** %d of %d **  \n',ijk,rhd);
    
%   
%  Generate white noise for as basis each time history 
%  Best to start in the time domain from past experience
%
    [np,white_noise1,~]=PSD_syn_white_noise(dur,dt,np);
    [np,white_noise2,~]=PSD_syn_white_noise(dur,dt,np);
    
    mmm=round(np/2); % obsolete  

% Caculate the FFT of each white noise time history
%
%    Y1,Y2 are the complex FFTs of white noise signals 1 & 2
%    psd_th1 is the time history for the first psd specification
%    psd_th2 is the time history for the second psd specification
%    but will be calculated later
%
    [Y1,psd_th1,~]=PSD_syn_FFT_core(nsegments,mmm,np,fmax,df,sq_spec1,white_noise1);
    [Y2,      ~,~]=PSD_syn_FFT_core(nsegments,mmm,np,fmax,df,sq_spec2,white_noise2);    
    
%
%  The following loop covers each element of the Y1 FFT
%
    for i=1:length(Y1)
        theta=0;
        f=fx1(i);
        
%  Interpolate the phase angle        
        for j=1:length(fp)-1
            if(f==f1(j))
                theta=phase(j);
                break;
            end
            if(f==f1(j+1))
                theta=phase(j+1);
                break;
            end            
            if(f>f1(j) && f<f1(j+1))
                [theta]=linear_interpolation_function(fp(j),phase(j),fp(j+1),phase(j+1),f);              
                break;
            end       
        end
        
% Adjust the phase angle of the second FFT to the correct value relative to the first FFT        
        phi = angle(Y1(i));
        omega=phi-theta;
        Y2(i)=abs(Y2(i))*exp(1i*omega);  
      
    end
    
% The second time history is calculated via the inverse FFT    
    psd_th2 = real(ifft(Y2,'symmetric'));    
    
% Scale each time history for the correct rms value
    [~,psd_th1,~]=PSD_syn_scale_time_history(psd_th1,rms1,np,dur);
    [~,psd_th2,~]=PSD_syn_scale_time_history(psd_th2,rms2,np,dur);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    TT=(0:npd-1)*dt;
%
    TT=fix_size(TT);
%
    psd_th1=fix_size(psd_th1);
    psd_th2=fix_size(psd_th2);    

    TTL=length(TT);
    
    if(ijk==1)
        psd_synthesis=zeros(TTL,3);
    end
    
    ia=TTL*(ijk-1)+1;
    ib=ia+TTL-1;
    
    psd_synthesis(ia:ib,:)=[TT psd_th1(1:TTL) psd_th2(1:TTL)];

end

% Set time column
TZ=length(psd_synthesis(:,1));
psd_synthesis(:,1)=(0:TZ-1)*dt;

psd_synthesis1=[psd_synthesis(:,1) psd_synthesis(:,2)];
psd_synthesis2=[psd_synthesis(:,1) psd_synthesis(:,3)];

%  Find positive slope zero crossing rates
t=psd_synthesis(:,1);
[pszcr1,~,~,~]=zero_crossing_function_alt(t,psd_synthesis(:,2),dur);
[pszcr2,~,~,~]=zero_crossing_function_alt(t,psd_synthesis(:,3),dur);

%  Pearson correlation coefficient
R = corrcoef(psd_synthesis(:,2),psd_synthesis(:,3));
rho=R(1,2);

disp(' Positive Slope Zero Crossing Rate ');

fprintf('\n Time History 1:  %8.4g Hz',pszcr1);
fprintf('\n Time History 2:  %8.4g Hz\n',pszcr2);

fprintf('\n Pearson correlation coefficent = %8.4g \n\n',rho);

toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[THM,nsz,freq,amp,slope,rms]=THM_check(THM)

if(THM(1,1)<1.0e-09)  % check for zero frequency
    THM(1,1)=10^(floor(-0.1+log10(THM(2,1))));
end
%
if(THM(1,2)<1.0e-30)  % check for zero amplitude
    noct=log(THM(2,1)/THM(1,1))/log(2);
    THM(1,2)=(noct/4)*THM(2,2);         % 6 db/octave 
end

nsz=max(size(THM));
freq=zeros(nsz+1,1);
amp=zeros(nsz+1,1);

k=1;
for i=1:nsz
    if(THM(i,1)>0)
        amp(k)=THM(i,2);
        freq(k)=THM(i,1);
        k=k+1;
    end
end  
%
freq(nsz+1)=freq(nsz)*2^(1/48);
amp(nsz+1)=amp(nsz);

[~,slope,rms] = psd_syn_data_entry(freq,amp,nsz,nsz);

freq=fix_size(freq);
 amp=fix_size(amp);
 
%
%   zero_crossing_function_alt.m  ver 1.1 by Tom Irvine
%
function[pszcr,peak_rate,tpa,pa]=zero_crossing_function_alt(t,amp,T)

    np=0;
    pp=0;
    pszcr=0;
    j=1;
    n=length(amp);
%
%  Do not initialize pa with zeros because do not know final size
%
    for i=2:(n-1)
        if( amp(i)>=amp(i-1) && amp(i)>=amp(i+1) )
            pa(j)=abs(amp(i));
            tpa(j)=t(i);
            j=j+1;
            pp=pp+1;
        end
        if( amp(i)<=amp(i-1) && amp(i)<=amp(i+1) )
            pa(j)=abs(amp(i));
            tpa(j)=t(i);            
            j=j+1;
            np=np+1;
        end
        
        if(amp(i-1)<0 && amp(i)>0)
            pszcr=pszcr+1;
        end    
        
    end
%

pszcr=pszcr/T;
peak_rate=((pp+np)/2)/T;

tpa=fix_size(tpa);
pa=fix_size(pa);
 
