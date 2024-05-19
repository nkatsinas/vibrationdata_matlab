function y = circular_ss_bessel_function_PF(u,n,A)
%
if n==0
    y=(besselj(n,u)-A*besseli(n,u)).*u;
else
    y=0;    
end