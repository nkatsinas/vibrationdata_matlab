
%  time_calc.m  ver 1.1  by Tom Irvine

function[amax,amin,acc,rd,TT,yb]=...
       time_calc(rd_initial,rv_initial,domegan,omegad,damp,omega,omegan,...
                                    omega2,omegan2,nt,dt,dur,amp,amax,amin)
%
clear acc;
clear rd;
%
nt=round(nt);
%
a1=rd_initial;
a2=(rv_initial+domegan*rd_initial)/omegad;
%
b1=2.*damp*omega*omegan;
b2=(omega2-omegan2);
%
c1=2.*domegan*omegad;
c2=omega2-omegan2*(1.-2*(damp^2.));
%
den=((omega2-omegan2)^2.)+((2.*damp*omega*omegan)^2.);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
t=dur;
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
				ain= amp*sin(omegat);
%				
				rd1=ee         *(a1*cwdt + a2*swdt);
				rd2=(amp/den)  *(b1*cat  + b2*sat );
				rd3=-((amp/den)*ee*omega/omegad)*(c1*cwdt + c2*swdt);
%				
				rdT=rd1+rd2+rd3;
%
				rv1=-domegan*rd1;
                rv1=rv1+omegad*ee*(-a1*swdt + a2*cwdt);
%
				rv2=omega*(amp/den)  *(-b1*sat  + b2*cat );				
%
				rv3=-domegan*rd3;
                rv3=rv3-((amp/den)*ee*omega)*(-c1*swdt + c2*cwdt);
%
				rvT=rv1+rv2+rv3;
%
				zT=rdT;
				vT=rvT;
%                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

TT=zeros(nt+1,1);
yb=zeros(nt+1,1);
rd=zeros(nt+1,1);
acc=zeros(nt+1,1);



for i=0:nt
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
				ain= amp*sin(omegat);
%				
				rd1=ee         *(a1*cwdt + a2*swdt);
				rd2=(amp/den)  *(b1*cat  + b2*sat );
				rd3=-((amp/den)*ee*omega/omegad)*(c1*cwdt + c2*swdt);
                
%				
				rd(i+1)=rd1+rd2+rd3;
%
				rv1=-domegan*rd1;
                rv1=rv1+omegad*ee*(-a1*swdt + a2*cwdt);
%
				rv2=omega*(amp/den)  *(-b1*sat  + b2*cat );				
%
				rv3=-domegan*rd3;
                rv3=rv3-((amp/den)*ee*omega)*(-c1*swdt + c2*cwdt);
%
				rv=rv1+rv2+rv3;
%
			else
%
				ain=0.;
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
				rv= -domegan*rd(i+1);
				rv=rv+ omegad*ee *(-a1*swdt + a2*cwdt);
%
            end
            yb(i+1)=ain;
%
			acc(i+1)= -omegan2*rd(i+1)  - 2.*domegan*rv;
%
end       

amax=max(acc);
amin=min(acc);