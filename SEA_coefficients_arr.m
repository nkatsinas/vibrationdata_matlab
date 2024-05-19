%
%   SEA_coefficients_arr.m  ver 1.0  by Tom Irvine
%
function[A]=SEA_coefficients_arr(n,lf,clf,i)
%
    A=zeros(n,n);
        
    for j=1:n
        for k=1:n
            
            if(j~=k)
                A(j,k)=-clf(i,k,j);
            end
            
        end
    end
    
    
    for j=1:n

        A(j,j)=lf(i,j);
    
        for k=1:n
            if(j~=k)    
                A(j,j)=A(j,j)+clf(i,j,k);
            end
        end    
    end 
 