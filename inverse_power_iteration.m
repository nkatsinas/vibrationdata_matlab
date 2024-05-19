disp(' ');
disp(' inverse_power_iteration.m  ver 1.2  August 21, 2018 ');
disp('  ');
disp(' by Tom Irvine ');
disp(' ')
disp(' This script finds the lowest eigenvalue for the generalized ');
disp(' eigenvalue problem. ');
disp(' ');
disp(' Reference:  Bathe, page 617 ');
disp(' ');
%
clear K;
clear Kinv
clear M;
clear X;
clear Y;
clear n;
%
disp(' ');
M=input(' Enter the mass matrix name:  ');
disp(' ');
K=input(' Enter the stiffness matrix name:  ');
%
disp(' ');
num=input(' Enter the maximum number of iterations: ');
%
disp(' ');
disp(' A shift is needed if the lowest value is zero. ');
disp(' ');
ish=input(' Enter shift?  1=yes 2=no ');
if(ish==1)
    disp(' ');
    iv=input(' Enter shift value ');
    K=K+iv*M;
end
%
n=max(size(M));
%
X=zeros(n,1);
Y=zeros(n,1);
%
for i=1:n
    Y(i)=rand;
end
Y=Y-0.5;
%
Kinv=pinv(K);
%
for i=1:num
    Xhat=Kinv*Y;
    Yhat=M*Xhat;
    rho=Xhat'*Yhat/(Xhat'*Y);
    Y=Yhat/sqrt(Xhat'*Y);
end
%
rho=1/rho;
%
if(ish==1)
    rho=rho-iv;
end
%
disp(' ');
if(abs(rho)< 1.0e-04)
    rho=0.;
end

rho

%
out1=sprintf(' The minimum eigenvalue = %8.4g ',rho);
disp(out1);
out1=sprintf('              frequency = %8.4g Hz',sqrt(abs(rho))/(2*pi));
disp(out1);
disp(' ');
idis=input(' Display mass-normalized eigenvector?  1=yes 2=no ');
%
if(idis==1)
    r=Xhat'*M*Xhat;
    Xhat=Xhat/sqrt(r);
    Xhat
end