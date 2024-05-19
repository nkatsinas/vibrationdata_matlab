%
%   cylinder_mobility.m  ver 1.0  by Tom Irvine
%
function[fr,CL,Y,Z]=cylinder_mobility(em,rho,d,L,h,fc)

   tpi=2*pi;

   NL=length(fc);

   E=em;

   [fr,CL]=ring_frequency_I(E,rho,d);
   
   R=d/2.;
   
   fl=(0.375/L)*sqrt(E*h/(rho*R));
   
   Y=zeros(NL,1);
   Z=zeros(NL,1);
   
   Zlow= 2.5*E*h*sqrt(R/L)*(h/R)^1.25;
   Zmid=(4/sqrt(3))*rho*h^2*sqrt(E/(rho*R))*(E/rho)^(1/4);
   Zhigh=(4/sqrt(3))*h^2*sqrt(E*rho);
   
   for i=1:NL
       
      f=fc(i);
      omega=tpi*f;
      
      fff=0.7*fl;

      if(f<=fff)
         Z(i)=Zlow/omega;
      end
 
      if(fff<f && f<=fl)
          
          Z1=Zlow/(tpi*fff);
          Z2=Zmid/sqrt(tpi*fr);
          
          s=log(Z2/Z1)/log( fr/(fff));
          
          Z(i)=Z1*(f/(0.8*fl))^s;
          
      end
      
      if(fl<f && f<=fr)
         Z(i)=Zmid/sqrt(omega);  
      end
    
      if(f>fr)
         Z(i)=Zhigh;
      end   
      
      Y(i)=1/Z(i);    
   
   end