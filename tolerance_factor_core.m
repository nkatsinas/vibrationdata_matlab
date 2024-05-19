

%  tolerance_factor_core.m  ver 1.0  by Tom Irvine  


function[k,lambda_int,Z,mu]=tolerance_factor_core(p,c,nsamples)

v=nsamples-1;
vd2=v/2;

zprob=p/100;
confidence=c/100; 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    lambda_before=-7.;
    P_before=0.;
    lambda=7;
    P=1.;
%
    for i=1:200
%
        lambda_int=(lambda+lambda_before)/2.;   % works better than secant
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        sum=0;
        den=(1/2)*sqrt(pi);
        q=lambda_int/sqrt(2);      
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
           den=den*( 2*n + 3)/2;
%
        end
%
        P_int=q*exp(-q^2)*sum;
        P_int=1-(1-P_int)/2;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        if(P_int==zprob)
            break;
        end
%
        if(P_before < zprob && zprob < P_int)
           P=P_int;
           lambda=lambda_int;
        end
        if(P_int < zprob && zprob < P)
           P_before=P_int;
           lambda_before=lambda_int;
        end
%    
    end
    Z=lambda_int;

    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   noncentral t-distribution
%
    clear lambda_int;
    clear lambda;
    clear lambda_before;
    clear Pr_int;
    clear Pr;
    clear Pr_before;
    clear P;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    zprob=confidence;
    mu=sqrt(nsamples)*Z;
    mu2=mu^2;
    lambda=mu;
    q=lambda/sqrt(2);
%
    gamma_1_2=sqrt(pi);
    gamma_3_2=(1/2)*gamma_1_2;  % 1
%
    sum=0;
%
    den=gamma_3_2;
%
    for n=0:2000
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
    
    A=q*exp(-q^2);
%
    P=A*sum;
    P=(1-P)/2;
    if(lambda>6)
        P=0;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    lambda_before=-20.;
    Pr_before=0.;
    lambda=20;
    Pr=1.;
 
%
    for i=1:60
%
        lambda_int=(lambda+lambda_before)/2.;   % works better than secant
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        x=lambda_int;
        tsum=0;
        for(j=0:110)
            y=x^2/(x^2+v);
            ee=exp(-mu2/2)*(mu2/2)^j;
            pj=(1/factorial(j))*ee;
            qj=mu*ee/(sqrt(2)*gamma(j+1.5));
            j1=j+0.5;
            j2=j+1;
%
            Iy1=betainc(y,j1,vd2);
            Iy2=betainc(y,j2,vd2);    
%
            tsum=tsum+(pj*Iy1 + qj*Iy2);
%
       end
       tsum=tsum*0.5;
%
       Pr_int=tsum+P;
%
%
        if(Pr_int==zprob)
            break;
        end
%
        if(Pr_before < zprob && zprob < Pr_int)
           Pr=Pr_int;
           lambda=lambda_int;
        end
        if(Pr_int < zprob && zprob < Pr)
           Pr_before=Pr_int;
           lambda_before=lambda_int;
        end
%    
    end
    
%
    k=lambda_int/sqrt(nsamples);
%