
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

N=4.2244/sqrt(rho*A0*L);

dx=L/1000;

Y=zeros(1001,1);

for i=0:1000

   x=dx*i;

   term=(1-(x/L));

   arg=-(omega*L/c)*term;

   Y(i+1)=N*(besselj(0,arg));

end


dx=L/1000;

for i=0:1000

   x=dx*i;

   term=(1-(x/L));

   arg=-(omega*L/c)*term;

   a=a+term*Y(i+1)^2;

end

a*dx/sqrt(rho*A0)