%
%   remove_zeros_mo.m  ver 1.0  by Tom Irvine
%

function[ff,b,fsea]=remove_zeros_mo(f,a)
 
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


FFL=length(FL);


for i=1:FFL
    
    if(b(i)<1)
        
        faasdfsadfaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
          
    end
    
end

ff=fix_size(ff);
 b=fix_size(b);