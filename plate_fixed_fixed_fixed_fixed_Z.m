%
%  plate_fixed_fixed_fixed_fixed_Z.m  ver 1.0 by Tom Irvine
%
function[Z,d2Zdx2,d2Zdy2,d2Zdxdy,SXX,SYY,TXY]=...
                   plate_fixed_fixed_fixed_fixed_Z(x,y,a,b,mu,ZAA,root)
%
beta=root;
beta_x=root/a;
beta_y=root/b;
%
sigma=( sinh(beta)+sin(beta)  )/( cosh(beta)-cos(beta)  );
%
     P=@(x)            ( cosh(beta_x*x)-cos(beta_x*x) )-sigma*( sinh(beta_x*x)-sin(beta_x*x) );
  dPdx=@(x)   (beta_x*(( sinh(beta_x*x)+sin(beta_x*x) )-sigma*( cosh(beta_x*x)-cos(beta_x*x) )));
d2Pdx2=@(x) (beta_x^2*(( cosh(beta_x*x)+cos(beta_x*x) )-sigma*( sinh(beta_x*x)+sin(beta_x*x) )));
%
     W=@(y)            ( cosh(beta_y*y)-cos(beta_y*y) )-sigma*( sinh(beta_y*y)-sin(beta_y*y) );
  dWdy=@(y)   (beta_y*(( sinh(beta_y*y)+sin(beta_y*y) )-sigma*( cosh(beta_y*y)-cos(beta_y*y) )));  
d2Wdy2=@(y) (beta_y^2*(( cosh(beta_y*y)+cos(beta_y*y) )-sigma*( sinh(beta_y*y)+sin(beta_y*y) )));

Z=(P(x)*W(y))/ZAA;

d2Zdx2= d2Pdx2(x)*W(y)/ZAA;     
d2Zdy2= P(x)*d2Wdy2(y)/ZAA;  
d2Zdxdy=dPdx(x)*dWdy(y)/ZAA;

SXX=d2Zdx2 +mu*d2Zdy2;
SYY=d2Zdy2 +mu*d2Zdx2;
TXY=d2Zdxdy;