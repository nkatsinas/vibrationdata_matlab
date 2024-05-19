%
%   re_thin_plate.m  ver 1.0  by Tom Irvine
%
%   radiation efficiency thin plate
%
%    bc = 1  for ss
%    bc = 2  for clamped
%
%    a = smallest of length & width
%    b = largest of length & width
%    c = speed of sound
%    fcr = critical frequency
%
function[rad_eff_half_sp]=re_thin_plate(freq,fcr,a,b,c,bc)

    re_critical=@(P,lambda_c,aob)(0.45*sqrt(P/lambda_c)*(aob)^(1/4));
    re_above=@(f,fcr)( 1 - (fcr/f)  )^(-1/2);

    P=2*a+2*b;
    Ap=a*b;

    fcr_b=1.3*fcr;
 
    lambda_c=c/fcr;
 
    aob=a/b;

    if(aob>1)
        aob=1/aob;
    end
 
        if(freq<fcr)
        
            beta=sqrt(freq/fcr);
            beta2=beta^2;
        
            if(bc==1) % ss
                C1=1;
            else      % clamped
                C1=beta^2*exp(10*lambda_c/P);
            end
        
            if(freq<0.5*fcr)
                g1b=(4/pi^4)*(1-2*beta2)/( beta*(1-beta2) );
            else
                g1b=0;
            end
        
            arg=(1+beta)/(1-beta);
            num=(1-beta2)*log(arg)+2*beta;
            den=(1-beta2)^(1.5);
        
            g2b=(1/(4*pi^2))*num/den;
        
            term=g1b+(P/(2*lambda_c))*g2b;
            rad_eff_half_sp=(2*lambda_c/Ap)*term*C1;   
        end
        if(freq==fcr)
            rad_eff_half_sp=re_critical(P,lambda_c,aob);   
        end
        if( freq>fcr && freq < fcr_b)
        
            r1=re_critical(P,lambda_c,aob); 
            r2=re_above(freq,fcr);
        
            df=freq-fcr;
            L=fcr_b-fcr;
        
            c2=df/L;
            c1=1-c2;
     
            rad_eff_half_sp=c1*r1+c2*r2;
        
        end
        if(freq>=fcr_b)
            rad_eff_half_sp=re_above(freq,fcr);
        end 
