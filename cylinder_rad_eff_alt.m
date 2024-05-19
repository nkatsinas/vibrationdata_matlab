%
%  cylinder_rad_eff_alt.m  ver 1.0  by Tom Irvine
%
function[rad_eff]=cylinder_rad_eff_alt(f,fcr,fring,L,diam,c,bc)
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
                    
            if(fring<fcr)  % thin-walled, large diameter
                
                if(f<=fring)
                %   NASA CR-111840                        
                else 
                %   Maidanik, Ribbed Panels, (2.39) to (2.42)
                %   Price Crocker correction
                %   Bies, Hanson, Howard, Engineering Noise Control            
                    
                    if(f<fcr)                    
        
                        ns=1;

                        W=pi*diam;
                        a=min([L W]);
                        b=max([L W]);

                        fc=f;
                
                        if(ns==1) % thin
                            
                            [rad_eff]=re_thin_plate_bc_alt_2(fc,fcr,a,b,c,bc);
                        
                        end
                        if(ns==2)  % thick
                        
                            freq=f;
                                
                            [rad_eff]=re_thick_plate(freq,fcr,a,b,c);
                            
                        end

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
