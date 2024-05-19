% 
%    Butterworth_filter_function.m   ver 2.4
%    by Tom Irvine 
% 
%    Butterworth filter, sixth-order, infinite impulse response,
%    cascade with refiltering option for phase correction               
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%     y = amplitude
%    dt = time step (sec)
%
%    freq = filter frequency for low or high-pass
%         = array with two frequencies for band-pass with lower & upper
%           frequencies in any order
%
%    iband:   1=low-pass  2=high-pass  3=band-pass 
%
%    iphase=1  for refiltering for phase correction
%          =2  for no refiltering
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variables
%
%    yf = filtered data
%    mu = mean of filtered data
%    sd = standard deviation of filtered data
%   rms = rms of filtered data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions
%
%      th_weighted_filter_coefficients.m
%      th_weighted_apply_filter.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[yf,mu,sd,rms]=Butterworth_filter_function(y,dt,iband,freq,iphase)
%
sr=1/dt;
n=length(y);
ns = n;
%
if(iband == 1)  % lowpass
          f=freq;
end
if(iband == 2)  % highpass
          f=freq;
end
if(iband==1 || iband==2)
    if( f > 0.5*sr) 
	    disp('  error: cutoff frequency must be < Nyquist frequency ');    
	    return;
    end
end
if(iband == 3)  % bandpass
          fl=min(freq);
          fh=max(freq);
%
    if( fl > 0.5*sr || fh > 0.5*sr) 
	    disp('  error: cutoff frequency must be < Nyquist frequency ');    
	    return;
    end
%
end 
%
iflag=1;
%
%****** calculate coefficients *******
%
if(iflag ~= 999 && iband ~=3)
%
    [a,b,iflag] = th_weighted_filter_coefficients(f,dt,iband,iflag);
%    
end
%
if(iflag < 900 )
%
    if(iband == 1 || iband ==2)  % lowpass or highpass
%		 
         if(iphase==1)   % refiltering
			[yf]=th_weighted_apply_filter(y,iphase,ns,a,b);
			[yf]=th_weighted_apply_filter(yf,iphase,ns,a,b); 
	      else
			[yf]=th_weighted_apply_filter(y,iphase,ns,a,b);	
          end
%     
    end
%
    if(iband == 3)  % bandpass
 %     
		 iband=2;
 		 f=fl;        
         [a,b,iflag] =th_weighted_filter_coefficients(f,dt,iband,iflag);
 %		 
         if(iphase==1) % refiltering
			[yf]=th_weighted_apply_filter(y,iphase,ns,a,b);
			[yf]=th_weighted_apply_filter(yf,iphase,ns,a,b);  
	      else
			[yf]=th_weighted_apply_filter(y,iphase,ns,a,b);	
          end
%     
		 iband=1;
		 f=fh;         
         [a,b,~] = th_weighted_filter_coefficients(f,dt,iband,iflag);
%		 
         if(iphase==1) % refiltering 
			[yf]=th_weighted_apply_filter(yf,iphase,ns,a,b);
			[yf]=th_weighted_apply_filter(yf,iphase,ns,a,b);  
	      else
			[yf]=th_weighted_apply_filter(yf,iphase,ns,a,b);	
          end
%          
    end
%
    mu=mean(yf);
    sd=std(yf);
    rms=sqrt(sd^2+mu^2);
%  
else
    disp(' ')
    disp('  Abnormal termination.  No output file generated. ');
end