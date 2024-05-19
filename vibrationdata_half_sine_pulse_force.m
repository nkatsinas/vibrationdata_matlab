%
%  vibrationdata_half_sine_pulse_force.m  ver 1.0  by Tom Irvine
%
function[t,accel,velox,dispx,applied_force,trans_force]=...
             vibrationdata_half_sine_pulse_force(amp,dur,fn,mass,stiff,damp,resp_dur,d0,v0)
%

F=amp;

period=1/fn;
dt=min( [ (period/64)  (dur/12)]);
%%% dur=max([ (15*period) 2*dur ]);

N=ceil(resp_dur/dt);
%
t=linspace(0,resp_dur,N);
t=t';

%
T=dur;

beta=pi/T;
beta2=beta^2;

omegan=2*pi*fn;
omegan2=omegan^2;
omegad=omegan*sqrt(1.-damp^2);
domegan=damp*omegan;
dterm=(1-2*damp^2);
%
dF=(beta2-omegan2)^2+(2*beta*domegan)^2;
FdF=(F/mass)/dF;
%
%
U1=2*beta*domegan;
V1=(beta2-omegan2);
%
U2=(2*domegan*omegad);
V2=(beta2-omegan2*dterm);
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

W=(v0+domegan*d0)/omegad;
%
tt=T;
        eee=exp(-domegan*tt); 
        cosbt=cos(beta*tt);  
        sinbt=sin(beta*tt);  
        cosd=cos(omegad*tt);
        sind=sin(omegad*tt);
%
        deee=-domegan*eee;
        dcosbt=-beta*sinbt;  
        dsinbt= beta*cosbt;          
        dcosd=-omegad*sind;
        dsind= omegad*cosd;
%
        d1 =eee*(d0*cosd + W*sind);
        d2 =FdF*(U1*cosbt +V1*sinbt);  
        d3 =FdF*(beta*eee/omegad)*( U2*cosd+ V2*sind);    
%
        dT=d1-d2+d3;
%
        v1=deee*(d0*cosd + W*sind) + eee*(d0*dcosd + W*dsind);
        v2=FdF*(U1*dcosbt + V1*dsinbt);
        v3a=FdF*(beta*deee/omegad)*( U2*cosd+ V2*sind);
        v3b=FdF*(beta*eee/omegad)*( U2*dcosd+ V2*dsind); 
%
        vT=v1-v2+v3a+v3b;
%

R=( vT + (domegan*dT))/omegad;


dispx=zeros(N,1);
velox=zeros(N,1);
accel=zeros(N,1);
applied_force=zeros(N,1);


for i=1:N
    
    if(t(i)<dur)
        
        tt=t(i);
        
        eee=exp(-domegan*tt); 
        cosbt=cos(beta*tt);  
        sinbt=sin(beta*tt);  
        cosd=cos(omegad*tt);
        sind=sin(omegad*tt);
%
        deee=-domegan*eee;
        dcosbt=-beta*sinbt;  
        dsinbt= beta*cosbt;  
        dcosd=-omegad*sind;
        dsind= omegad*cosd;
%
        d1 =eee*(d0*cosd + W*sind);
        d2 =FdF*(U1*cosbt +V1*sinbt);  
        d3 =FdF*(beta*eee/omegad)*( U2*cosd+ V2*sind);    
%
        x=d1-d2+d3;
%
        v1=deee*(d0*cosd + W*sind) + eee*(d0*dcosd + W*dsind);
        v2=FdF*(U1*dcosbt + V1*dsinbt);
        v3a=FdF*(beta*deee/omegad)*( U2*cosd+ V2*sind);
        v3b=FdF*(beta*eee/omegad)*( U2*dcosd+ V2*dsind); 
%
        v=v1-v2+v3a+v3b;         
        
        applied_force(i)=amp*sin(pi*t(i)/dur);
        
        a= (applied_force(i)/mass)-omegan2*x-2*domegan*v;        
        
    else

        tt=t(i)-dur;
   
        eee=exp(-domegan*tt);
   
        cwdt=cos(omegad*tt);
        swdt=sin(omegad*tt);
   
        x= eee*(dT*cwdt+R*swdt);
        v= -domegan*x+omegad*eee*(-dT*swdt+R*cwdt);
        a= -omegan2*x-2*domegan*v;        
        
    end
    
    dispx(i)=x;
    velox(i)=v;
    accel(i)=a;
    
end

c=2*domegan*mass;

trans_force=stiff*dispx + c*velox;

% stiff
% c
