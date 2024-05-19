
%  ytick_linear_alt.m  ver 1.0  by Tom Irvine

function[ymax]=ytick_linear_alt(yabs)

ymax=0;

for i=-10:10
    
    bb=(10^+i);
    
    if(yabs<=0.48*bb)
       ymax=0.5*bb;
       break;  
    end    
    if(yabs<=0.96*bb)
       ymax=1.0*bb; 
       break;  
    end
    
end