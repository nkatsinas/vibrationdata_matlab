
L=100;
BL=3.9266;
B=BL/L;
num=sinh(BL)+sin(BL);
den=cosh(BL)+cos(BL);
A=num/den;


fun = @f; % function
x0 =50 ; % initial point
z = fzero(fun,x0)


dx=L/100;

for i=1:101
    z(i)=(i-1)*dx;    
    yy(i)=sinh(B*z(i))-sin(B*z(i))-A*(cosh(B*z(i))-cos(B*z(i)));
end

figure(11)
plot(z,-yy);
title('Fixed-Pinned Beam, Fundamental Mode')
ylabel('Modal Displacement')
xlabel('Percent Length')
grid on;




function y = f(x)

L=100;
BL=3.9266;
B=BL/L;
num=sinh(BL)+sin(BL);
den=cosh(BL)+cos(BL);
A=num/den;
y = cosh(B*x)-cos(B*x)-A*(sinh(B*x)+sin(B*x)); % derivative

end
