

% arbitrary_isolator_stiffness.m  ver 2.0  by Tom Irvine


function[k]=arbitrary_isolator_stiffness(kx,ky,kz,x,y,z)

n=length(kx);

k=zeros(6,6);

%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:n
    
    k(1,1)=k(1,1)+kx(i);
    
    k(1,5)=k(1,5)+kx(i)*z(i);
    k(1,6)=k(1,6)-kx(i)*y(i);
    
    k(2,2)=k(2,2)+ky(i);    
    k(2,4)=k(2,4)-ky(i)*z(i);
    k(2,6)=k(2,6)+ky(i)*x(i);    

    k(3,3)=k(3,3)+kz(i); 
    k(3,4)=k(3,4)+kz(i)*y(i);
    k(3,5)=k(3,5)-kz(i)*x(i);    
    
%%%    
    
    k(4,4)=k(4,4)+ (kz(i)*y(i)^2 + ky(i)*z(i)^2);
    k(4,5)=k(4,5)-  kz(i)*x(i)*y(i);
    k(4,6)=k(4,6)-  ky(i)*x(i)*z(i);    
    
    k(5,5)=k(5,5)+ (kx(i)*z(i)^2) + (kz(i)*x(i)^2); 
    k(5,6)=k(5,6)-  kx(i)*z(i)*y(i);  
    
    k(6,6)=k(6,6)+ (kx(i)*y(i)^2) + (ky(i)*x(i)^2);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Symmetry
%
for i=1:6 
    for j=1:i-1
        k(i,j)=k(j,i);    
    end
end
%