%
disp(' twodof_sine_force.m   ver 1.4  January 17, 2012');
disp(' by Tom Irvine  Email: tomirvine@aol.com ');
disp(' ');
%
disp(' This script calculates the response of a two-degree-of-freedom ');
disp(' system to sinusoidal force excitation. ');
disp(' ');
%
close all;
%
clear m;
clear mass;
clear k;
clear stiff;
clear damp;
%
clear PF;
%
clear ra;
clear rv;
clear rd;
%
clear fn;
clear omega;
clear ModeShapes;
clear MST;
%
clear omegan;
clear domegan;
clear omegan2;
clear omegan3;
%
clear omegad;
clear domegan;
clear omdT;
clear expdt;
%
clear alpha;
clear alpha2;
%
clear C1;
clear C2;
clear C3;
clear C4;
%
clear C5;
clear C6;
clear C7;
clear C8;
%
clear C10;
clear C11;
%
clear C20;
%
clear rd1;
clear rd2;
clear rd3;
clear rdT;
%
clear rv1;
clear rv2;
clear rv3;
clear rvT;
%
clear ra;
clear rv;
clear rd;
clear disp_rel;
clear accel_rel;
clear ax;
%
clear base;
clear A;
clear B;
clear BB;
clear PF;
clear t;
clear tt;
%
clear n1;
clear n2;
clear n3;
%
clear n;
clear nvelox;
clear naccel;
%
clear omt;
%
tpi=2*pi;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Enter the units system ');
disp(' 1=English  2=metric ');
iu=input(' ');
%
disp(' Assume symmetric mass and stiffness matrices. ');
%
mass_scale=1;
%
if(iu==1)
     disp(' Select input mass unit ');
     disp('  1=lbm  2=lbf sec^2/in  ');
     imu=input(' ');
     if(imu==1)
         mass_scale=386;
     end
else
    disp(' mass unit = kg ');
end
%
if(iu==1)
    disp(' stiffness unit = lbf/in ');
else
    disp(' stiffness unit = N/m ');
end
%
disp(' ');
disp(' Select file input method ');
disp('   1=file preloaded into Matlab ');
disp('   2=Excel file ');
file_choice = input('');
%
disp(' ');
disp(' Mass Matrix ');
%
if(file_choice==1)
        m = input(' Enter the matrix name:  ');
end
if(file_choice==2)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%
        m = xlsread(xfile);
%
end
%
m=m/mass_scale;
%
mass=m;
num=max(size(m));
%
disp(' ');
disp(' Stiffness Matrix ');
%
if(file_choice==1)
        k = input(' Enter the matrix name:  ');
end
if(file_choice==2)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%
        k = xlsread(xfile);
%
end
stiff=k;
%
disp(' Input Matrices ');
mass
stiff
%
[fn,omegan,ModeShapes,MST]=Generalized_Eigen(stiff,mass,1);
%
disp(' ');
damp(1)=input(' Enter the damping ratio for mode 1 ');
damp(2)=input(' Enter the damping ratio for mode 2 ');
%
r(1)=1;
r(2)=1;
%
PF = MST*m*r';
%
disp(' ')
disp(' Particpation Factors = ');
disp(' ');
out1=sprintf('  %8.4g   ', PF(1));
out2=sprintf('  %8.4g   ', PF(2));
disp(out1);
disp(out2);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(iu==1)
    disp(' ');
    B(1)=   input(' Enter the first force amplitude (lbf)  ');
    alpha(1)=input(' Enter the first force frequency (Hz)   ');
%
    disp(' ');
    B(2)=   input(' Enter the second force amplitude (lbf)  ');
    alpha(2) =input(' Enter the second force frequency (Hz)   ');
%
    disp(' ');
    x_init(1)=   input(' Enter the  first initial displacement (in)  ');
    x_init(2)=   input(' Enter the second initial displacement (in)  ');
%
    disp(' ');
    v_init(1)=   input(' Enter the  first initial velocity (in/sec)  ');
    v_init(2)=   input(' Enter the second initial velocity (in/sec)  ');
