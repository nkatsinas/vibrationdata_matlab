
clear z;
clear yy
clear yydd;

L=100;
BL=4.73;
B=BL/L;
num=sinh(BL)+sin(BL);
den=cosh(BL)-cos(BL);
A=num/den;


dx=L/100;

for i=1:101
    z(i)=(i-1)*dx;    
    yy(i)=cosh(B*z(i))-cos(B*z(i))-A*(sinh(B*z(i))-sin(B*z(i)));
    yydd(i)=cosh(B*z(i))+cos(B*z(i))-A*(sinh(B*z(i))+sin(B*z(i)));
end


figure(9)
plot(z,yy);
title('Fixed-Fixed Beam, Fundamental Mode')
ylabel('Modal Displacement')
xlabel('Percent Length')
grid on;

figure(10)
plot(z,yydd);
grid on;

max(abs(yy))
max(abs(yydd))
