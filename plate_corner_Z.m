%
%  plate_corner_Z.m  ver 1.0 by Tom Irvine
%
function[Z,d2Zdx2,d2Zdy2,d2Zdxdy,SXX,SYY,TXY]=...
                               plate_corner_Z(x,y,a,b,alpha,beta,gamma,mu,ZAA)
%
xpa=x*pi/a;
ypb=y*pi/b;
 
 
cx=cos(xpa);
dcx=-sin(xpa)*(pi/a);
ddcx=-cos(xpa)*(pi/a)^2;
 
sx=sin(xpa);
dsx=cos(xpa)*(pi/a);
ddsx=-sin(xpa)*(pi/a)^2;
 
cy=cos(ypb);
dcy=-sin(ypb)*(pi/b);
ddcy=-cos(ypb)*(pi/b)^2;
 
sy=sin(ypb);
dsy=cos(ypb)*(pi/b);
ddsy=-sin(ypb)*(pi/b)^2;
 
 
Z=(alpha*cx + beta*cy + gamma*cx*cy)/ZAA;
 
d2Zdx2=(alpha*ddcx + gamma*ddcx*cy)/ZAA;
d2Zdy2=( beta*ddcy + gamma*cx*ddcy)/ZAA;
d2Zdxdy=(gamma*dcx*dcy)/ZAA;
 
SXX=d2Zdx2 +mu*d2Zdy2;
SYY=d2Zdy2 +mu*d2Zdx2;
TXY=d2Zdxdy;