%
%   convert_general_standard.m  ver 1.0  September 8, 2012
%
function[Kstandard,lambdashift]=convert_general_standard(MMA,KKA)
%
disp(' ');
disp(' Apply shift?  1=yes  2=no ');
disp(' ');
as=input(' ');
%
fshift=0.;
if(as==1)
   disp(' Enter shift Hz')
   fshift=input(' ');
end
omegashift=fshift*2*pi;
lambdashift=omegashift^2;
%
n=max(size(MMA));
%
KKA=KKA+lambdashift*MMA;
%
A=MMA;
%
L=zeros(n,n);
U=zeros(n,n);
D=zeros(n,n);
%
%  Triangular Decomposition
%
L=eye(n,n);
%
i=1;
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
% Solve for Diagonal Matrix D
%
for i=1:n
    D(i,i)=U(i,i);
end
L;
D;
LT=L';
LT;
%
%% disp(' ');
%% disp(' Kstandard ');
%
n=max(size(MMA));
QQQ=eye(n,n);
%
Lm=L*sqrt(D);
Lminv=pinv(Lm)*QQQ;
Kstandard=(Lminv*KKA*Lminv');