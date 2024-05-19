disp(' ');
disp(' mdof_modal_arbit_force_ri.m  ver 1.6  January 22, 2013 ');
disp(' by Tom Irvine  Email: tom@vibrationdata.com');
disp(' ');
disp(' This program calculates the response of an MDOF ');
disp(' system to arbitrary force excitation via the ramp');
disp(' invariant digital recursive filtering relationship. ');
disp('  ');
disp(' The system is decoupled using normal modes as an  ');
disp(' intermediate step. ');
disp('  ');
%
close all hidden;
%
clear damp
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
clear a;
clear v;
clear x;
clear y;
%
clear d_forward;
clear d_back;
clear d_resp;
%
clear v_forward;
clear v_back;
clear v_resp;
%
clear a_forward;
clear a_back;
clear a_resp;
%
clear FA;

clear FFI;
clear force_dof;
clear nff;

clear fn;
clear omegan;
clear ModeShapes;
clear MST;
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
sys_dof=sz(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out1=sprintf('\n The system has %d unconstrained degrees-of-freedom \n',sys_dof);
disp(out1);
%
%
ndof=input(' Enter number of modes to include in analysis. ');
if(ndof>sys_dof)
    ndof=sys_dof;
end
%
damp=zeros(ndof,1);
%
disp(' ');
disp(' Select damping input method ');
disp('   1=uniform damping ratio ');
disp('   2=damping ratio vector ');
%
idm=input(' ');
if(idm==1)
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
[fn,omegan,ModeShapes,MST]=Generalized_Eigen(K,M,1);
%
Tmin=1/(max(fn));
Tmax=1/(min(fn));
%
disp(' ');
disp(' Enter duration(sec)');
dur=input(' ');
%
srr=20*(fn(ndof));
disp(' ');
disp(' Enter sample rate (samples/sec)');
out1=sprintf(' (recommend %8.4g)',srr);
disp(out1);
sr=input(' ');
%
dt=1/sr;
%
NT=round(dur/dt);
%
t=linspace(0,dur,NT);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[FFI,force_dof,nff]=ODE_force_input(iu,sys_dof,NT,t,file_choice);
%
FA=zeros(sys_dof,NT);
%
for(i=1:sys_dof)
%
   i_index=force_dof(i);
%
   if(i_index~=-999)
        FA(i,:)=FFI(:,i_index);
    end
%
end
%
nodal_force=MST*FA;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Calculate Filter Coefficients
%
mass=1;
%
a1=zeros(ndof,1);
a2=zeros(ndof,1);
%
df1=zeros(ndof,1);
df2=zeros(ndof,1);
df3=zeros(ndof,1);
%
vf1=zeros(ndof,1);
vf2=zeros(ndof,1);
vf3=zeros(ndof,1);
%
af1=zeros(ndof,1);
af2=zeros(ndof,1);
af3=zeros(ndof,1);
%
for j=1:ndof
%
    omegad=omegan(j)*sqrt(1.-(damp(j)^2));
    domegan=damp(j)*omegan(j);
%    
    cosd=cos(omegad*dt);
    sind=sin(omegad*dt); 
%
    domegadt=domegan*dt;
%
    eee1=exp(-domegadt);
    eee2=exp(-2.*domegadt);
%
    ecosd=eee1*cosd;
    esind=eee1*sind; 
%
    a1(j)=2.*ecosd;
    a2(j)=-eee2;
%
    omeganT=omegan(j)*dt;
    phi=(2*damp(j))^2-1;
    DD1=(omegan(j)/omegad)*phi;
    DD2=2*DD1;
%    
    df1(j)=2*damp(j)*(ecosd-1) +DD1*esind +omeganT;
    df2(j)=-2*omeganT*ecosd +2*damp(j)*(1-eee2) -DD2*esind;
    df3(j)=(2*damp(j)+omeganT)*eee2 +(DD1*esind-2*damp(j)*ecosd);
%     
    VV1=(damp(j)*omegan(j)/omegad);
%    
    vf1(j)=(-ecosd+VV1*esind)+1;
    vf2(j)=eee2-2*VV1*esind-1;
    vf3(j)=ecosd+VV1*esind-eee2;
%
    MD=(mass*omegan(j)^3*dt);
    df1(j)=df1(j)/MD;
    df2(j)=df2(j)/MD;
    df3(j)=df3(j)/MD;
%
    VD=(mass*omegan(j)^2*dt);
    vf1(j)=vf1(j)/VD;
    vf2(j)=vf2(j)/VD;
    vf3(j)=vf3(j)/VD;
%
    af1(j)=esind/(mass*omegad*dt);
    af2(j)=-2*af1(j);
    af3(j)=af1(j);
%   
end    
%
%  Numerical Engine
%
disp(' ')
disp(' Calculating response...');
%
nx=zeros(NT,ndof);
nv=zeros(NT,ndof);
na=zeros(NT,ndof);
%
progressbar;
for j=1:ndof
    progressbar(j/ndof);
%
%  displacement
%
    d_forward=[   df1(j),  df2(j), df3(j) ];
    d_back   =[     1, -a1(j), -a2(j) ];
    d_resp=filter(d_forward,d_back,nodal_force(j,:));
%    
%  velocity
%
    v_forward=[   vf1(j),  vf2(j), vf3(j) ];
    v_back   =[     1, -a1(j), -a2(j) ];
    v_resp=filter(v_forward,v_back,nodal_force(j,:));
%    
%  acceleration
%   
    a_forward=[   af1(j),  af2(j), af3(j) ];
    a_back   =[     1, -a1(j), -a2(j) ]; 
    a_resp=filter(a_forward,a_back,nodal_force(j,:));
%
    nx(:,j)=d_resp;  % displacement
    nv(:,j)=v_resp;  % velocity
    na(:,j)=a_resp;  % acceleration  
%
end
pause(0.3);
progressbar(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear x;
clear v;
clear a;
%
x=zeros(NT,sys_dof);
v=zeros(NT,sys_dof);
a=zeros(NT,sys_dof);
%
for i=1:NT
    x(i,:)=(ModeShapes(:,1:ndof)*((nx(i,:))'))';
    v(i,:)=(ModeShapes(:,1:ndof)*((nv(i,:))'))';
    a(i,:)=(ModeShapes(:,1:ndof)*((na(i,:))'))';    
end
%
num=ndof;
%
t=fix_size(t);
%
disp(' ');
disp(' Select plot option: ');
disp(' 1=plot all dof responses on same plot');
disp(' 2=individual plots for selected dof ');
ipo=input(' ');
%
if(ipo==1)
    mdof_plot(t,x,v,a,num,iu);
else
    idof_plot(t,x,v,a,num,iu);
end
%
clear acceleration;
clear velocity;
clear displacement;
%
if(iu==1)
    a=a/386;
end
%
acceleration=[t a];
velocity=[t v];
displacement=[t x];
%
disp(' ');
disp(' Output arrays:  displacement, velocity, acceleration ');