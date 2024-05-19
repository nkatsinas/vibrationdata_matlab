% 
%    Butterworth_LPF.m 
%    ver 2.3   November 13, 2012 
%    by Tom Irvine  Email: tomirvine@aol.com 
% 
%    Butterworth filter, sixth-order, infinite impulse response,
%    cascade with refiltering option for phase correction               
%
%
%
%  iphase=1 refiltering for phase correction
%        =2 no refiltering 
%
%      f = lowpass freq (Hz)
%
function[y]=Butterworth_LPF(y,dt,f,iphase)
%
n=length(y);
ns = n; 
%
%
iband=1;
%
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
%
		 disp(' Step 2');
		 iband=1;
         [a,b,~] = filter_coefficients(f,dt,iband,iflag);
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
else
    disp(' ')
    disp('  Abnormal termination.  No output file generated. ');
end