else
%%%%
    disp(' ');
    B(1)=   input(' Enter the first force amplitude (N)  ');
    alpha(1)=input(' Enter the first force frequency (Hz)   ');
%
    disp(' ');
    B(2)=   input(' Enter the second force amplitude (N)  ');
    alpha(2) =input(' Enter the second force frequency (Hz)   ');
%
    disp(' ');
    x_init(1)=   input(' Enter the  first initial displacement (m)  ');
    x_init(2)=   input(' Enter the second initial displacement (m)  ');
%
    disp(' ');
    v_init(1)=   input(' Enter the  first initial velocity (m/sec)  ');
    v_init(2)=   input(' Enter the second initial velocity (m/sec)  ');
end
%%%
disp(' ');
sr=input(' Enter the sample rate (samples/sec) ');
dt=1/sr;
disp(' ');
dur=input(' Enter the duration (sec) ');
%
nt=round(dur/dt);
%
clear n;
clear nd;
clear nv;
clear na;
clear nvelox;
clear naccel;
clear x;
clear v;
clear accel;
%
x=zeros(nt,2);
v=zeros(nt,2);
accel=zeros(nt,2);
%
nd=MST*mass*x_init';
nv=MST*mass*v_init';
%
alpha=tpi*alpha;
%
omegad=zeros(2,1);
alpha2=zeros(2,1);
omegan2=zeros(2,1);
domegan=zeros(2,1);
AA=zeros(2,1);
%
U1=zeros(2,2);
U2=zeros(2,2);
%
V1=zeros(2,2);
V2=zeros(2,2);
den=zeros(2,2);
C=zeros(2,2);
%
alpha2=alpha.^2;
%
for j=1:2
%
     omegad(j)=omegan(j)*sqrt(1-(damp(j))^2);
    omegad2(j)=omegad(j)^2;
    domegan(j)=damp(j)*omegan(j);
    omegan2(j)=omegan(j)^2;
         AA(j)=(nv(j)+domegan(j)*nd(j))/omegad(j);     
%
   for k=1:2
%
         U1(j,k)= 2*domegan(j)*alpha(k);
         U2(j,k)= 2*domegan(j)*omegad(j);
%
         V1(j,k)= (alpha2(k)-omegan2(j));
         V2(j,k)= (alpha2(k)-omegan2(j)*(1-2*damp(j)^2));
%
        den(j,k)=(alpha2(k)-omegan2(j))^2+(2*domegan(j)*alpha(k))^2;
          C(j,k)=MST(j,k)*B(k)/den(j,k);
%
          W(j,k)=alpha(k)/omegad(j);
%      
   end
%
end
%
n=zeros(2,nt);
nvelox=zeros(2,1);
naccel=zeros(2,1);
%
       x=zeros(nt,2);
       v=zeros(nt,2);
   accel=zeros(nt,2); 
%
t=zeros(nt,1);
%
for i=1:nt
%  
   t(i)=dt*(i-1);
%
   for j=1:2  % nodal dof
%
      omdt=omegad(j)*t(i);
      cos_odt=cos(omdt);
      sin_odt=sin(omdt);
%
      n(j,i)=0;
      nvelox(j)=0;
      naccel(j)=0.;
%      
      n1=zeros(2,1);
      n2=zeros(2,1);
      nv1=zeros(2,1);
      nv2=zeros(2,1);
      na1=zeros(2,1);
      na2=zeros(2,1);
%
        ee=exp(-domegan(j)*t(i));
       dee=-domegan(j)*ee;
      ddee=(domegan(j))^2*ee;
%
      for k=1:2  % forces
%
            alphat=alpha(k)*t(i); 
%          
            n1(k)=      (U1(j,k)*cos(alphat) + V1(j,k)*sin(alphat));
            n2(k)=   ee*(U2(j,k)*cos_odt + V2(j,k)*sin_odt);
%
            n1(k)=n1(k)*C(j,k);
            n2(k)=n2(k)*W(j,k)*C(j,k);
