
%   VDG_Butterworth_filter_function_order.m  ver 1.1  by Tom Irvine

function[y]=VDG_Butterworth_filter_function_order(y,iband,iphase,dt,filter_freq,L_order)
%
n=length(y);
ns = n;
%
%
iflag=1;
%
%****** calculate coefficients *******
%
if(iflag ~= 999 && iband ~=3)
%
    f=filter_freq(1);
    [a,b,iflag] = filter_coefficients_order(f,dt,iband,iflag,L_order);
%    
end
%
if(iflag < 900 )
%
    if(iband == 1 || iband ==2)  % lowpass or highpass
%		 
         if(iphase==1)   % refiltering
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order); 
	      else
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);	
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
         [a,b,iflag] = filter_coefficients_order(f,dt,iband,iflag,L_order);
 %		 
         if(iphase==1) % refiltering
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);  
	      else
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);	
          end
%     
		 f=filter_freq(2);
%
		 disp(' Step 2');
		 iband=1;
         [a,b,iflag] = filter_coefficients_order(f,dt,iband,iflag,L_order);
%		 
         if(iphase==1) % refiltering 
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);  
	      else
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);	
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
         [a,b,iflag] = filter_coefficients_order(f,dt,iband,iflag,L_order);
 %		 
         if(iphase==1) % refiltering
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);  
	     else
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);	
         end
         ylow=y;
%     
		 f=filter_freq(2);
%
		 disp(' Step 2');  % highpass
		 iband=2;
         [a,b,iflag] = filter_coefficients_order(f,dt,iband,iflag,L_order);
%		 
         y=yorig; 

         if(iphase==1) % refiltering 
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);  
	     else
			[y]=apply_filter_order(y,iphase,ns,a,b,L_order);	
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