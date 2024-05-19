%
disp('  ');
disp(' Newmark_hybrid.m   ver 1.3  January 13, 2014  ');
disp('  ');
disp(' by Tom Irvine   Email: tom@vibrationdata.com ');
disp('  ');
disp(' Reference:  Rao V. Dukkipati, Vehicle Dynamics');
%
disp(' ');
disp(' This script uses the Newmark-Beta method to solve the following '); 
disp(' equation of motion for an applied force:  ');
disp(' ');
disp('     M (d^2x/dt^2) + C dx/dt + K x = F ');
disp(' ');
disp(' The script first performs a normal modes analysis. A subset of modes');
disp(' may be used to reduce the system order for the forced-response calculation.'); 

disp(' The mass and stiffness matrices will be uncoupled, but the damping ');
disp(' coefficient matrix may remain coupled. The forced response analysis');
disp(' is performed as a direct integration assuming fully-populated mass,');
disp(' damping and stiffness matrices. ');
%
disp(' ');
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
close all;
%
tpi=2*pi;
%
disp(' ');
disp(' Enter the units system ');
disp(' 1=English: G, in/sec, in, lbf'); 
disp(' 2= metric: G,  m/sec, mm, N');
iu=input(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(iu==1)
     disp(' Select input mass unit ');
     disp('  1=lbm  2=lbf sec^2/in  ');
     imu=input(' ');
%
     if(imu==1)
        disp(' Enter mass matrix name (lbm) ');
     else
        disp(' Enter mass matrix name (lbf sec^2/in) ');         
     end
     M=input(' ');
     if(imu==1)
         M=M/386;
     end
else
     disp(' Enter mass matrix name (kg) ');
     M=input(' ');    
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(iu==1)
    disp(' Enter damping coefficient  matrix name (lbf sec/in) ');
else
    disp(' Enter damping coefficient  matrix name (N sec/m) ');    
end 
C=input(' ');
%
if(iu==1)
    disp(' Enter stiffness matrix name (lbf/in) ');
else
    disp(' Enter stiffness matrix name (N/m) ');    
end    
K=input(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' The mass matrix is');
M
disp(' ');
disp(' The damping matrix is');
C
disp(' ');
disp(' The stiffness matrix is');
K
%
iflag=1;
%
sz=size(M);
ndof=sz(1);
%
for(i=1:ndof)
    if(abs(M(i,i))<1.0e-60)
        iflag=0;
        break;
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[fn,omega,ModeShapes,MST]=Generalized_Eigen(K,M,1); 
%
disp(' ');
out1=sprintf(' Enter the number of modes to include (max=%d) :',ndof);
disp(out1);
nm=input('  ');
%
if(nm>ndof)
    nm=ndof;
end
%
MS=ModeShapes(:,1:nm);
MST=MS';
%
M=MST*M*MS
%
C=MST*C*MS
%
K=MST*K*MS
%
disp(' ');
disp(' Enter the starting time (sec) ');
tstart=input(' ');
disp(' ');
disp(' Enter the end time (sec) ');
tend=input(' ');
disp(' ');
disp(' Enter the sample rate (samples/sec)');
sr=input(' ');
dt=1/sr;
nt=1+round((tend-tstart)/dt);
%
t =  linspace(tstart,tend,nt);
t=t';
%
disp(' ');
disp(' Enter applied forces?  1=yes  2=no ');
ia=input(' ');
if(ia==1)
%
    [FP]=Newmark_applied_forces(t,ndof,iu);
%
end
%
U=zeros(nm,1);
Ud=zeros(nm,1);
Udd=zeros(nm,1);
%
%% disp(' ');
%% disp(' Enter initial conditions?  1=yes  2=no ');
%% ic=input(' ');
ic=2;
%
if(ic==1)
%
    disp(' ');
    disp(' Enter initial displacement ');
%
    for i=1:ndof
      out1=sprintf(' U(%d)=  ',i);  
      U(i)=input(out1);        
    end    
%
    disp(' ');
    disp(' Enter initial velocity ');
%
    for i=1:ndof
      out1=sprintf(' Ud(%d)=  ',i);  
      U(i)=input(out1);        
    end    
%
    U=U';
    Ud=Ud';
    disp(' ');
    clear B;
    B=FP(1,:)'-C*Ud'-K*U';
    Udd=pinv(M)*B;
%
end
%
[a0,a1,a2,a3,a4,a5,a6,a7]=Newmark_coefficients(dt);
%
KH=K+a0*M+a1*C;
%
dis=zeros(nt,ndof);
vel=zeros(nt,ndof);
acc=zeros(nt,ndof);
%
for i=1:ndof   % add initial condition option in next revision
    dis(1,i)=0;
    vel(1,i)=0;
    acc(1,i)=0;
end
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
invKH=pinv(KH);
%
for i=2:nt
%
    FH=M*(a0*U+a2*Ud+a3*Udd)+C*(a1*U+a4*Ud+a5*Udd); 
%
    if(ia==1)    
        FH=FH+MST*(FP(i,:)');       
    end
%    
    Un=invKH*FH;   
    Uddn=a0*(Un-U)-a2*Ud-a3*Udd;
    Udn=Ud+a6*Udd+a7*Uddn;
    U=Un;
    Ud=Udn;
    Udd=Uddn;
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
    dis(i,:)=MS*U(:);
    vel(i,:)=MS*Ud(:);
    acc(i,:)=MS*Udd(:);    
%
end
%
if(iu==1)
    acc=acc/386;
else
    acc=acc/9.81;
    dis=dis*1000;
end
%
disp(' ');
disp(' Output arrays: ');
disp('  dis  - displacement');
disp('  vel  - velocity');
disp('  acc  - acceleration');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
num=ndof;
fig_num=1;
if(num<=10)
   figure(fig_num);
   fig_num=fig_num+1;
   hold all;
   for i=1:num
      out4=sprintf('dof %d',i);
      plot(t,dis(:,i),'DisplayName',out4);
      legend('-DynamicLegend');
   end 
end
hold off;
%
xlabel('Time(sec)');
title('Displacement');
grid on;
if(iu==1)
    ylabel(' Displacement(in) ');
else
    ylabel(' Displacement(mm) ');
end
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',11)
        h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',11)
         h = get(gca, 'ylabel');
    set(h, 'FontName', 'Arial','FontSize',11)   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(num<=10)
   figure(fig_num);
   fig_num=fig_num+1;
   hold all;
   for i=1:num
       out4=sprintf('dof %d',i);
       plot(t,vel(:,i),'DisplayName',out4);
       legend('-DynamicLegend');
   end 
end
hold off;
%
xlabel('Time(sec)');
title('Velocity');
grid on;
if(iu==1)
    ylabel(' Velocity(in/sec) ');
else
    ylabel(' Velocity(m/sec) ');
end
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',11)
        h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',11)
         h = get(gca, 'ylabel');
    set(h, 'FontName', 'Arial','FontSize',11) 
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(num<=10)
   figure(fig_num);
   fig_num=fig_num+1;
   hold all;
   for i=1:num
       out4=sprintf('dof %d',i);
       plot(t,acc(:,i),'DisplayName',out4);
       legend('-DynamicLegend');
   end 
end
hold off;
%
%
xlabel('Time(sec)');
title('Acceleration');
grid on;
if(iu==1)
    ylabel(' Accel(G) ');
end
%
h = get(gca, 'title');
set(h, 'FontName', 'Arial','FontSize',11)
h = get(gca, 'xlabel');
set(h, 'FontName', 'Arial','FontSize',11)
h = get(gca, 'ylabel');
set(h, 'FontName', 'Arial','FontSize',11) 
%