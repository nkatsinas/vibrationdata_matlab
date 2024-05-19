%
%  yaxis_limits_linear.m  ver 2.0  by Tom Irvine
%
function[yh]=yaxis_limits_linear(yLimits,y)

yh=max(yLimits);
   
   
    maxm=max(y);
    
    v=[5 4 3 2 1];
    u=[1e+2 1e+1 1e+0 1e-1 1e-2 1e-3 1e-4];
    
    
    for j=1:length(u)
    
        for i=1:length(v)
            
            w=v(i)*u(j);
            
            if(maxm < (w*0.9) )
                yh=w;
            end
            
        end    
    end
