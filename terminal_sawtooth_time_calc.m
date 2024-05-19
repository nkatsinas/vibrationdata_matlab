%
%   terminal_sawtooth_time_calc.m  ver 1.0  by Tom Irvine
%
function[rdmax,rdmin,amax,amin,acc,rd,rv,TT,yb,ain]=...
    terminal_sawtooth_time_calc(rd_initial,rv_initial,domegan,omegad,...
     damp,omega,omegan,omega2,omegan2,nt,dt,dur,amp,amax,amin,rdmax,rdmin)
%
clear acc;
clear rd;
clear rv;
clear ain;
clear yb;
%
b1=2*damp/omegan;
b2=(2*(damp^2)-1)/omegad;
%
t=dur;
%
omegadt=omegad*t;
ee=exp(-domegan*t);
cwdt=cos(omegadt);
swdt=sin(omegadt);
%
zT=b1-t-ee*(b1*cwdt + b2*swdt);
zT=zT*amp/(omegan2*dur);
%
vT=-1+domegan*ee*(b1*cwdt + b2*swdt);
vT=vT-omegad*ee*(-b1*swdt + b2*cwdt);
vT=vT*amp/(omegan2*dur);
%
for(i=0:nt)
%		
	t=dt*i;
    TT(i+1)=t;
%
			if(t <= dur)
%
                omegadt=omegad*t;
                ee=exp(-domegan*t);
                cwdt=cos(omegadt);
                swdt=sin(omegadt);
%
                rd(i+1)=b1-t-ee*(b1*cwdt + b2*swdt);
                rd(i+1)=rd(i+1)*amp/(omegan2*dur);
%
                rv(i+1)=-1+domegan*ee*(b1*cwdt + b2*swdt);
                rv(i+1)=rv(i+1)-omegad*ee*(-b1*swdt + b2*cwdt);
                rv(i+1)=rv(i+1)*amp/(omegan2*dur);
%
				ain(i+1)= amp*t/dur;
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
				rv(i+1)=rv(i+1)+ omegad*ee *(-a1*swdt + a2*cwdt);
%
            end
%
			acc(i+1)= -omegan2*rd(i+1)  - 2.*domegan*rv(i+1);
%
            if(acc(i+1)>amax)
                amax=acc(i+1);
            end    
            if(acc(i+1)<amin)
                amin=acc(i+1);
            end 
%
            if(rd(i+1)>rdmax)
                rdmax=rd(i+1);
            end    
            if(rd(i+1)<rdmin)
                rdmin=rd(i+1);
            end 
%
end          
yb=ain;