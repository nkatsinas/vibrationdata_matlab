%
%   ytick_label.m  ver 1.8  by Tom Irvine
%
function[ytt,yTT,jflag]=ytick_label(ymin,ymax)


ytt=[];
yTT={};
jflag=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


for j=-60:60
    
    if(ymin>=10^j && ymin<10^(j+1))
        
    
        a=j;
    
        for i=-59:61
            b=i;
            c=b-a+1;
        
            if(ymax<=10^i)
                
                try
                    ytt=logspace(a,b,c);
                    n=length(ytt);
                catch
                     disp('fail 1');                   
                end
                try    
                    [yTT,ytt]=set_yTT(ytt);
                    jflag=1;
                    break;
                catch
                    ytt
                    n=length(ytt)
                    disp('fail 2');
                end
                
                break;
                
            end    
            
        end
      
    end
    if(jflag==1)
        break;
    end    
end
