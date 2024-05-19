%
%   re_thin_plate_bc.m  ver 1.0  by Tom Irvine
%
%   radiation efficiency thin plate with bc.
%
%    bc=1  for simply supported
%      =2  for clamped
%
%    a = smallest of length & width
%    b = largest of length & width
%    c = speed of sound
%    fcr = critical frequency
%
%   Maidanik, Ribbed Panels, (2.39) to (2.42)
%   Price Crocker correction
%   Bies, Hanson, Howard, Engineering Noise Control
%
function[rad_eff]=re_thin_plate_bc(freq,fcr,a,b,c,bc)
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
        
            e=sqrt(f(i)/fcr);
            e2=e^2;
        
            if(bc==1) % ss
                gamma=1;
            else        % clamped
                gamma=2;
            end
        
            arg=(1+e)/(1-e);
            num=(1-e2)*log(arg)+2*e;
            den=(1-e2)^(1.5);

            delta1=(1/(4*pi^2))*num/den;

            if(f(i)<0.5*fcr)
                delta2=(4/pi^4)*(1-2*e2)/( e*sqrt(1-e2) );
            else
                delta2=0;
            end
        
            a1=P*c/(f(i)*Ap);
            a2=2*c^2/(f(i)^2*Ap);

            term=a1*delta1+a2*delta2;

            rad_eff(i)=term*gamma;
      
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


    