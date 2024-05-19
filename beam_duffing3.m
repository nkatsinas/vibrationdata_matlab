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
clear fff;
clear p;
clear t;
clear w;
%
disp(' Input file must have two columns time(sec) psi(in) ');
p=input(' Enter input file ');
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
m=rho*A;   % mass/length
%
%%%%%  p(:,2)=p(:,2)*width;
%
%%out1=sprintf('\n Enter time step(sec)   suggest < %8.4g sec ',(1/fn/20));
%%disp(out1);
%%dt=input(' ');
%
%
%%disp(' Enter duration(sec) ');
%%dur=input(' ');
%%dur=10;
%
n=max(size(p));
%
dt=(max(p(:,1))-min(p(:,1)))/(n-1);
%
disp(' ');
disp(' Enter pressure scale factor ');
scale=input(' ');
%
p(:,2)=p(:,2)*scale;
p(:,2)=p(:,2)*width;
%
%% n=round(dur/dt);
%
%%a=C/M;
%%b=K/M;
% 
%%out1=sprintf('\n  a=%8.4g   b=%8.4g \n',a,b);
%%disp(out1);
%
damp=0.05;
%
piL=pi/L;
EI=E*I;
%
omegan=sqrt((EI/m)*piL^4);
fn=omegan/(2*pi);
%
out1=sprintf('\n fn=%8.4g Hz \n',fn);
disp(out1);
%
omegan_low=omegan;
a= 2*damp*omegan;            % damping
b= (EI/m)*(piL)^4;    % stiffness 1
c= ((E/m)*A/4)*(piL)^4; % stiffness 2
d= (1/m);               % force
%%%%%%  
%
xn=d0;
yn=v0;
%
h=dt;
h2=h/2;
%
%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%
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
n=n-1;
tt1=0;
for(i=1:n)
%
    if(omegan<omegan_low)
        omegan=omegan_low;
    end
%
    if(omegan>4*omegan_low)
        omegan=4*omegan_low;
    end
%
    a= 2*damp*omegan;
%    
    t=p(i,1);
%
    p1=p(i,2);
    p2=p(i+1,2);
    pp=(p1+p2)/2;
%
    X1=xn;
    Y1=yn;
    F1=d*p1-a*Y1-b*X1-c*X1^3;  
%
    X2=xn+Y1*h2;
    Y2=yn+F1*h2;
    F2=d*pp-a*Y2-b*X2-c*X2^3;
 %  
    X3=xn+Y2*h2;
    Y3=yn+F2*h2;
    F3=d*pp-a*Y3-b*X3-c*X3^3;
 %  
    X4=xn+Y3*h;
    Y4=yn+F3*h;
    F4=d*p2-a*Y4-b*X4-c*X4^3;
 %
    xn=xn+(Y1+2*Y2+2*Y3+Y4)*h/6;
    yn=yn+(F1+2*F2+2*F3+F4)*h/6;
 %
    ddd(i+1,2)=xn;
 %
    vvv(i+1,2)=yn;
 %
    if(abs(yn)>10000)
        disp(' ');
        out1=sprintf(' fn=%8.4g ',fn);
        disp(out1);
        out1=sprintf(' X1=%8.4g  X2=%8.4g  X3=%8.4g  X4=%8.4g  ',X1,X2,X3,X4);
        disp(out1);
        out1=sprintf(' Y1=%8.4g  Y2=%8.4g  Y3=%8.4g  Y4=%8.4g  ',Y1,Y2,Y3,Y4);
        disp(out1);
        out1=sprintf(' F1=%8.4g  F2=%8.4g  F3=%8.4g  F4=%8.4g  ',F1,F2,F3,F4);
        disp(out1);
        break;
    end
%
%%    if(i>5)
%%        if(ddd(i+1,2)*ddd(i,2)<0)
%%            tt2=t;
%%            fn_old=omegan/(2*pi);
%%            fn=(0.5/(tt2-tt1))*0.8 + 0.2*fn_old;        
%%            omegan=2*pi*fn;
%%           tt1=tt2;
%%        end
%%    end    
%
end
%
ddd(:,1)=p(:,1);
vvv(:,1)=p(:,1);
%
%%%%%%%%%%%%%%%%%%
%
out1=sprintf('  std(ddd) = %8.4g ',std(ddd(:,2)));
out2=sprintf('  std(vvv) = %8.4g ',std(vvv(:,2)));
disp(out1);
disp(out2);
%
 figure(1);
 plot(ddd(:,1),ddd(:,2));
 grid on;
 xlabel('Time(sec)');
 if(iunits==1)
     ylabel('Displacement (inch)');
 else
     ylabel('Displacement (m)');    
 end
 %
 figure(2);
 plot(vvv(:,1),vvv(:,2));
 grid on;
 xlabel('Time(sec)');
 if(iunits==1)
     ylabel('Velocity (inch/sec)');
 else
     ylabel('Velocity (m/sec)');    
 end
 %