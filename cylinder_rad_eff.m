%
%  cylinder_rad_eff.m  ver 1.0  by Tom Irvine
%
function[rad_eff]=cylinder_rad_eff(f,fcr,fring,L,diam,c,mu)
%
F=1.122;  % one-third octave  
 
pdiam=diam*pi;
 
a=min([L pdiam]);
b=max([L pdiam]);
 
P=2*L+2*pdiam;
 
 
f1=20;  % keep this pair
r1=0.6e-03;
 
fcr_b=1.3*fcr;
 
lambda_c=c/fcr;
 
aob=a/b;
 
re_critical=@(P,lambda_c,aob)(0.45*sqrt(P/lambda_c)*(aob)^(1/4));
re_above=@(f,fcr)( 1 - (fcr/f)  )^(-1/2);
 
vlim=0.65*log10(3*fcr/fring);
 
vo=f/fring;

 
if( ( vo<(1/F) && vo < vlim ) || ( (fring/fcr) > 1.5 && vo<( fcr/fring ) ))  % cylinder
    
            if(vo<=0.48)
                B=2.5*sqrt(vo);
            end
            if(0.48<vo && vo <=0.83)
                B=3.6*vo;
            end
            if(vo>0.83)
                arg1=1.745/(F^2*vo^2);
                arg2=1.745*(F^2/vo^2);
                B=2+(0.23/(F-(1/F)))*(F*cos(arg1) -(1/F)*cos(arg2));
            end
            
            num=vo^(3/2)*fring/fcr;
            den=F-(1/F);
            
            A1=(1/(2*B))*num/den;
            
            A2=1-vo*sqrt( 1-vo^2*(fring/fcr)^2 );
            
            A31=1/sqrt( (1/F) - vo );
            A32=1/sqrt(  F - vo );
            
            A3=A31-A32;
            
            A4=sqrt(12*(1-mu^2));
            
            rad_eff=A1*A2*A3*A4;
           
else  % mid region
            
            rad_eff=1;            
            
            if(fring<fcr)  % thin-walled, large diameter
                
                if(f<=fring)
                    
                    f2=fring;
                    r2=1;
                    n=log10(r2/r1)/log10(f2/f1);
                    rad_eff=r1*(f/f1)^n;
                    
                else  % plate
                                
                    
                    if(f<fcr)                    
        
                       f1=log10(fring); 
                       r1=1;
                       
                       f2=log10(sqrt(fring*fcr));
                       r2=0.7;
                       
                       f3=fcr;
                       r3=log10(re_critical(P,lambda_c,aob));
                       if(r3>3.5)
                           r3=3.5;
                       end
                       
                       fff=[f1 f2 f3];
                       rrr=[r1 r2 r3];
                       
                       p = polyfit(fff,rrr,2);
                       
                       fx=log10(f);
                       
                       rx=p(1)*fx^2+p(2)*fx+p(3);
   
                       rad_eff=rx;
                       
                    end
                    if(f==fcr)
                        rx=re_critical(P,lambda_c,aob);   
                        if(rx>3.5)
                            rx=3.5;
                        end
                        rad_eff=rx;
                    end
                    if( f>fcr && f < fcr_b)
        
                        r1=re_critical(P,lambda_c,aob);
                        if(r1>3.5)
                            r1=3.5;
                        end
                        
                        
                        r2=re_above(f,fcr);
        
                        df=f-fcr;
                        Lx=fcr_b-fcr;
        
                        c2=df/Lx;
                        c1=1-c2;
     
                        rad_eff=c1*r1+c2*r2;
        
                    end
                    if(f>=fcr_b)
                        rad_eff=re_above(f,fcr);
                    end 
                end                    
                    
            else  % fring > fcr 
                
                if(f<fcr)
                    
                    f2=fcr;
                    r2=1;
                    
                    n=log10(r2/r1)/log10(f2/f1);
                    rad_eff=r1*(f/f1)^n;                     
                    
                else
                    rad_eff=1; 
                end
                
            end 
end