%
            nv1(k)=    alpha(k)*(-U1(j,k)*sin(alphat) + V1(j,k)*cos(alphat));
            nv2(k)=omegad(j)*ee*(-U2(j,k)*sin_odt + V2(j,k)*cos_odt)...
                           +dee*( U2(j,k)*cos_odt + V2(j,k)*sin_odt);                 
%
            nv1(k)=nv1(k)*C(j,k);
            nv2(k)=nv2(k)*W(j,k)*C(j,k);            
%
            na1(k)= alpha2(k)*(-U1(j,k)*cos(alphat) - V1(j,k)*sin(alphat));
            na2(k)=    omegad2(j)*ee*(-U2(j,k)*cos_odt - V2(j,k)*sin_odt)...
                     +2*omegad(j)*dee*(-U2(j,k)*sin_odt + V2(j,k)*cos_odt)... 
                     +           ddee*( U2(j,k)*cos_odt + V2(j,k)*sin_odt);             
%  
            na1(k)=na1(k)*C(j,k);
            na2(k)=na2(k)*W(j,k)*C(j,k); 
%
      end
%      
         n3= ee*(nd(j)*cos_odt + AA(j)*sin_odt);
%
        nv3=           dee*( nd(j)*cos_odt + AA(j)*sin_odt)+...
              omegad(j)*ee*(-nd(j)*sin_odt + AA(j)*cos_odt);
%
      na3=-2*domegan(j)*nv3-omegan2(j)*n3;
%      
           ns1(j,i)=sum(n1);
           ns2(j,i)=sum(n2);
%           
           n(j,i)= -sum(n1)+sum(n2) + n3;
      nvelox(j)=-sum(nv1)+sum(nv2)+nv3;
      naccel(j)=-sum(na1)+sum(na2)+na3;
   end   
%   
       x(i,:)=(ModeShapes*n(:,i))';
       v(i,:)=(ModeShapes*nvelox)';
   accel(i,:)=(ModeShapes*naccel)';   
end
%
disp('       ');
if(iu==1)
    disp(' dof 1 displacement (in)');
else
    disp(' dof 1 displacement (m)');
end
out1=sprintf(' max= %8.4g',max(x(:,1)));
out2=sprintf(' min= %8.4g',min(x(:,1)));
disp(out1);
disp(out2);
%
disp('       ');
if(iu==1)
    disp(' dof 2 displacement (in)');
else
    disp(' dof 2 displacement (m)');
end
out1=sprintf(' max= %8.4g',max(x(:,2)));
out2=sprintf(' min= %8.4g',min(x(:,2)));
disp(out1);
disp(out2);
%
figure(1);
plot(t,x(:,1),t,x(:,2));
xlabel('Time(sec)');
if(iu==1)
   ylabel('Disp(inch)');
else
   ylabel('Disp(m)');
end
title('Displacement');
legend ('dof 1','dof 2');  
grid on;
%
figure(2);
clear rd;
rd=x(:,2)-x(:,1);
plot(t,rd);
xlabel('Time(sec)');
if(iu==1)
   ylabel('Rel Disp(inch)');
else
   ylabel('Rel Disp(m)');
end
title('Relative Displacement (dof 2 - dof 1)');  
grid on;
%
figure(3);
plot(t,v(:,1),t,v(:,2));
xlabel('Time(sec)');
if(iu==1)
   ylabel('Vel(in/sec)');
else
   ylabel('Vel(m/sec)');
end
title('Velocity');
legend ('dof 1','dof 2');  
grid on;
%
figure(4);
if(iu==1)
    accel=accel/386.;
end
plot(t,accel(:,1),t,accel(:,2));
xlabel('Time(sec)');
if(iu==1)
   ylabel('Accel(G)');
else
   ylabel('Accel(m/sec^2)');
end
title('Acceleration');
legend ('dof 1','dof 2');  
grid on;
%
clear displacement;
clear velocity;
clear acceleration;
clear rel_disp;
%
displacement=[t,x(:,1),x(:,2)];
velocity=[t,v(:,1),v(:,2)];
acceleration=[t,accel(:,1),accel(:,2)];
rel_disp=[t,rd];