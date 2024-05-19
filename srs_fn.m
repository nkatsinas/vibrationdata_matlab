%
%   srs_fn.m  ver 1.0  by Tom Irvine
%

function[fn,num]=srs_fn(fspace,fstart,fend,fmax)

num=1;
fn(1)=fstart;

if(fspace==1)

    [fn]=one_twelfth_octave();
           
end

if(fspace==2)

    oct=2^(1/24);

    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)*oct;
  
        if(fn(num)>fmax)
            break;
        end
    
    end

end
if(fspace==3)
    
    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)+1.;
  
        if(fn(num)>fmax)
            break;
        end
    
    end
end    
if(fspace==4)
    
    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)+0.5;
  
        if(fn(num)>fmax)
            break;
        end
    
    end
end    

%%%%%%%%%

[~,i1]=min(abs(fn-fstart));

    
if(fend<fmax)
    [~,i2]=min(abs(fn-fend));    
else
    [~,i2]=min(abs(fn-fmax));            
end
    
fn=fn(i1:i2);  
 
num=length(fn);