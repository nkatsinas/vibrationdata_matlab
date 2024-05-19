% 
%    Butterworth_filter_function_order.m   ver 2.4
%    by Tom Irvine 
% 
%    Butterworth filte infinite impulse response,
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
%    order = order
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
%      th_weighted_filter_coefficients_order.m
%      apply_filter_order.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[yf,mu,sd,rms]=Butterworth_filter_function_order(y,dt,iband,freq,iphase,order)
%
sr=1/dt;
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
if(iband == 4)  % bandstop
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
%
%  Patchwork method needed for stability!
%

if(order<8)

    %****** calculate coefficients *******
    %
    if(iflag ~= 999 && iband <=2)
    %
        [a,b,iflag]=th_weighted_filter_coefficients_order(f,dt,iband,iflag,order);
    %    
    end
    %
    if(iflag < 900 )
    %
        if(iband == 1 || iband ==2)  % lowpass or highpass
    %		 
             if(iphase==1)   % refiltering
                [yf]=apply_filter_order(y,iphase,[],a,b,order);
                [yf]=apply_filter_order(yf,iphase,[],a,b,order); 
             else
                [yf]=apply_filter_order(y,iphase,[],a,b,order);
              end
    %     
        end
    %
        if(iband == 3)  % bandpass
     %     
             iband=2;
             f=fl;        
             [a,b,iflag] =th_weighted_filter_coefficients_order(f,dt,iband,iflag,order);
     %		 
             if(iphase==1) % refiltering
                [yf]=apply_filter_order(y,iphase,[],a,b,order);
                [yf]=apply_filter_order(yf,iphase,[],a,b,order);   
             else
                [yf]=apply_filter_order(y,iphase,[],a,b,order);
             end
             
    %     
             iband=1;
             f=fh;         
             [a,b,~] = th_weighted_filter_coefficients_order(f,dt,iband,iflag,order);
    %		 
             y=yf;
             if(iphase==1) % refiltering 
                [yf]=apply_filter_order(y,iphase,[],a,b,order);
                [yf]=apply_filter_order(yf,iphase,[],a,b,order);  
             else
                [yf]=apply_filter_order(y,iphase,[],a,b,order);	
             end
    %          
        end
    %
        if(iband == 4)  % stop
     %
             yorig=y;

             f=fl;  % lowpass
    %
             disp(' Step 1');
             iband=1;
             [a,b,iflag] = filter_coefficients_order(f,dt,iband,iflag,order);
     %		 
             if(iphase==1) % refiltering 
                [y]=apply_filter_order(y,iphase,[],a,b,order);
                [y]=apply_filter_order(y,iphase,[],a,b,order);  
             else
                [y]=apply_filter_order(y,iphase,[],a,b,order);	
             end
             ylow=y;
    %     
             f=fh;
    %
             disp(' Step 2');  % highpass
             iband=2;
             [a,b,iflag] = filter_coefficients_order(f,dt,iband,iflag,order);
    %		 
             y=yorig; 

             if(iphase==1) % refiltering 
                [y]=apply_filter_order(y,iphase,[],a,b,order);
                [y]=apply_filter_order(y,iphase,[],a,b,order);  
             else
                [y]=apply_filter_order(y,iphase,[],a,b,order);	
             end
             yhigh=y;
    %
    %    Add filtered signals
    %
             yf=ylow+yhigh;
    %          
        end   
    %  
    else
        disp(' ')
        disp('  Abnormal termination.  No output file generated. ');
    end

else  % order=8
    
    if(iband==1)  % lowpass
       if(iphase==1)
           [yf]=Butterworth_lowpass_refilter_new(y,sr,f,order);
       else
           [yf]=Butterworth_lowpass_refilter_new(y,sr,f,order);         
       end
    end
    if(iband==2)  % highpass
       if(iphase==1)
           [yf]=Butterworth_highpass_refilter_new(y,sr,f,order);
       else
           [yf]=Butterworth_highpass_filter_new(y,sr,f,order);         
       end      
    end
    if(iband==3)  % bandpass
        if(iphase==1)
            [yf]=Butterworth_bandpass_refilter_new(y,sr,fl,fh,order);
        else
            [yf]=Butterworth_bandpass_new(y,sr,fl,fh,order);
        end   
    end
    if(iband==4)  % bandstop
        if(iphase==1)
            [yf]=Butterworth_bandstop_refilter_new(y,sr,fl,fh,order);
        else
            [yf]=Butterworth_bandstop_new(y,sr,fl,fh,order);
        end         
    end    
end    
try
        mu=mean(yf);
        sd=std(yf);
        rms=sqrt(sd^2+mu^2);
catch
    warndlg('Error ref 2');
    return;
end