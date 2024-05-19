function y = circular_ss_bessel_function(u,n,A)
y=2*((besselj(n,u)-A*besseli(n,u)).^2).*u;