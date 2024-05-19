%
%  cubic_roots.m  ver 1.0  by Tom Irvine
%
%  This scripts finds the roots of 
%
%  f(x)=ax^3+bx^2+cx+d 

function[R]=cubic_roots(a,b,c,d)

j=1i;

p=(1/a)*((-b^2/(3*a))+c);
q=(1/(27*a^3))*((2*b^3)-(9*a*b*c)+(27*a^2*d));
%
r1=sqrt(q^2+4*p^3/27);
%
N1=(-q+r1)/2;
N2=(-q-r1)/2;
%
aa=real(N1);
bb=imag(N1);
%
alpha=(1/3)*atan2(bb,aa);
%
z(1)=((aa^2+bb^2)^(1/6))*(cos(alpha)+j*sin(alpha));
z(2)=z(1)*(-1+j*sqrt(3))/2;
z(3)=z(1)*(-1-j*sqrt(3))/2;
%
aa=real(N2);
bb=imag(N2);
%
alpha=(1/3)*atan2(bb,aa);
%
z(4)=((aa^2+bb^2)^(1/6))*(cos(alpha)+j*sin(alpha));
z(5)=z(4)*(-1+j*sqrt(3))/2;
z(6)=z(4)*(-1-j*sqrt(3))/2;
%
disp(' ');
disp(' roots ');
%
w=zeros(3,1);
x=zeros(3,1);

for i=1:3
    w(i)=z(i)-p/(3*z(i));
    x(i)=w(i)-b/(3*a);
    out1=sprintf(' %8.4g +j( %8.4g)',real(x(i)),imag(x(i)));
    disp(out1);
end

R=x;


