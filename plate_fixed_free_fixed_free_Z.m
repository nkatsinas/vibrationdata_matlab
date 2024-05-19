%
%  plate_fixed_free_fixed_free_Z.m  ver 1.0 by Tom Irvine
%
function[Z,d2Zdx2,d2Zdy2,d2Zdxdy,SXX,SYY,TXY]=...
                   plate_fixed_free_fixed_free_Z(x,y,a,b,alpha_r,theta_r,beta,mu,ZAA,root)
%


bL=root;
C=(sinh(bL)+sin(bL))/(cosh(bL)-cos(bL)); 

beta2=beta^2;

alpha=alpha_r;
theta=theta_r;
theta2=theta^2;

   argx=beta*x;
   argy=theta*y;

cosh_argx=cosh(argx);
 cos_argx=cos(argx);

sinh_argx=sinh(argx);
 sin_argx=sin(argx);
 
 cos_argy=cos(argy);
 sin_argy=sin(argy);

 
P=(cosh_argx-cos_argx)-C*(sinh_argx-sin_argx); 
W=1+alpha*cos_argy;

Z=(P*W)/ZAA;

dPdx=beta*((sinh_argx+sin_argx)-C*(cosh_argx-cos_argx));
d2Pdx2=beta2*((cosh_argx+cos_argx)-C*(sinh_argx+sin_argx));

dWdy=-alpha*theta*sin_argy;
d2Wdy2=-alpha*theta2*cos_argy;   


d2Zdx2= d2Pdx2*W/ZAA;     
d2Zdy2= P*d2Wdy2/ZAA;  
d2Zdxdy=dPdx*dWdy/ZAA;


SXX=d2Zdx2 +mu*d2Zdy2;
SYY=d2Zdy2 +mu*d2Zdx2;
TXY=d2Zdxdy;