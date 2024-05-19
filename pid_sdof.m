disp(' ')
disp(' pid_sdof.m ')
disp(' ver 1.1  June 2, 2011 ')
disp(' by Tom Irvine  Email: tomirvine@aol.com ')
disp(' ')
disp(' Response of a PID Controller SDOF system to');
disp(' a unit step function. ');
disp(' ');
%
clear t;
clear ref;
clear u;
clear e;
%
tpi=2*pi;
%
mass=input(' Enter mass (kg) ');
%
cv=input(' Enter viscous damping coefficient (N sec/m) ');
%
stiff=input(' Enter stiffness (N/m) ');
%
disp(' ');
%
omegan=input(' Enter natural frequency (rad/sec) ');
%
disp(' ');
%
damp=input(' Enter damping ratio  ');
%
alpha=input(' Enter alpha ');
%
clear kp 
clear ki 
clear kd
clear A
clear B
clear C
clear AA
clear BB
clear X
clear Q
clear R
clear V
clear tt
clear y
%
kp=  (1+2*alpha*damp^2)*omegan^2*mass-stiff;
ki=  alpha*damp*omegan^3*mass;
kd=  (2+alpha)*damp*omegan*mass-cv;
%
A=kd/mass;
B=kp/mass;
C=ki/mass;
%
dom=damp*omegan;
omd=omegan*sqrt(1-damp^2);
om2=omegan^2;
adom=alpha*dom;
%
AA(1,:)=[1 1 1 0];
AA(2,:)=[dom*(2+alpha) 2*dom adom 1];
AA(3,:)=[om2*(1+2*alpha*damp^2)  om2 0 adom];
AA(4,:)=[alpha*damp*omegan^3 0 0 0];
%
BB=[0 A B C]';
%
X = AA\BB;
E=X(1);
Q=X(2);
R=X(3);
V=X(4);
%
disp(' ');
out1=sprintf(' kp=%8.4g N/m       ',kp);
out2=sprintf(' ki=%8.4g N/(m sec) ',ki);
out3=sprintf(' kd=%8.4g N sec/m   ',kd);
%
disp(out1);
disp(out2);
disp(out3);
%
disp(' ');
out1=sprintf(' E=%8.4g ',E);
out2=sprintf(' Q=%8.4g ',Q);
out3=sprintf(' R=%8.4g ',R);
out4=sprintf(' V=%8.4g ',V);
%
disp(out1);
disp(out2);
disp(out3);
disp(out4);
%
fn=omegan/tpi;
period=1/fn;
%
disp(' ');
disp(' Enter sample rate (samples/sec) ')
out1=sprintf(' (suggest > %8.4g )',fn*20);
disp(out1);
sr=input('  ');
dt=1/sr;
%
disp('  ');
disp(' Enter duration (sec) ')
out1=sprintf(' (suggest > %8.4g )',period*40);
disp(out1);
dur=input('  ');
%
nt=2*round(dur*sr/2)+1;
nh=(nt-1)/2;
%
out1=sprintf(' nt=%d  ',nt);
disp(out1);
%
W=((V/R)-dom)/omd^2;
%
u=ones(nt,1);
for(i=1:nt)
    tt(i)=(i-1)*dt;
    t=tt(i);
    omdt=omd*t;
    y(i)=E+Q*exp(-adom*t)+R*exp(-dom*t)*(cos(omdt)+W*sin(omdt));
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
GF= inline('(1/m)*(kd*s^2+kp*s+ki)/(s^3+(1/m)*(c+kd)*s^2+(1/m)*(k+kp)*s+(1/m)*ki)','kp','ki','kd','m','c','k','s');
%
clear G;
clear freq;
%
j=sqrt(-1);
%
fff=omegan/tpi;
df=fff/200;
nk=round(10*fff/df);
%
for(i=1:nk)
    freq(i)=df*(i-1);
    om=tpi*freq(i);
    s=j*om;
%    
    G(i)=GF(kp,ki,kd,mass,cv,stiff,s);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(1);
plot(tt,u,tt,y);
title(' Step Response PID Controller SDOF System ');
ylabel('Displacement(m)');
xlabel('Time(sec)');
legend ('step input','mass response');      
grid on;
%
figure(2);
plot(freq,abs(G));
grid on;
title(' Transfer Magnitude PID Controller SDOF System ');
xlabel('Frequency(Hz)');
ylabel('Response Disp/ Input Disp');