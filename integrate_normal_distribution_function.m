
%
%  integrate_normal_distribution_function.m  ver 1.0  by Tom Irvine
%

function[P]=integrate_normal_distribution_function(lambda)

     q=lambda/sqrt(2);
%
     gamma_1_2=sqrt(pi);
     gamma_3_2=(1/2)*gamma_1_2;  % 1
     gamma_5_2=(3/2)*gamma_3_2;  % 2
%
     sum=0;
%
     den=gamma_3_2;
%
     for n=0:1000
%       
        b=q^(2*n)/den;
%
        if(den<1.0e+100)
        else
            break;
        end
%
        sum=sum+b;
%
        den=den*( 2*n + 3)/2;
%
     end
%
     A=q*exp(-q^2);
%
     P=A*sum;
%
%%     out1=sprintf('\n      P[ -lambda <= Z <=lambda ] = %15.9g ',P);
%%     disp(out1);
%