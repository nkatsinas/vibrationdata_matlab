
clear z;
clear yy;

L=100;
BL=1.87510;
B=BL/L;
num=cos(BL)+cosh(BL);
den=sin(BL)+sinh(BL);
A=num/den;

dx=L/100;

for i=1:101
    z(i)=(i-1)*dx;    
    yy(i)=cosh(B*z(i))-cos(B*z(i))-A*(sinh(B*z(i))-sin(B*z(i)));
end

figure(9)
plot(z,yy);
title('Fixed-Pree Beam, Fundamental Mode')
ylabel('Modal Displacement')
xlabel('Percent Length')
grid on;

max(yy)
