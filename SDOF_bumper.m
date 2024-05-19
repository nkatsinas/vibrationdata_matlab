disp(' ')
disp(' SDOF_bumper.m ')
disp(' ver 1.1   November 30, 2011 ')
disp(' by Tom Irvine  Email: tomirvine@aol.com ')
disp(' ')
disp(' This program calculates the free vibration of a  ')
disp(' single-degree-of-freedom system. ')
disp(' ')
%
clear fn;
clear damp;
clear N;
clear t;
clear xm;
clear xb;
clear vm;
clear vb;
%
disp(' select units')
iunits=input(' 1=English  2=metric ');
disp(' ');
%
if(iunits==1)
    gap=input(' enter gap when each system is at rest (in) ');
    disp(' ')
    m=input(' enter mass (lbm) ');
    m=m/386;
    disp(' ')
    c1=input(' enter damping coefficient 1 (lbf sec/in) ');
    k1=input(' enter stiffness 1 (lbf/in) ');
    disp(' ')
    c2=input(' enter damping coefficient 2 (lbf sec/in) ');
    k2=input(' enter stiffness 2 (lbf/in) ');
    disp(' ')
    vm0 = input(' enter mass initial velocity (in/sec) ');
    disp(' ')
    dm0 = input(' enter mass initial displacement (in) ');
else
    z0=input(' gap when each system is at rest (m)');
    disp(' ')
    m=input(' mass (kg) ');
    disp(' ')
    c1=input(' damping coefficient 1 (N sec/m) ');
    k1=input(' stiffness 1 (lbf/in) ');
    disp(' ')
    c2=input(' damping coefficient 2 (N sec/m) ');
    k2=input(' stiffness 2 (lbf/in) ');
    disp(' ')
    vm0 = input(' enter mass initial velocity (m/sec) ');
    disp(' ')
    dm0 = input(' enter mass initial displacement (m) ');  
end
%
db0=0;
if(dm0>z0)
    xb0=dm0-gap;
end    
%
%   State Space Solution
%
kt=k1+k2;
ct=c1+c2;
argb=k2/c2;
%
alpha_f=sqrt(4*k1*m-c1^2)/(2*m);
 beta_f=c1/(2*m);
%
alpha_c=sqrt(4*kt*m-ct^2)/(2*m);
 beta_c=ct/(2*m);
%
den_f=sqrt(4*k1*m-c1^2);
den_c=sqrt(4*kt*m-ct^2);
%
fn_free=(sqrt(k1/m))/(2*pi);
fn_contact=(sqrt(kt/m))/(2*pi);
period_contact=1/fn_contact;
dt=period_contact/400;
sr=1/dt;
dur=12/fn_free;
N=round(dur/dt);
%
t=linspace(0,dur,N);
t=t';
%
xm=zeros(N,1);
vm=zeros(N,1);
%
xb=zeros(N,1);
vb=zeros(N,1);
%
delay=0;
%
iflag=0;
for(i=2:N)
    z=xb(i-1)-xm(i-1)+gap;
%
    tt=t(i)-delay;
    if(xm(i-1)<gap)  % Free 
       arg=alpha_f*tt;
       darg=alpha_f;
       A=dm0;
       B=(2*m*vm0+c1*dm0)/den_f;
       xm(i)=exp(-beta_f*tt)*(A*cos(arg)+B*sin(arg));
       vm(i)=-beta_f*xm(i)+darg*exp(-beta_f*tt)*(-A*sin(arg)+B*cos(arg));
       xb(i)=db0*exp(-argb*tt);
%%%%       vb(i)=-argb*db0*exp(-argb*tt);  % do not need
%
       if( xm(i)>gap)  %  Contact
%
%        find contact time via secant method
%
         t1=t(i-1);
         t2=t(i);
         x1=xm(i-1);
         x2=xm(i);
%         
         for(j=1:10)
            slope=(xm(i)-xm(i-1))/(t(i)-t(i-1));
            b=xm(i-1)-slope*t(i-1); 
            t3=(gap-b)/slope;
%
            tt=t3-delay;
            arg=alpha_f*tt;
            darg=alpha_f;
            A=dm0;
            B=(2*m*vm0+c1*dm0)/den_f;
            x3=exp(-beta_f*tt)*(A*cos(arg)+B*sin(arg));
%
            if((x1*x3)<0)
                t2=t3;
                x2=x3;
            else
                t1=t3;
                x1=x3;
            end
         end
%        
         t(i)=t3;
         tt=t(i)-delay;
         xm(i)=gap;
         tt=0;
         dt=t(i)-t(i-1);
         if(dt>0)
            vm(i)=(xm(i)-xm(i-1))/dt;
         else
            vm(i)=vm(i-1); 
         end
%
         xb(i)=0;
%         
         dm0=gap;
         vm0=vm(i);
         db0=0;         
         delay=t(i);
%
       end    
%
%
    else   % contact for xm(i)>=gap
       arg=alpha_c*tt;
       darg=alpha_c;   
       A=dm0;
       B=(2*m*vm0+c1*dm0)/den_c;      
       xm(i)=exp(-beta_c*tt)*(A*cos(arg)+B*sin(arg));
       vm(i)=-beta_c*xm(i)+darg*exp(-beta_c*tt)*(-A*sin(arg)+B*cos(arg));      
       xb(i)=xm(i)-gap;
       vb(i)=vm(i);
       if(xb(i)<0)
           xb(i)=0;
       end    
%
       if( xm(i)<gap) % release
%
%        find release time via secant method
%                     
         t1=t(i-1);
         t2=t(i);
         x1=xm(i-1);
         x2=xm(i);
%         
         for(j=1:10)
            slope=(xm(i)-xm(i-1))/(t(i)-t(i-1));
            b=xm(i-1)-slope*t(i-1); 
            t3=(gap-b)/slope;
%
            tt=t3-delay;
            arg=alpha_c*tt;
            darg=alpha_c;
            A=dm0;
            B=(2*m*vm0+ct*dm0)/den_c;
            x3=exp(-beta_c*tt)*(A*cos(arg)+B*sin(arg));
%
            if((x1*x3)<0)
                t2=t3;
                x2=x3;
            else
                t1=t3;
                x1=x3;
            end
         end
%        
         t(i)=t3;
         tt=t(i)-delay;
         xm(i)=gap*0.999999;
         tt=0;
         dt=t(i)-t(i-1);
         if(dt>0)
            vm(i)=(xm(i)-xm(i-1))/dt;
         else
            vm(i)=vm(i-1); 
         end
         xb(i)=0;
         vb(i)=0;
%
         dm0=gap;
         vm0=vm(i);
         db0=0;         
         delay=t(i);
       end
%
    end 
%
    z=xb(i)-xm(i)+gap; 
    if(xm(i)>(100*gap) || xb(i)>(100*gap))
        disp(' Error ');
        ggg=input(' press ctrl-c ');
    end
%
end
%
figure(1);
plot(t,vm);
title('Velocity');
xlabel('Time(sec)');
if(iunits==1)
    ylabel('Vel(in/sec)');
else
    ylabel('Vel(m/sec)');    
end
legend ('Mass');   
grid on;
%
figure(2);
plot(t,xm,t,xb);
title('Displacement');
xlabel('Time(sec)');
if(iunits==1)
    ylabel('Disp(in)');
else
    ylabel('Disp(m)');    
end
legend ('Mass','Bumper');   
grid on;
%
disp(' ');
disp(' ');
disp(' Note: output time step is not constant if contact occurred ');