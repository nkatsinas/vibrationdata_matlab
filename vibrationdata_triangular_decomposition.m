%
%  vibrationdata_triangular_decomposition.m ver 1.0 by Tom Irvine
%
%  Triangular Decomposition 
%
%  Matlab has an lu function, but the following method appears to be 
%  more accurate for Sturm eigenvalue analysis.
%

function[L,U,D]=vibrationdata_triangular_decomposition(A)

n=max(size(A));

U=zeros(n,n);
%
L=eye(n,n);
%
U(1,1)=A(1,1);
for i=2:n
    L(i,1)=A(i,1)/U(1,1);
    U(1,i)=A(1,i);
end
%
for i=2:n
%
    sum=0.;
    for k=1:i-1
        sum=sum+U(k,i)*L(i,k);
    end
    U(i,i)=A(i,i)-sum;
%
    for j=i+1:n
%        
        sum=0.;
        for k=1:j-1
            sum=sum+U(k,i)*L(j,k);
        end
        L(j,i)=(A(j,i)-sum)/U(i,i);
%
        sum=0.;
        for k=1:j-1
            sum=sum+U(k,j)*L(i,k);
        end
        U(i,j)=(A(i,j)-sum);
    end
end
%
D=diag(U);