


L=24;


diameter=2;
A0=pi*diameter^2/4;
AL=0;
alpha=(AL/A0)-1;
E=10e+06;
rho=0.1/386;

c=sqrt(E/rho);

k=2.404826;

omega=k*c/L;


a=0;

dx=L/1000;

for i=0:1000

   x=dx*i;

   term=(1-(x/L));

   arg=-(omega*L/c)*term;

   a=a+term*(besselj(0,arg))^2;

end


a=a*dx/k

a=a*(4.2244/sqrt(L))^2

% 1/a

% sqrt(1/a)*sqrt(L)