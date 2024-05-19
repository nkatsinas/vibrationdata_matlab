%
disp(' ');
disp(' RK4_fv.m   ver 1.0  September 21, 2010 ');
disp(' by Tom Irvine ');
disp(' ');
disp(' Runge-Kutta  Fourth-order Method ');
disp(' Free Vibration of an SDOF System subjected to initial conditions. ');
disp(' ');
%
clear ddd;
clear vvv;
clear aaa;
%
%% disp(' select units')
%% iunits=input(' 1=English  2=metric ');
%
iunits=1;
%
v0=0;
d0=0;
%
L=12;
rho=0.1/386;
thick=0.125;
width=4;

[A,I,~]=beam_rectangular_geometry(width,thick); 

E=1.0e+07;
fn=77.34;
damp=0.05;
%
rho=rho*A;
%
%%out1=sprintf('\n Enter time step(sec)   suggest < %8.4g sec ',(1/fn/20));
%%disp(out1);
%%dt=input(' ');
dt=1/2000;
%
%%disp(' Enter duration(sec) ');
%%dur=input(' ');
dur=10;
%
n=round(dur/dt);
%
%%a=C/M;
%%b=K/M;
%
%%out1=sprintf('\n  a=%8.4g   b=%8.4g \n',a,b);
%%disp(out1);
%
T=1/fn;
a= 4*pi*damp/T;            % damping
b= (E/rho)*I*(pi/L)^4;    % stiffness 1
c= ((E/rho)*A/4)*(pi/L)^4 % stiffness 2
d= (1/rho);               % force
%
xn=d0;
yn=v0;
%
h=dt;
h2=h/2;
%
ddd(1,1)=0;
ddd(1,2)=d0;
%
vvv(1,1)=0;
vvv(1,2)=0;
%
aaa(1,1)=0;
aaa(1,2)=0;
%
for(i=0:n)
    t=(i+1)*dt;
%
    X1=xn;
    Y1=yn;
    F1=-a*Y1-b*X1;   
%
    X2=xn+Y1*h2;
    Y2=yn+F1*h2;
    F2=-a*Y2-b*X2;
 %  
    X3=xn+Y2*h2;
    Y3=yn+F2*h2;
    F3=-a*Y3-b*X3;
 %  
    X4=xn+Y3*h;
    Y4=yn+F3*h;
    F4=-a*Y4-b*X4;
 %  
    xn=xn+(Y1+2*Y2+2*Y3+Y4)*h/6;
    yn=yn+(F1+2*F2+2*F3+F4)*h/6;
 %
    ddd(i+2,1)=t;
    ddd(i+2,2)=xn;
end
%
plot(ddd(:,1),ddd(:,2));
grid on;
xlabel('Time(sec)');
if(iunits==1)
    ylabel('Displacement (inch)');
else
    ylabel('Displacement (m)');    
end