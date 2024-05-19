

%  Dirlik_coefficients.m  ver 1.0  by Tom Irvine

function[D1,D2,D3,R,Q,EP]=Dirlik_coefficients(m0,m1,m2,m4)
%

EP=sqrt(m4/m2);
x=(m1/m0)*sqrt(m2/m4);
gamma=m2/(sqrt(m0*m4));
D1=2*(x-gamma^2)/(1+gamma^2);
R=(gamma-x-D1^2)/(1-gamma-D1+D1^2);
D2=(1-gamma-D1+D1^2)/(1-R);
D3=1-D1-D2;
Q=1.25*(gamma-D3-D2*R)/D1;   
            
