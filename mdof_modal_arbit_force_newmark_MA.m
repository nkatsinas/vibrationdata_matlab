disp('  ');
disp(' mdof_modal_arbit_force_newmark_MA.m   ver 1.2  May 16, 2020');
disp('  ');
disp(' by Tom Irvine   Email: tom@irvinemail.org');
disp('  ');
disp(' Reference:  Rao V. Dukkipati, Vehicle Dynamics');
disp('  ');
disp(' This script uses the Newmark-Beta method to solve the following '); 
disp(' equation of motion:   M (d^2x/dt^2) + C dx/dt + K x = F ');
%
disp('  ');
disp(' It also allows for a reduced set of modes followed by the mode ');
disp(' acceleration method. ');
%
disp(' ');
%
clear DI;
clear VI;
clear w;
clear t;
clear M;
clear C;
clear K;
clear accel;
clear length;
clear tt;
clear ff;
clear FI;
clear tint;
clear fint;
clear damp;
clear x;
clear y;
clear accel;
%
close all;
%
disp(' ');
disp(' Enter the units system ');
disp(' 1=English  2=metric ');
iu=input(' ');
%
disp(' Assume symmetric mass and stiffness matrices. ');
%
if(iu==1)
     disp(' Select input mass unit ');
     disp('  1=lbm  2=lbf sec^2/in  ');
     imu=input(' ');
else
    disp(' mass unit = kg ');
end
%
disp(' ');
if(iu==1)
    disp(' damping unit = lbf sec/in ');
else
    disp(' damping unit = N sec/m ');
end
%
disp(' ');
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
        M = input(' Enter the matrix name:  ');
end
if(file_choice==2)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        M = xlsread(xfile);
%         
end
%
if(iu==1 && imu==1)
  M=M/386;
end
%
sz=size(M);
ndof=sz(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Select damping input method ');
disp('   1=uniform damping ratio ');
disp('   2=damping ratio vector ');
%
idm=input(' ');
if(idm==1)
    damp=zeros(ndof,1);
    disp(' Enter damping ratio ');
    udamp=input(' ');
    for i=1:ndof
        damp(i)=udamp;
    end    
else
%
    if(file_choice==1)
        damp = input(' Enter the damping vector name:  ');
    end
    if(file_choice==2)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        damp = xlsread(xfile);
%         
    end
%
end
%
clear length;
if(length(damp)<ndof)
    warndlg('Damping entry error');
    return;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Stiffness Matrix ');
%
if(file_choice==1)
        K = input(' Enter the matrix name:  ');
end
if(file_choice==2)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        K = xlsread(xfile);
%         
end
%
DI=zeros(ndof,1);
VI=zeros(ndof,1);
%
disp(' ');
disp(' Enter initial conditions?  1=yes  2=no ');
ic=input(' ');
if(ic==1)
%
    disp(' ');
    disp(' Enter initial displacement vector ');
    DI=input(' '); 
%
    disp(' ');
    disp(' Enter initial velocity vector');
    VI=input(' ');     
%
end
% 
[fn,omegan,ModeShapes,MST]=Generalized_Eigen(K,M,1);
%
Tmin=1/(max(fn));
Tmax=1/(min(fn));
%
disp(' ');
disp(' Enter duration(sec)');
dur=input(' ');
%
srr=20*max(fn);
disp(' ');
disp(' Enter sample rate (samples/sec)');
out1=sprintf(' (recommend >= %8.4g)',srr);
disp(out1);
sr=input(' ');
%
dt=1/sr;
%
NT=round(dur/dt);
%
t=linspace(0,dur,NT);
%
ndof=max(size(M));
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[FFI,force_dof,nff]=ODE_force_input(iu,ndof,NT,t,file_choice);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[U,Ud,Udd]=...
    Newmark_modal_force_MA(DI,VI,dt,NT,ndof,damp,omegan,FFI,force_dof,ModeShapes,M,K);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
t=t';
x=U';
y=Ud';
accel=Udd';
num=ndof;
%
mdof_plot(t,x,y,accel,num,iu);
%
displacement=[t x];
velocity=[t y];
acceleration=[t accel];
%
disp(' ');
disp(' Output arrays: ');
disp('  displacement');
disp('  velocity');
disp('  acceleration');
%