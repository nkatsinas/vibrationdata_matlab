
n=input('Enter n:  ');
peak_1=input('Enter peak_1:  ');
peak_n=input('Enter peak_n:  ');


dec=(1/n)*log(peak_1/peak_n);
%

den=1 + (2*pi/dec)^2;

damping=1/sqrt(den);

Q=1/(2*damping);

out1=sprintf(' log decrement = %8.4g ',dec);
out2=sprintf(' damping ratio = %8.4g ',damping);
out3=sprintf('             Q = %8.4g ',Q);

disp(out1);
disp(out2);
disp(out3);