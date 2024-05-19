%
%   re_thin_plate_bc_alt.m  ver 1.0  by Tom Irvine
%
%   radiation efficiency thin plate with bc.
%
%    bc=1  for simply supported
%      =2  for free
%      =3  for clamped
%      =4  for generic
%
%      a = smallest of length & width
%      b = largest of length & width
%      c = speed of sound
%    fcr = critical frequency
%
function[rad_eff]=re_thin_plate_bc_alt(freq,fcr,a,b,c,bc)
%

f=freq;

NL=length(f);
 
fcr_b=1.3*fcr;

lambda_c=c/fcr;

aob=a/b;

P=2*a+2*b;
Ap=a*b;

re_critical=@(P,lambda_c,aob)(0.45*sqrt(P/lambda_c)*(aob)^(1/4));
re_above=@(f,fcr)( 1 - (fcr/f)  )^(-1/2);

rad_eff=zeros(NL,1);
    
for i=1:NL
    
%%      cb=sqrt(1.8*CLI*thick*f(i)); 

        if(f(i)<fcr)
        
            beta=sqrt(f(i)/fcr);
            beta2=beta^2;
      
            C1=1;

            if(bc==3)        % clamped
                C1=beta^2*exp(10*lambda_c/P);
            end
        
            if(f(i)<0.5*fcr)
                g1b=(4/pi^4)*(1-2*beta2)/( beta*(1-beta2) );
            else
                g1b=0;
            end
        
            arg=(1+beta)/(1-beta);
            num=(1-beta2)*log(arg)+2*beta;
            den=(1-beta2)^(1.5);
        
            g2b=(1/(4*pi^2))*num/den;
        
            term=g1b+(P/(2*lambda_c))*g2b;
            rad_eff(i)=(2*lambda_c/Ap)*term*C1;   
        end
        if(f(i)==fcr)
            rad_eff(i)=re_critical(P,lambda_c,aob);   
        end
        if( f(i)>fcr && f(i) < fcr_b)
        
            r1=re_critical(P,lambda_c,aob); 
            r2=re_above(f(i),fcr);
        
            df=f(i)-fcr;
            L=fcr_b-fcr;
        
            c2=df/L;
            c1=1-c2;
     
            rad_eff(i)=c1*r1+c2*r2;
        
        end
        if(f(i)>=fcr_b)
            rad_eff(i)=re_above(f(i),fcr);
        end 
end


    