%
%   convert_general_standard_alt.m  ver 1.1  by Tom Irvine
%
function[Kstandard]=convert_general_standard_alt(MMA,KKA)
%
n=max(size(MMA));

[L,~,D]=vibrationdata_triangular_decomposition(MMA);

%
QQQ=eye(n,n);
%

DD=diag(D,0);

Lm=L*sqrt(DD);
Lminv=pinv(Lm)*QQQ;
Kstandard=(Lminv*KKA*Lminv');