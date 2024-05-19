
%   VDG_Butterworth_filter_function.m  ver 1.1  by Tom Irvine

function[y]=VDG_Butterworth_filter_function(y,iband,iphase,dt,filter_freq)
%
n=length(y);
ns = n;
%
f=0.;
fl=0.;
fh=0.;
%
iflag=1;
%
%****** calculate coefficients *******
%
if(iflag ~= 999 && iband ~=3)
%
    f=filter_freq(1);
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
		 f=filter_freq(1);
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
		 f=filter_freq(2);
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
    if(iband == 4)  % stop
 %
         yorig=y;
 
		 f=filter_freq(1);  % lowpass
%
		 disp(' Step 1');
		 iband=1;
         [a,b,iflag] = filter_coefficients(f,dt,iband,iflag);
 %		 
         if(iphase==1) % refiltering
			[y]=apply_filter(y,iphase,ns,a,b);
			[y]=apply_filter(y,iphase,ns,a,b);  
	     else
			[y]=apply_filter(y,iphase,ns,a,b);	
         end
         ylow=y;
%     
		 f=filter_freq(2);
%
		 disp(' Step 2');  % highpass
		 iband=2;
         [a,b,iflag] = filter_coefficients(f,dt,iband,iflag);
%		 
         y=yorig; 

         if(iphase==1) % refiltering 
			[y]=apply_filter(y,iphase,ns,a,b);
			[y]=apply_filter(y,iphase,ns,a,b);  
	     else
			[y]=apply_filter(y,iphase,ns,a,b);	
         end
         yhigh=y;
%
%    Add filtered signals
%
         y=ylow+yhigh;
%          
    end
    
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