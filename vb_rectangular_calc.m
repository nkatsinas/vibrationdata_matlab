%
%   vb_rectangular_calc.m  ver 1.0
%
function[acc,rd,rv,TT,yb]=vb_rectangular_calc(domegan,omegad,damp,...
                                        omega,omegan,omegan2,nt,dt,dur,amp)
%
clear acc;
clear rd;
%
%****************************************************
t=dur;
				omegadt=omegad*t;
				domegant=domegan*t;
%                
      			ee=exp(-domegant);
				cwdt=cos(omegadt);
				swdt=sin(omegadt);
%
                K1=omegan^2;
                K2=domegan/omegad;
%
				zT=amp*(-1+ee*(cwdt+K2*swdt))/K1;
%
   				rv1= -domegan*ee*(cwdt+K2*swdt)/K1;
				rv2=   omegad*ee*(-swdt+K2*cwdt)/K1;
%
				vT=(rv1+rv2)*amp;
%                
%****************************************************
%
TT=zeros(nt+1,1);
rd=zeros(nt+1,1);
rv=zeros(nt+1,1);
ain=zeros(nt+1,1);
yb=zeros(nt+1,1);
acc=zeros(nt+1,1);
%
for i=0:nt
%		
	t=dt*i;
    TT(i+1)=t;
%
			if(t <= dur)
%
				omegadt=omegad*t;
				domegant=domegan*t;
%
				ee=exp(-domegant);
				cwdt=cos(omegadt);
				swdt=sin(omegadt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%				
				rd(i+1)=amp*(-1+ee*(cwdt+K2*swdt))/K1;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
   				rv1= -domegan*ee*(cwdt+K2*swdt)/K1;
				rv2=   omegad*ee*(-swdt+K2*cwdt)/K1;
%				
                rv(i+1)=(rv1+rv2)*amp;
%
                ain(i+1)=amp;
%
			else
%
				ain(i+1)=0.;
%
				omegadt=omegad*(t-dur);
				domegant=domegan*(t-dur);
%
				ee=exp(-domegant);
				cwdt=cos(omegadt);
				swdt=sin(omegadt);
%
				a1=zT;
				a2=(vT+domegan*zT)/omegad;
%
                rd(i+1) = ee *(a1*cwdt + a2*swdt);
%
				rv(i+1)= -domegan*rd(i+1);
				rv(i+1)= rv(i+1) + omegad*ee *(-a1*swdt + a2*cwdt);
%
            end
            yb(i+1)=ain(i+1);
%
			acc(i+1)= -omegan2*rd(i+1)  - 2.*domegan*rv(i+1);
%
end   
yb=ain;