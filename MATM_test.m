%
%    MATM_test.m  ver 1.0  by Tom Irvine
%

clear term;
clear IM;
clear ModeShapes;
clear MST;
clear EA;
clear EAT;
clear force;


tpi=2*pi;


iu=1;

mass=[0.0895 0 0; 0 0.0887 0; 0 0 0.0770]

stiff=[20679 -2157 0; -2157 23856 -2270; 0 -2270 19342]

ijk=1;

S2=stiff;
M2=mass;

[fn,omega,ModeShapes,MST]=Generalized_Eigen(S2,M2,ijk);

ModeShapes3=ModeShapes;

% reduced to two modes

ModeShapes(:,3)=[];
MST=ModeShapes';

sz=size(ModeShapes);
n=sz(2);

F=[0 0 1]';

sr=4000;

dt=1/sr;

dur=1;

nt=floor(dur/dt);

fext=70;
omega=tpi*fext;

A=1;

force=zeros(nt,3);
t=zeros(nt,1);


for i=1:nt
    
    t(i)=(i-1)*dt;
    force(i,3)=A*sin(omega*t(i));
    
end

IM=eye(3,3);

minv=pinv(MST*mass*ModeShapes);

term=mass*ModeShapes*minv*MST;


Fres=( IM - term)*F

Xres=pinv(stiff)*Fres


KA=Xres'*stiff*Xres
MA=Xres'*mass*Xres


[fnA,omegaA,ModeShapesA,MSTA]=Generalized_Eigen(KA,MA,ijk);


phi=Xres*ModeShapesA

EA=[ ModeShapes phi]

EAT=EA';


EAT*mass*EA

O=EAT*stiff*EA

for i=1:3
    omegan(i)=sqrt(O(i,i));
end    

dampv=[1 1 1]*0.05

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ndof=3;
sys_dof=3;

[x,v,a,nx,nv,na]=ramp_invariant_force(EA,force,ndof,sys_dof,omegan,dampv,dt);    
    
mdof_plot_legend_3iu(t,x,v,a,ndof,iu);

figure(4);
plot(t,force(:,1),t,force(:,2),t,force(:,3));
title('Force');
xlabel('Time (sec)');

dmass3=[t x(:,3)];

