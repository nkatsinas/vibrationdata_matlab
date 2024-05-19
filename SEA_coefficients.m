%
%   SEA_coefficients.m  ver 1.0  by Tom Irvine
%
function[A]=SEA_coefficients(n,lf,clf)
%
    A=zeros(n,n);
        
    for j=1:n
        for k=1:n
            
            if(j~=k)
                A(j,k)=-clf(k,j);
            end
            
        end
    end
    
    
    for j=1:n

        A(j,j)=lf(j);
    
        for k=1:n
            if(j~=k)    
                A(j,j)=A(j,j)+clf(j,k);
            end
        end    
    end 
 