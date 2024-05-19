clear x;
clear y;

tpi=2*pi;

for i=1:550
    x(i)=i/100;
    arg(i)=tpi*x(i);
    y(i)=sin(arg(i))/(arg(i));
end


figure(1);
plot(arg,y);
grid on;