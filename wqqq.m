
% Ax=B

BQ=[1+1i 0 0 0 ]';

AQ=[Eigenvalues(1,1)*AA+BB];

AQ(1,:)=0;
AQ(1,1)=1;

x1 = pinv(AQ)*BQ

