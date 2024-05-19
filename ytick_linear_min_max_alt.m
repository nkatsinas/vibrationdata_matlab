
%  ytick_linear_alt.m  ver 1.1  by Tom Irvine

function[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if((ymax-ymin)<=18)

    for i=-100:2:100
        if(ymax<i)
            ymax=i;
            break;
        end
    end    
    
    for i=-100:2:100
        if(ymin<i)
            ymin=i-2;
            break;
        end
    end
    
    k=1;    
    
    if((ymax-ymin)<=8)
        iq=1;
    else
        iq=2;
    end
    
    for i=ymin:iq:ymax
        ytt(k)=i;
        yTT{k}=sprintf('%d',i);
        k=k+1;
    end    
    
else    
    
    for i=-100:5:100
        if(ymax<i)
            ymax=i;
            break;
        end
    end    

    for i=-100:5:100
        if(ymin<i)
            ymin=i-5;
            break;
        end
    end

    k=1;
    for i=ymin:5:ymax
        ytt(k)=i;
        yTT{k}=sprintf('%d',i);
        k=k+1;
    end    
    
end

