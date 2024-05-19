%
disp(' semidefinite_force.m  ver 1.5   May 2, 2014');
disp(' ');
disp(' Response of a semi-definite two-degree-of-freedom ');
disp(' system subjected to an applied sinusoidal force. ');
disp(' ');
disp(' By Tom Irvine  Email: tom@irvinemail.org');
disp(' ');
%
close all;
%
clear k;
clear m;
clear v;
clear pf;
clear pff;
clear emm;
clear mmm;
clear mv;
clear ks;
clear fn;
clear omega;
clear ModeShapes;
clear MST;
%
disp(' ');
disp(' Enter unit:  1=English  2=metric ');
iu=input(' ');
%
tpi=2*pi;
%
n=2; %dof
%
m=zeros(n,n);
k=zeros(n,n);
ks=zeros(n,1);
%
%
if(iu==1)
    disp('      Mass unit: lbm');
    disp(' Stiffness unit: lbf/in ');
else
    disp(' Mass unit: kg');
    disp(' Stiffness: N/m');
end
%
for i=1:n
    out1=sprintf('\n Enter mass %d ',i);
    disp(out1);
    m(i,i)=input(' ');
end    
%
for i=1:n-1
    out1=sprintf('\n Enter stiffness for spring between masses %d & %d ',i,i+1);
    disp(out1);
    ks(i)=input(' ');
end
%
k(1,1)=ks(1);
for i=2:(n-1)
   k(i-1,i)=-ks(i-1);
   k(i,i)=ks(i-1)+ks(i); 
end
k(n-1,n)=-ks(n-1);
k(n,n)=ks(n-1);
%
for i=1:n
		for j=i:n
            m(i,j)=m(i,j); 
			k(j,i)=k(i,j);
        end
end
%
morig=m;
%
if(iu==1)
   m=m/386.;
end
%
disp(' ');
[fn,omega,ModeShapes,MST]=Generalized_Eigen_semidefinite(k,m,2);
%
disp(' ');
dof=n;
%
disp(' ');
%
v=ones(dof);
%
disp('        Natural    Participation    Effective  ');
disp('Mode   Frequency      Factor        Modal Mass ');
%
LM=MST*m*v';
pf=LM;
sum=0;
%    
mmm=MST*m*ModeShapes;   
%
for i=1:dof
        pff(i)=pf(i)/mmm(i,i);
        emm(i)=pf(i)^2/mmm(i,i);
        out1 = sprintf('%d  %10.4g Hz   %10.4g   %10.4g',i,fn(i),pff(i),emm(i) );
        disp(out1)
        sum=sum+emm(i);
end
out1=sprintf('\n modal mass sum = %8.4g \n',sum);
disp(out1);
disp(' ');
disp(' mass matrix ');
m
disp(' ');
disp(' stiffness matrix ');
k
disp(' ');
ModeShapes
%
disp(' ');
damp=input(' Enter viscous damping ratio ');
%
disp(' ');
disp(' Apply sinusoidal force to mass 1 ');
disp(' ');
if(iu==2)
    A=input(' Enter force (N) ');
else
    A=input(' Enter force (lbf) ');    
end
%
disp(' ');
f=input(' Enter excitation frequency (Hz) ');
omega=tpi*f;
%
disp(' ');
T=input(' Enter duration (sec) ');
%
maxf=max([ max(fn) f]);
dt=(1/maxf)/32;
%
NT=round(T/dt);
%
omegan=tpi*fn(2);
omegad=omegan*sqrt(1-damp^2);
%
om2=omega^2;
omn2=omegan^2;
%
den=( om2-omn2 )^2 + (2*damp*omega*omegan)^2;
%
B=  MST(1,1)*A;
C=  MST(2,1)*A/den;
D=  MST(2,1)*A*(omega/omegad)/den;
%
U1=-2*damp*omegan*omega;
U2=-( om2-omn2 )/omega;
V1= 2*damp*omegan*omegad;
V2= ( om2 - omn2*(1-2*damp^2 ) );
%
x=zeros(2,NT);
v=zeros(2,NT);
a=zeros(2,NT);
%
tt=zeros(NT,1);
%
for i=1:NT
    t=(i-1)*dt;
    tt(i)=t;
%
     omt=omega*t;
    omdt=omegad*t;
%    
      eee=exp(-damp*omegan*t);
     deee=-damp*omegan*eee;
    ddeee=-damp*omegan*deee;
%
    sin_omt=sin(omt);
    cos_omt=cos(omt); 
%
    sin_omdt=sin(omdt);
    cos_omdt=cos(omdt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    n1= B*(omt-sin_omt)/om2;
%
    n2a=    C*(  U1*cos_omt   + U2*sin_omt   );
    n2b=D*eee*(  V1*cos_omdt  + V2*sin_omdt  );
%    
    n2=(n2a+n2b);
    nd2=n2;
%
    n=[n1 ; n2 ];
    
    nnn(i,1)=n1;
    nnn(i,2)=n2;
%
    x(:,i)=ModeShapes*n;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    nv1= B*(1-cos_omt)/omega ;
%
    nv2a=      omega*C*(   U1*sin_omt   - U2*cos_omt   );
    nv2b=       D*deee*(   V1*cos_omdt +  V2*sin_omdt  );
    nv2c= omegad*D*eee*(  -V1*sin_omdt +  V2*cos_omdt  );
%
    nv2=nv2a+nv2b+nv2c;
%
    nv=[nv1 ; nv2 ];
%
    v(:,i)=ModeShapes*nv;    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    na1=B*sin_omt;
%
    na2a=om2*C*(  U1*cos_omt   + U2*sin_omt   );
    na2b1=D*ddeee*(   V1*cos_omdt +  V2*sin_omdt  );
    na2b2= omegad*D*deee*(   -V1*sin_omdt +  V2*cos_omdt  );
    na2c1= na2b2;
    na2c2= omegad^2*D*eee*(  -V1*cos_omdt -  V2*sin_omdt  );
%
    na2=na2a+na2b1+na2b2+na2c1+na2c2;
%
    na=[na1 ; na2 ];
%
    a(:,i)=ModeShapes*na;    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
end
%
% 
x=x';
v=v';
a=a';
%
fig_num=1;
[fig_num]=two_dof_sd_mdof_plot(tt,x,v,a,2,iu,fig_num);
%
if(iu==1)
    a=a/386;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Plot transfer functions?  1=yes 2=no ');
ipt=input(' ');
%
if(ipt==1)
    omega=[0; omega];  
    damp=[damp; damp];
    [fig_num]=two_dof_sd_transfer_from_modes_function(damp,omega,ModeShapes,fig_num,iu);
end