%
%   remove_zeros_all.m  ver 1.0  by Tom Irvine
%

function[f,a]=remove_zeros_all(f,a)
 
iflag=1;

while(iflag==1)
    
    iflag=0;
    
    for i=1:length(f)
        if(a(i)<1.0e-12)
            
            f(i)=[];
            a(i)=[]; 
            
            iflag=1;
            break; 
        end
    end        
end

f=fix_size(f);
a=fix_size(a);


