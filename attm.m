rho_o=1.225;
To=288.12;
L=6.5;  
Lm=6.5/1000;
RoM=287;
g=9.81;
e=(g/(Lm*RoM))-1;
Tc=217;

h1=11;

T=To-L*h1;
rho_1=rho_o*( T/To )^e;


for i=0:20
    
   h=i;
   
   if(h<=11)

       T=To-L*h;
       rho=rho_o*( T/To )^e;
       
   else
       delta_hm=(h-h1)*1000; 
       rho=rho_1*exp((-g/(RoM*Tc))*delta_hm);       
       
   end    
   
   out1=sprintf('  %d  %8.4g  %8.4g  %8.4g',h,T,To,rho);
   disp(out1);
end