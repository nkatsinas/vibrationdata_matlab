
%  ytick_linear_double_sided.m  ver 1.0  by Tom Irvine

function[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs)

ymax=0;
iflag=0;

 
for i=1:30
    
    n=i-20;
    
    X=10^n;
    
    if(yabs<=0.13*X)
       ymax=0.15*X;
       
       s1=sprintf('%g',-ymax);
       s2=sprintf('%g',-2*ymax/3);
       s3=sprintf('%g',-1*ymax/3);       
       s4='0';
       s5=sprintf('%g',1*ymax/3);
       s6=sprintf('%g',2*ymax/3);       
       s7=sprintf('%g',ymax);
    
       ytt=ymax*[ -1 -2/3  -1/3  0  1/3  2/3  1 ];
       yTT={s1;s2;s3;s4;s5;s6;s7};
       
       iflag=1;
       
       break;  
       
    end      
    
    if(yabs<=0.17*X)
       ymax=0.2*X;
       
       s1=sprintf('%g',-ymax);
       s2=sprintf('%g',-2*ymax/4);
       s3='0';
       s4=sprintf('%g',2*ymax/4);
       s5=sprintf('%g',ymax);
    
       ytt=ymax*[ -1 -0.5  0 0.5  1 ];
       yTT={s1;s2;s3;s4;s5};
       
       iflag=1;
       
       break;  
       
    end        
    
    
    if(yabs<=0.26*X)
       ymax=0.3*X;
       
       s1=sprintf('%g',-ymax);
       s2=sprintf('%g',-2*ymax/3);
       s3=sprintf('%g',-ymax/3);       
       s4='0';
       s5=sprintf('%g',ymax/3);       
       s6=sprintf('%g',2*ymax/3);
       s7=sprintf('%g',ymax);

    
       ytt=ymax*[ -1 -2/3 -1/3 0  1/3  2/3 1 ];
       yTT={s1,s2,s3,s4,s5,s6,s7};
       
       iflag=1;
       
       break;  
       
    end     
    
    if(yabs<=0.36*X)
       ymax=0.4*X;
       

       s1=sprintf('%g',-ymax);
       s2=sprintf('%g',-2*ymax/4);
       s3='0';
       s4=sprintf('%g',2*ymax/4);       
       s5=sprintf('%g',ymax);
      
       ytt=ymax*[ -1 -0.5 0 0.5 1 ];
       yTT={s1;s2;s3;s4;s5};
       
       iflag=1;
       
       break;  
       
    end     
    
    if(yabs<=0.48*X)
       ymax=0.5*X;
       

       s1=sprintf('%g',-ymax);
       s2='0';
       s3=sprintf('%g',ymax);
    
       ytt=ymax*[ -1 -0.8 -0.6 -0.4 -0.2  0  0.2 0.4 0.6 0.8 1 ];
       yTT={s1;'';'';'';'';s2;'';'';'';'';s3};
       
       iflag=1;
       
       break;  
       
    end    
    if(yabs<=0.96*X)
        
       ymax=1.0*X;
       
       s1=sprintf('%g',-ymax);
       s2=sprintf('%g',-2*ymax/4);
       s3='0';
       s4=sprintf('%g',2*ymax/4);
       s5=sprintf('%g',ymax);    
       
       ytt=ymax*[ -1  -0.5  0  0.5  1 ];       
       yTT={s1;s2;s3;s4;s5};       
       
       iflag=1;
       
       break;
       
    end
    
end

if(yabs>80 && yabs<95)
    ymax=100;
end