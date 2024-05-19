%
disp(' ');
disp(' modified_Gram_Schmidt.m  ver 1.1  August 22, 2018 ');
disp(' by Tom Irvine ');
disp(' ');
% Modified Gram-Schmidt Orthogonalization
%
% The inner product of two column vectors H and J is H'*J.
%
% Sample Data :
%
clear x;
clear yhat;
%
disp(' ');
disp(' Select method: ');
disp('  1=normalize with respect to mass matrix ');
disp('  2=normalize with respect to identity matrix ');
im=input(' ');
%
if(im==1)
    disp(' ');
    mass=input(' Enter mass matrix: ');
end
%
disp(' ');
x=input(' Enter trial vector matrix:  ');
%
m=size(x);  % number of columns
n=m(1,2);
%
yhat=zeros(n,n);
%
if(im==1)
%
% mass
%
    scale=x(:,1)'*mass*x(:,1);
    yhat(:,1)=x(:,1)/sqrt(abs(scale));
    for i=2:n
        for j=i:n
            x(:,j)=x(:,j)-(yhat(:,i-1)'*mass*x(:,j))*yhat(:,i-1);
        end
        scale=x(:,i)'*mass*x(:,i);
        yhat(:,i)=x(:,i)/sqrt(abs(scale));
    end  
%
    rcm=yhat'*mass*yhat;
%
    disp(' yhatT*mass*yhat = ');
    rcm
%
else
%    
% identity
%
    yhat(:,1)=x(:,1)/norm(x(:,1));
%    
    for i=2:n
        for j=i:n
            x(:,j)=x(:,j)-(yhat(:,i-1)'*x(:,j))*yhat(:,i-1);
        end
        yhat(:,i)=x(:,i)/norm(x(:,i));
    end 
end
%
yhat