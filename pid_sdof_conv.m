disp(' ')
disp(' pid_sdof_conv.m ')
disp(' ver 1.3  June 4, 2011 ')
disp(' by Tom Irvine  Email: tomirvine@aol.com ')
disp(' ')
disp(' Response of a PID Controller SDOF system to a unit step function');
disp(' via a convolution integral. ');
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
AA=[1 1 0; 2*dom adom 1; om2 0 adom];
%
BB=[A B C]';
%
X = AA\BB;
R=X(1);
W=X(2);
V=X(3);
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
out1=sprintf(' R=%8.4g ',R);
out2=sprintf(' W=%8.4g ',W);
out3=sprintf(' V=%8.4g ',V);
%
disp(out1);
disp(out2);
disp(out3);
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
Z=((V/W)-dom)/omd;
%
clear g;
u=ones(nt,1);
u(1)=0;
for(i=1:nt)
    tt(i)=(i-1)*dt;
    t=tt(i);
    omdt=omd*t;
    g(i)=R*exp(-adom*t)+W*exp(-dom*t)*(cos(omdt)+Z*sin(omdt));
end
g=g';
%
clear y;
y=zeros(2*nt,1);
%%%% y = conv(u,g);
%
for(i=1:nt)
		for(k=1:nt)
			y(i+k)=y(i+k)+u(i)*g(k);
        end
end    
y=y*dt;
%
clear length;
nnn=length(u);
%
yy=y(1:nnn);
clear y;
y=yy;
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