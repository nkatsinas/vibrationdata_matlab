%
%   three_by_three_invariants.m  ver 1.0  by Tom Irvine
%
function[lambda,evector]=three_by_three_invariants(A)
%
    I1=trace(A);
 
    I2=0;
 
    for i=1:3
        for j=1:3
            I2=I2+A(i,i)*A(j,j)-A(i,j)*A(j,i);
        end
    end
 
    I2=I2/2;
 
    I3=det(A);
 
    disp(' Invariants')
    out1=sprintf(' I1=%8.4g  I2=%8.4g  I3=%8.4g  ',I1,I2,I3);
    disp(out1);
 
%%%
 
    [evector,D] = eig(A);
   
    sz=size(D);
   
    n=sz(1);
   
    lambda=zeros(n,1);
     

    for i=1:n
       lambda(i)=D(i,i);
    end
  
    
    big=zeros(4,3);
    big(1,:)=lambda;
    
    for i=2:4
        big(i,:)=evector(i-1,:);
    end
        
    clear lambda;
    clear evector;
   
    
    big=sortrows(big',-1)';    
    
    
    lambda=big(1,:);
    
    evector=zeros(3,3);
    
    for i=2:4
        evector(i-1,:)=big(i,:);
    end
    
    
    n1=evector(:,1);
    n2=evector(:,2);
    
    n3=cross(n1,n2);
    
    for i=1:3
        evector(i,3)=n3(i);
    end    