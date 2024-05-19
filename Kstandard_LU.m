%
%   Kstandard_LU.m  ver 1.2  by Tom Irvine
%
function[Kstandard,L,U,Qinv]=Kstandard_LU(MMA,KKA)
%
n=max(size(MMA));

[L,U,D]=vibrationdata_triangular_decomposition(MMA);

%
QQQ=eye(n,n);
%

DD=diag(D,0);

Lm=L*sqrt(DD);
Lminv=pinv(Lm)*QQQ;
Kstandard=(Lminv*KKA*Lminv');
Qinv=Lminv';

Kstandard=(Kstandard+Kstandard')/2;