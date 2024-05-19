%
%  vibrationdata_rectangular_pulse_force.m  ver 1.0  by Tom Irvine
%
function[t,accel,velox,dispx,applied_force,trans_force]=...
             vibrationdata_rectangular_pulse_force(amp,dur,fn,mass,stiff,damp,resp_dur,d0,v0)
%

AM=amp/mass;

omegan=2*pi*fn;
omegan2=omegan^2;

%
omegad=omegan*sqrt(1.-damp^2);
domegan=damp*omegan;


%
%  State Space Solution
%
%  find x and v at dur
%

t1=-domegan*dur;
t2=omegad*dur;  

c=(v0+domegan*d0)/omegad;
d=domegan/omegad;  
%
x=exp(t1).*( d0*cos(t2) + c*sin(t2));
v=-domegan*x + omegad*exp(t1).*( -d0*sin(t2) + c*cos(t2));
%
x=x+(1. -exp(t1).*(cos(t2) + d*sin(t2)) )/stiff;
v=v+domegan*exp(t1).*(cos(t2)  + d*sin(t2))/stiff;
v=v- omegad*exp(t1).*(-sin(t2) + d*cos(t2))/stiff;

xdur=x;
vdur=v;

%

period=1/fn;
dt=min( [ (period/64)  (dur/12)]);
%%% dur=max([ (15*period) 2*dur ]);

N=ceil(resp_dur/dt);
%
t=linspace(0,resp_dur,N);
t=t';

%    
c=(v0+domegan*d0)/omegad;
d=domegan/omegad; 

R=( vdur + (domegan*xdur))/omegad;


dispx=zeros(N,1);
velox=zeros(N,1);
accel=zeros(N,1);
applied_force=zeros(N,1);


for i=1:N
    
    if(t(i)<dur)
        
        t1=-domegan*t(i);
        t2=omegad*t(i);  
 
%
        x=exp(t1).*( d0*cos(t2) + c*sin(t2));
        v=-domegan*x + omegad*exp(t1).*( -d0*sin(t2) + c*cos(t2));
%
        x=x+(1. -exp(t1).*(cos(t2) + d*sin(t2)) )/stiff;
        v=v+domegan*exp(t1).*(cos(t2)  + d*sin(t2))/stiff;
        v=v- omegad*exp(t1).*(-sin(t2) + d*cos(t2))/stiff;   
        
        a= AM-omegan2*x-2*domegan*v;
        applied_force(i)=amp;
        
    else

        tt=t(i)-dur;
   
        eee=exp(-domegan*tt);
   
        cwdt=cos(omegad*tt);
        swdt=sin(omegad*tt);
   
        x= eee*(xdur*cwdt+R*swdt);
        v= -domegan*x+omegad*eee*(-xdur*swdt+R*cwdt);
        a= -omegan2*x-2*domegan*v;        
        
    end
    
    dispx(i)=x;
    velox(i)=v;
    accel(i)=a;
    
end

c=2*damp*omegan*mass;

trans_force=stiff*dispx + c*velox;
