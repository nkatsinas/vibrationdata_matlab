

% honeycomb_sandwich_critical_frequency_core.m  ver 1.2  by Tom Irvine


function[fcr]=honeycomb_sandwich_critical_frequency_core(mpa,c,S,B,Bf,G,hc)


tpi=2*pi;

rho=mpa;
        
    term=c^2*rho/S;
       
    
    if(term<=0.98)
        
        disp(' ');
        disp(' Wijker method for critical frequency');
    
        num=(c^4*rho/B);
        den=(1-term);
        
        aa=num/den;
        
        omega_cr=sqrt(aa);
        fcr=omega_cr/tpi;
        
    else
        
        disp(' ');        
        disp(' alternate method for critical frequency ');        
        
%
%       Find frequency at which wave speed = speed of sound
%
        
        omega1=tpi*10; 
        omega3=tpi*100000; 
        
                                            
        [ccc1]=sandwich_wavespeed_polynomial(omega1,B,Bf,G,mpa,hc);        
        [ccc3]=sandwich_wavespeed_polynomial(omega3,B,Bf,G,mpa,hc);
        omega2=sqrt(omega1*omega3);
        
        for k=1:100
         
            [ccc2]=sandwich_wavespeed_polynomial(omega2,B,Bf,G,mpa,hc);
            [wavespeed]=sandwich_wavespeed_polynomial_core(omega2,B,Bf,G,mpa,hc);
        
            out1=sprintf('  omega2=%8.4g  f=%8.4g  c=%8.4g wavespeed=%8.4g',omega2,omega2/tpi,ccc2,wavespeed);
            disp(out1);
            
            if(ccc1<=c && c<=ccc2)
               omega3=omega2; 
                 ccc3=ccc2;
            end
            if(ccc2<c && c<=ccc3)
               omega1=omega2; 
                 ccc1=ccc2;                
            end
            
            
            nn=log10( ccc3/ccc1 )/log10( omega3/omega1 );
            
            omega2=omega1*( c/ccc1 )^(1/nn);
            
            if( (abs(c-ccc2)/c)<0.01)
                break;
            end           
            if( (abs(omega3-omega1)/omega1)<0.01)
                break;
            end
            
        end
        
        fcr=omega2/tpi;
    end