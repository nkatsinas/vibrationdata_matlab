%  
%  Butterworth_filter_highpass_function_order.m  ver 1.1  by Tom Irvine
%
%  iphase=1;  Refiltering for phase correction
%        =2;  No Refiltering

function[y]=Butterworth_filter_highpass_function_order(y,fh,dt,order,iphase)
%
n=length(y);
ns = n;
%
iband=2;
%
f=fh;
%
iflag=1;
%
%****** calculate coefficients *******
%
[a,b,iflag] = filter_coefficients_order(f,dt,iband,iflag,order);
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