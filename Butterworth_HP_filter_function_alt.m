% 
%    Butterworth_HP_filter_function_alt.m  ver 1.0
%    
%    Butterworth filter, sixth-order, infinite impulse response,
%    cascade with refiltering option for phase correction               
%
%    f = lowpass filter
%
function[y]=Butterworth_HP_filter_function_alt(y,dt,f)
%
n=length(y);
ns = n; 
%
%
iband=2;
%
%   
%
iphase=2;  % No refiltering for phase correction
%
iflag=1;
%
%****** calculate coefficients *******
%
if(iflag ~= 999 && iband ~=3)
%
    [a,b,iflag] = filter_coefficients_alt(f,dt,iband,iflag);
%    
end
%
if(iflag < 900 )
%
    if(iband == 1 || iband ==2)  % lowpass or highpass
%		 
         if(iphase==1)   % refiltering
			[y]=apply_filter_alt(y,iphase,ns,a,b);
			[y]=apply_filter_alt(y,iphase,ns,a,b); 
	      else
			[y]=apply_filter_alt(y,iphase,ns,a,b);	
          end
%     
    end
%
%
else
    disp(' ')
    disp('  Abnormal termination.  No output file generated. ');
end