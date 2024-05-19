%  
%  Butterworth_filter_highpass_function.m  ver 1.1  by Tom Irvine
%
function[y]=Butterworth_filter_highpass_function(y,fh,dt)
%
n=length(y);
ns = n;
%
iband=2;
%
f=fh;
%
iphase=1;  % Refiltering for phase correction
%
%
freq=f;
%
iflag=1;
%
%****** calculate coefficients *******
%
if(iflag ~= 999 && iband ~=3)
%
    [a,b,iflag] = filter_coefficients(f,dt,iband,iflag);
%    
end
%
if(iflag < 900 )
%
    if(iband == 1 || iband ==2)  % lowpass or highpass
%		 
         if(iphase==1)   % refiltering
			[y]=apply_filter(y,iphase,ns,a,b);
			[y]=apply_filter(y,iphase,ns,a,b); 
	      else
			[y]=apply_filter(y,iphase,ns,a,b);	
          end
%     
    end
%
    if(iband == 3)  % bandpass
 %     
		 f=fh;
		 freq=f;
%
		 disp(' Step 1');
		 iband=2;
         [a,b,iflag] = filter_coefficients(f,dt,iband,iflag);
 %		 
         if(iphase==1) % refiltering
			[y]=apply_filter(y,iphase,ns,a,b);
			[y]=apply_filter(y,iphase,ns,a,b);  
	      else
			[y]=apply_filter(y,iphase,ns,a,b);	
          end
%     
		 f=fl;
		 freq=f;
%
		 disp(' Step 2');
		 iband=1;
         [a,b,iflag] = filter_coefficients(f,dt,iband,iflag);
%		 
         if(iphase==1) % refiltering 
			[y]=apply_filter(y,iphase,ns,a,b);
			[y]=apply_filter(y,iphase,ns,a,b);  
	      else
			[y]=apply_filter(y,iphase,ns,a,b);	
          end
%          
    end
%
    mu=mean(y);
    sd=std(y);
    rms=sqrt(sd^2+mu^2);
    out1 = sprintf('\n Filtered Signal:  mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
    disp(out1);
%
%   
else
    disp(' ')
    disp('  Abnormal termination.  No output file generated. ');
end