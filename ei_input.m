%
function[width,thick,joint_thick,B1,B2,E1,E2,I1,I2,L,area1,area2,br,e,HL,mp]=ei_input()
%
width=2.0;
thick=0.25;
 
L=input(' Enter L ');
% L=3
 
% width=width/100;
% thick=thick/100;
% L=L/100;
 
area1=width*thick;
 
rho=0.1/386;
% rho=(140/12^3)/386;
% rho=2400;
 
mp=area1*rho;
 
E1=1.0e+07;
% E1=5e+06;
% E1=30000e+06;
% E2=50e+06;
 
 
I1=(1/12)*width*thick^3;
 
joint_thick=thick;
 
area2=width*joint_thick;
 
I2=(1/12)*width*joint_thick^3;
 
B1=E1*I1;
 
br=input(' Enter b ratio ');
 
B2=br*B1;
 
E2=B2/I2;

e=(E2/E1)*(joint_thick/(2*L));

HL=6*thick;