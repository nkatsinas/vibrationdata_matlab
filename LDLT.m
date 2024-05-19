%
%  LDLT.m  ver 1.2  by Tom Irvine
%
%
%   LDLT is valid for a semidefinite matrix A
%
function [num,nz,jflag] = LDLT(A)
%
jflag=0;
num=0;
nz=0;
n=MAX(size(A));
%
% Diagonal Pivot
%
for i=1:n-1
    max=abs(A(i,i));
%
    for k=i+1:n
        if( abs(A(k,k))>max)
            max=abs(A(k,k));
% Row switch
%
                temp=A(i,1:n);
                A(i,1:n)=A(k,1:n);
                A(k,1:n)=temp;
%
% Column switch
%
                temp=A(1:n,i);
                A(1:n,i)=A(1:n,k);
                A(1:n,k)=temp;
%
        end
   end
end
%
%%%%%%%%%%%
%
L=eye(n,n);
U=zeros(n,n);
%
%  Triangular Decomposition
%
i=1;
%
U(1,1)=A(1,1);
%
L(2:n,1)=A(2:n,1)/U(1,1);
U(1,2:n)=A(1,2:n);
%
for i=2:n
%
    sum=L(i,1:i-1)*U(1:i-1,i);
%
    U(i,i)=A(i,i)-sum;
%
    for j=i+1:n
%        
         sum=L(j,1:j-1)*U(1:j-1,i);
%
        if( abs(U(i,i)) > 1.0e-12 )
            L(j,i)=(A(j,i)-sum)/U(i,i);
        else
            jflag=1;
            break;
        end
%
        sum=L(i,1:j-1)*U(1:j-1,j);
%
        U(i,j)=(A(i,j)-sum);
    end
    if(jflag==1)
        break;
    end
end
%
if(jflag==0)
%
% Solve for Diagonal Matrix D
%
    D = diag(U);
%
    num= length(find(diag(D)<0));
    nz= length(find(diag(D)==0));
    
%
end