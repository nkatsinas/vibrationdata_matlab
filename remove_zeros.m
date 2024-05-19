%
%   remove_zeros.m  ver 1.0  by Tom Irvine
%

function[ff,b]=remove_zeros(f,a)
 
iz=0;
 
FL=length(f);
 
for i=1:FL
    if(a(i)<1.0e-12)
    
        iz=i;
        
    end        
end
 
iz=iz+1;
 
ff=f(iz:FL);
b=a(iz:FL);

ff=fix_size(ff);
b=fix_size(b);
