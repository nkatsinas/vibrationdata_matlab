%   Newmark.m   ver 1.0  January 6, 2010
%
%   by Tom Irvine   Email: tomirvine@aol.com
%
%   Reference:  Rao V. Dukkipati, Vehicle Dynamics
%
disp(' ');
disp(' This script uses the Newmark-Beta method to solve the following '); 
disp(' equation of motion:   M (d^2x/dt^2) + C dx/dt + K x = 0 ');
%
clear M;
clear C;
clear K;
clear F;
clear FH;
clear FP;
clear KH;
clear t;
clear dis;
clear vel;
clear acc;
clear U;
clear Ud;
clear Udd;
clear Un;
clear Udn;
clear Uddn;
%
%STIFFNESS MATRIX %
KK=[74,0,0,0,0,0;0,74,0,0,0,0;181,181,123934,0,0,-16223;0,2588,0,29724,0,0;-2588,0,0,0,27924,0;0,0,0,0,0,4666];
 
%MASS MATRIX%
MM=[50000,0,0,0,0,0;0,50000,0,0,0,0;0,0,50000,0,0,0;0,0,0,480,0,0;0,0,0,0,480,0;0,0,0,0,0,455];
%---o0o---%
 
K=KK*1;
M=MM*1;
%Calculate eigenvalues and eigenvectors
 
[ModeShapes,Eigenvalues]=eig(K,M);
omega = sqrt(Eigenvalues);
tpi=2*pi;
fn=omega/tpi;
%---o0o---%
disp(' ');
disp('  Natural Frequencies = ');
out1=sprintf('\n  %8.4g Hz',fn(1,1));
out2=sprintf('  %8.4g Hz',fn(2,2));
out3=sprintf('  %8.4g Hz',fn(3,3));
out4=sprintf('  %8.4g Hz',fn(4,4));
out5=sprintf('  %8.4g Hz',fn(5,5));
out6=sprintf('  %8.4g Hz',fn(6,6));
disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);
%---o0o---%
MST=ModeShapes';
temp=zeros(6,6);
temp=M*ModeShapes;
QTMQ=MST*temp;
%---o0o---%
A0=0.05*(2*fn(1,1)*(fn(2,2)))/((fn(1,1))+(fn(2,2)))
A1=0.05*2/(((fn(1,1)))+((fn(2,2))))
C=A0*M+A1*K;
%---o0o---%
scale1=1./sqrt(QTMQ(1,1));
scale2=1./sqrt(QTMQ(2,2));
scale3=1./sqrt(QTMQ(3,3));
scale4=1./sqrt(QTMQ(4,4));
scale5=1./sqrt(QTMQ(5,5));
scale6=1./sqrt(QTMQ(6,6));
%
ModeShapes(:,1) = ModeShapes(:,1)*scale1; 
ModeShapes(:,2) = ModeShapes(:,2)*scale2;
ModeShapes(:,3) = ModeShapes(:,3)*scale3; 
ModeShapes(:,4) = ModeShapes(:,4)*scale4;
ModeShapes(:,5) = ModeShapes(:,5)*scale5; 
ModeShapes(:,6) = ModeShapes(:,6)*scale6;
 
MST=ModeShapes';
 
disp(' ');
disp('  Modes Shapes (column format) =');
disp(' ');
out1=sprintf(' %12.4g  ',ModeShapes(1,1));
out2=sprintf(' %12.4g  ',ModeShapes(2,2));
out3=sprintf(' %12.4g  ',ModeShapes(3,3));
out4=sprintf(' %12.4g  ',ModeShapes(4,4));
out5=sprintf(' %12.4g  ',ModeShapes(5,5));
out6=sprintf(' %12.4g  ',ModeShapes(6,6));
disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);
%---o0o---%
clear Fin;
Fin(1)=0;
Fin(2)=0;
Fin(3)=0;
Fin(4)=0;
Fin(5)=0;
Fin(6)=0;
%---o0o---%
disp(' ');
disp(' Select EXCEL File With Hydrodynamic Wave Force Data');
disp(' ');
  [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);    
        F = xlsread(xfile);
  ia=F;
  Fin(6)=0;
 
%---o0o---%
 
  tf=double(F(:,1));
    nn=max(size(tf));
%
    out1 = sprintf('\n  %d samples ',nn);
    disp(out1)
 
%
U=zeros(6,1);
Ud=zeros(6,1);
Udd=zeros(6,1);
%
disp(' ');
disp(' Enter initial conditions?  1=yes  2=no ');
ic=input(' ');
if(ic==1)
%
    disp(' ');
    disp(' Enter initial displacement ');
