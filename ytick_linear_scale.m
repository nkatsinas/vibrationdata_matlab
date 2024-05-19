
%  ytick_linear_scale.m  ver 1.1  by Tom Irvine

function[ymax]=ytick_linear_scale(yabs)

ymax=0;
for i=-12:12
    
    eee=10^i;
    
    if(yabs<=0.13*eee)
       ymax=0.15*eee;
       break;  
    end        
    if(yabs<=0.18*eee)
       ymax=0.2*eee;
       break;  
    end        
    if(yabs<=0.38*eee)
       ymax=0.4*eee;
       break;  
    end 
    
    if(yabs<=0.48*eee)
       ymax=0.5*eee;
       break;  
    end    
    if(yabs<=0.96*eee)
       ymax=1.0*eee; 
       break;  
    end
    
end