
v=12*10934;
d=76;
A=pi*d^2/4;
r=10;
alpha=8.83e-05;
rho= 1.1466e-07;   % lbf sec^2/in^4   
c=13500;
%
prms=alpha*(rho/r)*sqrt(A*c*v^3)

dB=20*log10(prms/2.9e-09)