
% versed_time_calc.m  ver 1.1  by Tom Irvine

function[amax,amin,acc,rd,rv,TT,yb,ain]=...
    versed_time_calc(rd_initial,rv_initial,domegan,omegad,damp,omega,omegan,omega2,omegan2,nt,dt,dur,amp,amax,amin);
%
clear acc;
clear rd;
%
nt=round(nt);
%
a1=rd_initial;
a2=(rv_initial+domegan*rd_initial)/omegad;
%
domegan=damp*omegan;
den=((omega2-omegan2)^2.)+((2.*damp*omega*omegan)^2.);
%
K1=omega^2-omegan^2;
K2=-2*domegan*omega;
K3=-K1;
K4=domegan*(omega^2+omegan^2)/omegad;
%
K1=-K1;
K2=-K2;
K3=-K3;
K4=-K4;
%
K5=1/omegan^2;
K6=(domegan/omegad);
%
%****************************************************
    t=dur;
				omegat=omega*t;
				omegadt=omegad*t;
				omegant=omegan*t;
				domegant=domegan*t;
%                
      			ee=exp(-domegant);
				cwdt=cos(omegadt);
				swdt=sin(omegadt);
%
				cat = cos(omegat);
				sat = sin(omegat);
%
				rd1=    (K1*cat  + K2*sat)/den;
				rd2= ee*(K3*cwdt + K4*swdt)/den;
				rd3= K5*(-1 + ee*(cwdt + K6*swdt));
%
                zT=(rd1+rd2+rd3)*amp/2.;
%
   				rv1=       omega*(-K1*sat  + K2*cat)/den;
				rv2= -domegan*ee*(K3*cwdt + K4*swdt)/den;
				rv3=   omegad*ee*(-K3*swdt + K4*cwdt)/den;
                rv4= -domegan*K5*(ee*(cwdt + K6*swdt));
                rv5=   omegad*K5*(ee*(-swdt + K6*cwdt));
				vT=(rv1+rv2+rv3+rv4+rv5)*amp/2;
%                
%****************************************************
%
for(i=0:nt)
%		
	t=dt*i;
    TT(i+1)=t;
%
			if(t <= dur)
%
				omegat=omega*t;
				omegadt=omegad*t;
				omegant=omegan*t;
				domegant=domegan*t;
%
				ee=exp(-domegant);
				cwdt=cos(omegadt);
				swdt=sin(omegadt);
%
				cat = cos(omegat);
				sat = sin(omegat);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
				rd1=    (K1*cat  + K2*sat)/den;
				rd2= ee*(K3*cwdt + K4*swdt)/den;
				rd3= K5*(-1 + ee*(cwdt + K6*swdt));
%				
				rd(i+1)=(rd1+rd2+rd3)*amp/2;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
   				rv1=       omega*(-K1*sat  + K2*cat)/den;
				rv2= -domegan*ee*(K3*cwdt + K4*swdt)/den;
				rv3=   omegad*ee*(-K3*swdt + K4*cwdt)/den;
                rv4= -domegan*K5*(ee*(cwdt + K6*swdt));
                rv5=   omegad*K5*(ee*(-swdt + K6*cwdt));
%				
                rv(i+1)=(rv1+rv2+rv3+rv4+rv5)*amp/2;
%
                ain(i+1)=(amp/2)*(1-cos(omega*t));
%
			else
%
				ain(i+1)=0.;
%
				omegat=omega*(t-dur);
				omegadt=omegad*(t-dur);
				omegant=omegan*(t-dur);
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
            if(acc(i+1)>amax)
                amax=acc(i+1);
            end    
            if(acc(i+1)<amin)
                amin=acc(i+1);
            end 
end          