%
    U(1)=input('Surge [m]   U(1)= ');
    U(2)=input('Sway  [m]   U(2)= ');
    U(3)=input('Heave [m]   U(3)= ');
    U(4)=input('Roll  [rad] U(4)= ');
    U(5)=input('Pitch [rad] U(5)= ');
    U(6)=input('Yaw   [rad] U(6)= ');
%
    disp(' ');
    disp(' Enter initial velocity ');
%
    Ud(1)=input('Surge [m/s]   U(1)= ');
    Ud(2)=input('Sway  [m/s]   U(2)= ');
    Ud(3)=input('Heave [m/s]   U(3)= ');
    Ud(4)=input('Roll  [rad/s] U(4)= ');
    Ud(5)=input('Pitch [rad/s] U(5)= ');
    Ud(6)=input('Yaw   [rad/s] U(6)= ');
   
%---o0o---%%---o0o---%%---o0o---%%---o0o---%   
%
%%    disp(' ');
%%    disp(' Enter initial acceleration ');
%
%%    Udd(1)=input(' Udd(1)= ');
%%    Udd(2)=input(' Udd(2)= ');
%---o0o---%%---o0o---%%---o0o---%%---o0o---%
    U=U';
    Ud=Ud';
    disp(' ');
    clear B;
    B=Fin'-C*Ud'-K*U';
    Udd=inv(M)*B;
%
end
%---o0o---%
alpha=0.25;
beta=0.5;
%
disp(' ');
disp(' Enter time step (sec)');
st=(1/fn(6,6))/10;
out1=sprintf(' Suggest <= %12.5g ',st);
disp(out1);
dt=input(' ');
%
disp(' ');
disp(' Enter duration (sec)');
dur=input(' ');
nt=round(dur/dt)+1;
%
a0=1/(alpha*dt^2);
a1=beta/(alpha*dt);
a2=1/(alpha*dt);
a3=(1/(2*alpha))-1;
a4=(beta/alpha)-1;
a5=(dt/2)*((beta/alpha)-2);
a6=dt*(1-beta);
a7=beta*dt;
%
KH=K+a0*M+a1*C;
%---o0o---%
t=zeros(nt,6);
dis=zeros(nt,6);
vel=zeros(nt,6);
acc=zeros(nt,6);
%
t(1)=0;
dis(1,1)=U(1);
dis(1,2)=U(2);
dis(1,3)=U(3);
dis(1,4)=U(4);
dis(1,5)=U(5);
dis(1,6)=U(6);
%
vel(1,1)=Ud(1);
vel(1,2)=Ud(2);
vel(1,3)=Ud(3);
vel(1,4)=Ud(4);
vel(1,5)=Ud(5);
vel(1,6)=Ud(6);
%
acc(1,1)=Udd(1);
acc(1,2)=Udd(2);
acc(1,3)=Udd(3);
acc(1,4)=Udd(4);
acc(1,5)=Udd(5);
acc(1,6)=Udd(6);
%
jj=1;
%
%---o0o---%%---o0o---%%---o0o---%
ns=size(U);
if(ns(2)>ns(1))
    U=U';
end
ns=size(Ud);
if(ns(2)>ns(1))
    Ud=Ud';
end
ns=size(Udd);
if(ns(2)>ns(1))
    Udd=Udd';
end
%---o0o---%%---o0o---%%---o0o---%
for(i=2:nt)
    t(i)=(i-1)*dt; 
   % if(ia==1)
%
        FP(1)=0;
        FP(2)=0;
        FP(3)=0;
        FP(4)=0;
        FP(5)=0;
        FP(6)=0;
%      
        for(j=jj:nn)
%            out1=sprintf('i=%d j=%d nn=%d %8.4g  %8.4g  %8.4g ',i,j,nn,t(i),tf(j),tf(j+1));
%            disp(out1);        
            if(t(i)==tf(j))
              %  disp('type 1')
                FP(1)=F(j,2);
                FP(2)=F(j,3);
                FP(3)=F(j,4);
                FP(4)=F(j,5);
                FP(5)=F(j,6);
                FP(6)=F(j,7);
                jj=j;
                break;
            end
            if(j<nn)          
                if(t(i)>tf(j) && t(i)<tf(j+1))
                   % disp('type 2')  
                    length=tf(j+1)-tf(j);
                    x=t(i)-tf(j);
                    c2=x/length;
                    c1=1-c2;
                    FP(1)=c1*F(j,2)+c2*F(j+1,2);
                    FP(2)=c1*F(j,3)+c2*F(j+1,3);
                    FP(3)=c1*F(j,4)+c2*F(j+1,4);
                    FP(4)=c1*F(j,5)+c2*F(j+1,5);
                    FP(5)=c1*F(j,6)+c2*F(j+1,6);
                    FP(6)=c1*F(j,7)+c2*F(j+1,7);
                   
                   jj=j;
                    break;
               end
            end
        end
  %    out1=sprintf('%d  %8.4g  %8.4g ',i,FP(1),FP(2));
  %    disp(out1);    
