%
disp(' ');
disp(' two_dof_arb_force.m   ver 1.0  May 19, 2009 ');
disp(' ');
disp(' by Tom Irvine   Email: tomirvine@aol.com ');
disp(' ');
disp(' This program finds the eigenvalues and eigenvectors for a ');
disp(' two-degree-of-freedom system.');
disp(' The equation of motion is:   M (d^2x/dt^2) + K x = 0 ');
%
clear acc;
clear k;
clear m;
clear Eigenvalues;
clear ModeShapes;
clear omega;
clear omegan;
clear fn;
clear MST;
clear ModalMass;
clear part;
clear QTMQ;
clear r;
clear t;
clear f1;
clear f2;
clear x;
clear d;
clear v;
clear na;
clear nv;
clear nd;
clear Q;
%
tpi=2.*pi;
%
disp(' ');
disp(' Enter the units system ');
disp(' 1=English  2=metric ');
iu=input(' ');
%
n=2;
%
disp(' Assume symmetric mass and stiffness matrices. ');
%
if(iu==1)
    disp(' mass unit = lbm ');
else
    disp(' mass unit = kg ');
end
%
disp(' ');
disp(' Enter m11 ');
m(1,1)=input(' ');
%
disp(' Enter m12 ');
m(1,2)=input(' ');
%	
disp(' Enter m22 ');	
m(2,2)=input(' ');
%
m(2,1)=m(1,2);
%
if(iu==1)
    disp(' stiffness unit = lbf/in ');
else
    disp(' stiffness unit = N/m ');
end
%
disp(' ');
disp(' Enter k11 ');
k(1,1)=input(' ');
%
disp(' Enter k12 ');
k(1,2)=input(' ');
%	
disp(' Enter k22 ');	
k(2,2)=input(' ');
%
k(2,1)=k(1,2);
%
disp(' ');
disp(' The mass matrix is');
m
disp(' ');
disp(' The stiffness matrix is');
k
%
disp(' ');
disp(' Enter modal damping ratio 1 ');
damp(1)=input(' ');
%
disp(' Enter modal damping ratio 2 ');
damp(2)=input(' ');
%
%  Calculate eigenvalues and eigenvectors
%
if(iu==1)
    m=m/386;
end
%
[ModeShapes,Eigenvalues]=eig(k,m);
%
omega = sqrt(Eigenvalues);
fn=omega/tpi;
%
for(i=1:n)
    omegan(i)=omega(i,i);
end
%
disp(' ');
disp('  Natural Frequencies = ');
out1=sprintf('\n  %8.4g Hz',fn(1,1));
out2=sprintf('  %8.4g Hz',fn(2,2));
disp(out1);
disp(out2);
%
MST=ModeShapes';
temp=zeros(2,2);
temp=m*ModeShapes;
QTMQ=MST*temp;
%   
scale1=1./sqrt(QTMQ(1,1));
scale2=1./sqrt(QTMQ(2,2));
%
ModeShapes(:,1) = ModeShapes(:,1)*scale1;  
ModeShapes(:,2) = ModeShapes(:,2)*scale2; 
%
MST=ModeShapes';
%
disp(' ');
disp('  Modes Shapes (column format) =');
disp(' ');
out1=sprintf(' %12.4g    %12.4g ',ModeShapes(1,1),ModeShapes(1,2));
out2=sprintf(' %12.4g    %12.4g ',ModeShapes(2,1),ModeShapes(2,2));
disp(out1);
disp(out2);
%
r(1)=1;
r(2)=1;
%
part = MST*m*r';
%
disp(' ')
disp(' Particpation Factors = ');
disp(' ');
out1=sprintf('  %8.4g   ', part(1));
out2=sprintf('  %8.4g   ', part(2));
disp(out1);
disp(out2);
%
ModalMass = (part.*part)/1.;
%
if(iu==1)
    ModalMass=ModalMass*386;
