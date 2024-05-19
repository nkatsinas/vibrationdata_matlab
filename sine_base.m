disp(' ')
disp(' sine_base.m  version 1.0    January 12, 2012 ')
disp(' By Tom Irvine   Email:  tomirvine@aol.com ')
disp(' ')
disp(' This program calculates the response of')
disp(' a single-degree-of-freedom system subjected')
disp(' to a sinusoidal base input.')
disp(' ')
disp(' Assume zero initial displacement and zero initial velocity.')
%
clear fn;
%
clear acc;
clear rv;
clear rd;
clear t;
%
tpi=2.*pi;
onetwelfth=1/12;
%
disp(' ');
amp = input('  Enter the base amplitude (G) ');
%
fbase = input('  Enter the base frequency (Hz) ');
%
disp(' ');
%
fn = input('  Enter the natural frequency (Hz) '); 
%
Q = input('  Enter amplification factor Q ');
damp=1./(2.*Q);
%
sr=32*max([ fbase fn ]);
dt=1/sr;
%
disp(' ');
dur=input('  Enter duration (sec) ');
%
nt=ceil(dur/dt);
%
t=linspace(0,dur,nt);
t=t';
%
rd=zeros(nt,1);
rd1=zeros(nt,1);
rd2=zeros(nt,1);
rd3=zeros(nt,1);
%
rv=zeros(nt,1);
acc=zeros(nt,1);
%
%%%%%
omega = 2.*pi*fbase;
omega2= (omega^2.);
omegan=tpi*fn;
omegad = omegan*sqrt(1.- (damp^2.));
%
rd_initial = 0.;
rv_initial = 0.;
%
omegan2=omegan^2.;
omegad2=omegad^2.;
%
domegan=damp*omegan;
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
%  Relative Displacement
%
rd1=ee.*(a1*cwdt + a2*swdt);
rd2=(amp/den)*(b1*cat  + b2*sat );
rd3=-((amp/den)*omega/omegad)*(ee.*(c1*cwdt + c2*swdt));
%				
rd=rd1+rd2+rd3;
%
%  Relative Velocity
%
rv1=-domegan*rd1;
rv1=rv1+omegad*(ee.*(-a1*swdt + a2*cwdt));
%
rv2=omega*(amp/den)*(-b1*sat  + b2*cat );				
%
rv3=-domegan*rd3;
rv3=rv3-((amp/den)*omega)*(ee.*(-c1*swdt + c2*cwdt));
%
rv=rv1+rv2+rv3;
%				
%  Absolute Acceleration
%
acc= -omegan2*rd  - 2.*domegan*rv;
rd=rd*386;
%
out1 = sprintf('\n\n maximum acceleration = %12.4g G',max(acc));
out2 = sprintf(' minimum acceleration = %12.4g G',min(acc));       
disp(out1);
disp(out2);
%
out1 = sprintf('\n\n maximum relative disp = %12.4g inch',max(rd));
out2 = sprintf(' minimum relative disp = %12.4g inch ',min(rd));
disp(out1);
disp(out2);
%
figure(1);
plot(t,acc,t,ain);
title('Acceleration');
xlabel('Time (sec)');  
ylabel('Accel (G)');    
legend('response','input');  
grid;
%            
figure(2);
plot(t,rd);
title('Relative Displacement');
xlabel('Time (sec)');  
ylabel('Rel Disp (in)');      
grid;
%
clear acceleration;
clear rel_disp;
%
acceleration=[t acc ain];
rel_disp=[t rd];