%
%   mean_removal_Hanning.m  ver 1.1  by Tom Irvine
%
function[y]=mean_removal_Hanning(y,mr_choice,hw_choice)
%

y=fix_size(y);

n=length(y);
mu=mean(y);
%
    if(mr_choice==1)
        y=y-mu;
    end
%    
    if(hw_choice==2)
        
        y=y-mu;
        
        ae=sqrt(8/3);
        hw=zeros(n,1); 
        
        for i=0:(n-1)  
            hw(i+1) =sin( (i*pi/n) )^2 ;
        end
        y=(y.*hw)*ae;
        
    end
