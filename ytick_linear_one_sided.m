
%  ytick_linear_one_sided.m  ver 1.0  by Tom Irvine

function[ymax,yTT,ytt,iflag]=ytick_linear_one_sided(yabs)

ymax=0;
iflag=0;

s1=sprintf('0');
 
for i=1:30
    
    n=i-20;
    
    X=10^n;
    
      
    
    if(yabs<=0.16*X)
       ymax=0.2*X;
       
       s2=sprintf('%g',ymax/4);
       s3=sprintf('%g',2*ymax/4);
       s4=sprintf('%g',3*ymax/4);
       s5=sprintf('%g',ymax);
    
       ytt=[ 0  ymax/4  2*ymax/4 3*ymax/4 ymax ];
       yTT={s1;s2;s3;s4;s5};
    
       ytt=[ 0  ymax/3  2*ymax/3 ymax ];
       yTT={s1;s2;s3;s4};
       
       iflag=1;
       
       break;  
       
    end     
    if(yabs<=0.26*X)
       ymax=0.3*X;
       

       s2=sprintf('%g',ymax/3);
       s3=sprintf('%g',2*ymax/3);
       s4=sprintf('%g',ymax);
    
       ytt=[ 0  ymax/3  2*ymax/3 ymax ];
       yTT={s1;s2;s3;s4};
       
       iflag=1;
       
       break;  
       
    end     
    
    if(yabs<=0.36*X)
       ymax=0.4*X;
       

       s2=sprintf('%g',ymax/4);
       s3=sprintf('%g',2*ymax/4);
       s4=sprintf('%g',3*ymax/4);
       s5=sprintf('%g',ymax);
    
       ytt=[ 0  ymax/4  2*ymax/4 3*ymax/4 ymax ];
       yTT={s1;s2;s3;s4;s5};
       
       iflag=1;
       
       break;  
       
    end     
    
    if(yabs<=0.48*X)
       ymax=0.5*X;
       

       s2=sprintf('%g',ymax/5);
       s3=sprintf('%g',2*ymax/5);
       s4=sprintf('%g',3*ymax/5);
       s5=sprintf('%g',4*ymax/5);
       s6=sprintf('%g',ymax);
    
       ytt=[ 0  ymax/5  2*ymax/5 3*ymax/5 4*ymax/5 ymax ];
       yTT={s1;s2;s3;s4;s5;s6};
       
       iflag=1;
       
       break;  
       
    end    
    if(yabs<=0.96*X)
        
       ymax=1.0*X;
       
       s2=sprintf('%g',ymax/4);
       s3=sprintf('%g',2*ymax/4);
       s4=sprintf('%g',3*ymax/4);
       s5=sprintf('%g',ymax);    
       
       ytt=[ 0  ymax/4  2*ymax/4 3*ymax/4 ymax ];       
       yTT={s1;s2;s3;s4;s5};       
       
       iflag=1;
       
       break;
       
    end
    
end

if(yabs>80 && yabs<95)
    ymax=100;
end