end
disp(' ');
disp(' Effective Modal Mass =');
disp(' ');
out1=sprintf('  %8.4g   ', ModalMass(1));
out2=sprintf('  %8.4g   ', ModalMass(2));
disp(out1);
disp(out2);
%
tm=ModalMass(1)+ModalMass(2);
%
out1=sprintf('\n Total Modal Mass = %12.4f ',tm);
disp(out1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Select file input method for force 2');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
disp('   3=Excel file ');
file_choice = input('');
%
if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%g %g',[2 inf]);
        THM=THM';
end
if(file_choice==2)
        THM = input(' Enter the matrix name:  ');
end
if(file_choice==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        THM = xlsread(xfile);
%         
end
%
t=THM(:,1);
f2=THM(:,2);
f1=zeros(length(f2),1);
%
tmx=max(t);
tmi=min(t);
nt = length(f2);
dt=(tmx-tmi)/(nt-1);
sr=1./dt;
%
if(sr<10*max(fn))
    disp(' ');
    disp(' Warning: insufficient sample rate. ');
end
%
omegad(1)=omegan(1)*sqrt(1-damp(1)^2);
omegad(2)=omegan(2)*sqrt(1-damp(2)^2);
%
clear Q;
Q=ModeShapes;
%
n1bb=0;
n1b=0;
%
n2bb=0;
n2b=0;
%
C11=exp(-damp(1)*omegan(1)*dt);
C12=exp(-2*damp(1)*omegan(1)*dt);
CS1=cos(omegad(1)*dt);
SS1=sin(omegad(1)*dt);
%
C21=exp(-damp(2)*omegan(2)*dt);
C22=exp(-2*damp(2)*omegan(2)*dt);
CS2=cos(omegad(2)*dt);
SS2=sin(omegad(2)*dt);
%
d1=dt/omegad(1);
d2=dt/omegad(2);
%
for(i=1:nt)
    t(i)=(i-1)*dt + tmi;
%    
    n1=     2*C11*CS1*n1b;
    n1=n1 -   C12*n1bb;
%
    n2=     2*C21*CS2*n2b;
    n2=n2 -   C22*n2bb;
%
    if(i>=2)
        n1=n1 + (Q(1,1)*f1(i-1)+Q(2,1)*f2(i-1))*(d1)*C11*SS1; 
        n2=n2 + (Q(1,2)*f1(i-1)+Q(2,2)*f2(i-1))*(d2)*C21*SS2;   
    end
%
    n1bb=n1b;
    n1b=n1;
%
    n2bb=n2b;
    n2b=n2;
%
   nd(1,i)=n1;
   nd(2,i)=n2;
   d(:,i)=Q*nd(:,i);
%
end
%
figure(1);
plot(t,d(1,:),t,d(2,:));
legend ('Mass 1','Mass 2');   
xlabel('Time(sec)');
title('Displacement');
grid on;
if(iu==1)
    ylabel(' Displacement(in) ');
else
    ylabel(' Displacement(m) ');
end
%
G1=-damp(1)*omegan(1)/omegad(1);
G2=-damp(2)*omegan(2)/omegad(2);
%
for(i=1:nt)
%    
    n1=     2*C11*CS1*n1b;
    n1=n1 - C12*n1bb;
    n1=n1 + dt*(Q(1,1)*f1(i)+Q(2,1)*f2(i));
%
    n2=     2*C21*CS2*n2b;
    n2=n2 - C22*n2bb;
    n2=n2 + dt*(Q(1,2)*f1(i)+Q(2,2)*f2(i));   
%
    if(i>=2)
        n1=n1 + (Q(1,1)*f1(i-1)+Q(2,1)*f2(i-1))*dt*( G1*SS1 - CS1 ); 
        n2=n2 + (Q(1,2)*f1(i-1)+Q(2,2)*f2(i-1))*dt*( G2*SS2 - CS2 );   
    end
%
    n1bb=n1b;
    n1b=n1;
%
    n2bb=n2b;
    n2b=n2;
%
   nv(1,i)=n1;
   nv(2,i)=n2;
   v(:,i)=Q*nv(:,i);
%
end
%
figure(2);
plot(t,v(1,:),t,v(2,:));
legend ('Mass 1','Mass 2');   
xlabel('Time(sec)');
title('Velocity');
if(iu==1)
    ylabel(' Velocity(in/sec) ');
else
    ylabel(' Velocity(m/sec) ');
end
grid on;
%
for(i=1:nt)
%    
   na(1,i)=-2*damp(1)*omegan(1)*nv(1,i)-(omegan(1))^2*nd(1,i)+(Q(1,1)*f1(i)+Q(2,1)*f2(i));
   na(2,i)=-2*damp(2)*omegan(2)*nv(2,i)-(omegan(2))^2*nd(2,i)+(Q(1,2)*f1(i)+Q(2,2)*f2(i));
   acc(:,i)=Q*na(:,i);
%
end
%
figure(3);
if(iu==1)
    acc=acc/386;
end
plot(t,acc(1,:),t,acc(2,:));
legend ('Mass 1','Mass 2');   
xlabel('Time(sec)');
title('Acceleration');
if(iu==1)
    ylabel(' Acceleration(G) ');
else
    ylabel(' Acceleration(m/sec^2) ');
end
grid on;