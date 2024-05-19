clear f;
clear r;


%fring=     1122; 
% fcr=4827; 

% R=27.87;
% a=20;
% h=0.1;

fring=1600;
fcr=4000;
R=18;
a=24;
h=0.125;


mu=0.3;

% equation (15)

f(1)=fring*1.1;
i=2;

 while(1)

   f(i)=f(i-1)+10;

   vo=f(i)/fring;

   Ra2=R*a^2;
   A=sqrt(h/Ra2);

   ee=sqrt(vo*fring/fcr);

   B=log((1+ee)/(1-ee));

   C=2*ee/(1-vo*fring/fcr);

   num=A*(B+C);
   
   D1=(12*(1-mu^2)*(vo^2-1))^(1/4);
   D2=pi*(1-vo*fring/fcr)^1/2;
   den=D1*D2;

   r(i)=num/den;
   
   if(f(i)>0.9*fcr)
        break;
   end

   i=i+1;
 end

 r(1)=r(2);

fig_num=1;
t_string='Radiation Efficiency';
x_label='Frequency (Hz)'; 
fmin=1000;
fmax=10000;
f=fix_size(f);
r=fix_size(r);
ppp=[f r];

 [fig_num,h2]=plot_loglog_function_h2_rad_eff(fig_num,x_label,t_string,ppp,fmin,fmax);