
clear z;
clear yy;
clear yydd;

L=100;
BL=4.73004;
B=BL/L;
num=cos(BL)-cosh(BL);
den=sin(BL)+sinh(BL);
A=num/den;

dx=L/100;

for i=1:101
    z(i)=(i-1)*dx;    
    yy(i)=sinh(B*z(i))+sin(B*z(i))+A*(cosh(B*z(i))+cos(B*z(i)));
    yydd(i)=sinh(B*z(i))-sin(B*z(i))+A*(cosh(B*z(i))-cos(B*(i)));
end


figure(9)
plot(z,-yy);
title('Free-Free Beam, Fundamental Mode')
ylabel('Modal Displacement')
xlabel('Percent Length')
grid on;

figure(10)
plot(z,yydd);
grid on;

max(abs(yy))
max(abs(yydd))
