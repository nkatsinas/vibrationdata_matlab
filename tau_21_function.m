%
%    tau_21_function.m  ver 1.0 by Tom Irvine
%

function[tau_12,tau_21]=tau_21_function(em_1,em_2,mu_1,mu_2,md_1,md_2,...
                                                           thick_1,thick_2)
    
cl_1=sqrt(em_1/(md_1*(1-mu_1^2)));
cl_2=sqrt(em_2/(md_2*(1-mu_2^2)));
    
X=thick_1/thick_2;

num=md_1*((cl_1)^1.5)*(thick_1^2.5);
den=md_2*((cl_2)^1.5)*(thick_2^2.5);

psi=num/den;

tau12_zero=2*( sqrt(psi) + 1/sqrt(psi) )^(-2);
tau_12=tau12_zero*(2.754*X/(1+3.24*X));

psi_inv=1/psi;
X_inv  =1/X;

tau21_zero=2*( sqrt(psi_inv) + 1/sqrt(psi_inv) )^(-2);
tau_21=tau21_zero*(2.754*X_inv/(1+3.24*X_inv));
