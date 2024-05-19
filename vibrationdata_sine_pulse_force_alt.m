%
%  vibrationdata_sine_pulse_force_alt.m  ver 1.0  by Tom Irvine
%

function[t,accel,velox,dispx,applied_force,trans_force]=...
             vibrationdata_sine_pulse_force_alt(amp,t,fn,damp,f,d0,v0)
%

mass=1;
stiff=1;

F=amp;

N=length(t);
%

beta=2*pi*f;
beta2=beta^2;

omegan=2*pi*fn;
omegan2=omegan^2;
omegad=omegan*sqrt(1.-damp^2);
domegan=damp*omegan;
dterm=(1-2*damp^2);
%
dF=(beta2-omegan2)^2+(2*beta*domegan)^2;
FdF=F/dF;
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
%

dispx=zeros(N,1);
velox=zeros(N,1);
accel=zeros(N,1);
applied_force=zeros(N,1);


for i=1:N
        
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
        
        applied_force(i)=amp*sin(2*pi*f*t(i));
        
        a= (applied_force(i)/mass)-omegan2*x-2*domegan*v;        
             
        dispx(i)=x;
        velox(i)=v;
        accel(i)=a;
    
end



c=2*domegan;

trans_force=stiff*dispx + c*velox;

% stiff
% c