%
        FH=FP'+M*(a0*U+a2*Ud+a3*Udd)+C*(a1*U+a4*Ud+a5*Udd);
  % else
       % FH=M*(a0*U+a2*Ud+a3*Udd)+C*(a1*U+a4*Ud+a5*Udd);      
   % end
    Un=inv(KH)*FH;  
    Uddn=a0*(Un-U)-a2*Ud-a3*Udd;
    Udn=Ud+a6*Udd+a7*Uddn;
    U=Un;
    Ud=Udn;
    Udd=Uddn;
%---o0o---%%---o0o---%%---o0o---%
    ns=size(U);
    if(ns(2)>ns(1))
        U=U';
    end
    ns=size(Ud);
    if(ns(2)>ns(1))
        Ud=Ud';
    end
    ns=size(Udd);
    if(ns(2)>ns(1))
        Udd=Udd';
    end
%---o0o---%%---o0o---%%---o0o---% 
%    out1=sprintf('%d  %8.4g  %8.4g ',i,U(1),U(2));
%    disp(out1);
    dis(i,1)=U(1);
    dis(i,2)=U(2);
    dis(i,3)=U(3);
    dis(i,4)=U(4);
    dis(i,5)=U(5);
    dis(i,6)=U(6);
%---o0o---%  
    vel(i,1)=Ud(1);
    vel(i,2)=Ud(2);
    vel(i,3)=Ud(3);
    vel(i,4)=Ud(4);
    vel(i,5)=Ud(5);
    vel(i,6)=Ud(6);
%---o0o---%   
    acc(i,1)=Udd(1);
    acc(i,2)=Udd(2);   
    acc(i,3)=Udd(3);
    acc(i,4)=Udd(4);   
    acc(i,5)=Udd(5);
    acc(i,6)=Udd(6);   
%---o0o---%   
end
figure(1);
plot(t,dis(:,1),'b',t,dis(:,2),'r',t,dis(:,3),'g',t,dis(:,4),'k',t,dis(:,5),'m',t,dis(:,6),'c');
title('Displacement [m]');
xlabel('Time[sec]');
legend ('Surge','Sway','Heave','Roll','Pitch','Yaw');
grid on;
%---o0o---%
figure(2);
plot(t,vel(:,1),'b',t,vel(:,2),'r',t,vel(:,3),'g',t,vel(:,4),'k',t,vel(:,5),'m',t,vel(:,6),'c');
title('Velocity [m/s]');
xlabel('Time[sec]');
legend ('Surge','Sway','Heave','Roll','Pitch','Yaw');
grid on;
%---o0o---%
figure(3);
plot(t,acc(:,1),'b',t,acc(:,2),'r',t,acc(:,3),'g',t,acc(:,4),'k',t,acc(:,5),'m',t,acc(:,6),'c');
title('Acceleration [m/s^2]');
xlabel('Time[sec]');
legend ('Surge','Sway','Heave','Roll','Pitch','Yaw');
grid on;       
%---o0o---%%---o0o---%%---o0o---%
%                               %
%             E N D             %
%                               %
%---o0o---%%---o0o---%%---o0o---%
 
 
%CALCULATION RAO
 
disp(' ');
disp(' Select EXCEL File With Wave Frequency Data');
disp(' ');
  [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);    
        w = xlsread(xfile);
        disp(' ');
disp(' Select EXCEL File With Wave Inerita Data');
disp(' ');
  [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);    
        Fi = xlsread(xfile);
%---o0o---%
 
H=20
RAO_Surge=(abs(Fi)/(H/2))/((abs(K(1,1)-(M(1,1)*fn(1,1)^2))^2+abs((C(1,1)*fn(1,1))^2))^(1/2));
figure(4);
plot(w,RAO_Surge,'b');
title('RAO Surge [m/mm]');
xlabel('Time[sec]');
legend ('Surge');
grid on;
%---o0o---%
RAO_Sway=(abs(Fi)/(H/2))/((abs(K(2,2)-(M(2,2)*fn(2,2)^2))^2+abs((C(2,2)*fn(2,2))^2))^(1/2));
figure(5);
plot(w,RAO_Sway,'b');
title('RAO Sway [m/mm]');
xlabel('Time[sec]');
legend ('Sway');
grid on;