%
%   re_thick_plate_bending_shear.m  ver 1.1  by Tom Irvine
%
%   radiation efficiency thick plate
%
%    a = smallest of length & width
%    b = largest of length & width
%    c = speed of sound
%    fcr = critical frequency
%
function[rad_eff]=...
              re_thick_plate_bending_shear(freq,fcr,a,b,c,em,md,mu,h)

omega=2*pi*freq;          
          
[~,cs,fshift]=re_thick_plate_bending_shear(em,md,mu,h,omega);

f=freq;
fs=fshift;

NL=length(f);

S=a*b;
U=2*(a+b);

a1=c^2/(S*fcr^2);
a2=U*c/(S*fcr);
 
rad_eff=zeros(NL,1);

rad_min=1.0e+90;
freq_min=100;

for i=1:NL
   
   aaa=1+(2*fs/f(i))^2;
    
   term=sqrt(-0.5 + 0.5*sqrt(aaa)); 
    
   Cbeff=cs*(f(i)/fs)*term;
   
   alpha=Cbeff/c;
   
   if(f(i)<=fcr)
       
      if(alpha < sqrt(2)/2)
         anum=8*(1-2*alpha^2);
         aden=pi^4*alpha*sqrt(1-alpha^2);
         g1= anum/aden;
      else
         g1=0; 
      end
      
      x=1+alpha;
      y=1-alpha;
      
      bnum=(1-alpha^2)*log(x/y)+2*alpha;
      bden=(1-alpha^2)^(1.5);
      g2=(bnum/bden)/(4*pi^2);
             
      rad_eff(i)=a1*g2+a2*g1;       
   else
      rad_eff(i)=1/sqrt( 1 - (1/alpha)^2 ); 
   end    
   
   if(rad_eff(i)>3.5)
       rad_eff(i)=3.5;
   end
   
   if(rad_eff(i)<rad_min)
       rad_min=rad_eff(i);
       freq_min=f(i);
   end
            
end    

for i=1:NL
   if(f(i)<freq_min)
       if(rad_eff(i)>rad_min)
           rad_eff(i)=rad_min;
       end
   end
end