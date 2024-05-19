disp(' ');
disp(' mdof_arb_force_mac.m   ver 1.2  February 10, 2010 ');
disp(' ');
disp(' by Tom Irvine   Email: tomirvine@aol.com ');
disp(' ');
disp(' This program solves the following equation of motion: ');
disp('    M (d^2x/dt^2) + C (dx/dt)+ K x = f(T) ');
disp(' ');
disp(' It also demonstrates the modal acceleration method.');
%
clear acc;
clear k;
clear m;
clear damp;
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
clear mass;
clear stiffness;
%
tpi=2.*pi;
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
stiffness=k;
%
disp(' ');
disp(' Modal Damping Vector ');
%
if(file_choice==1)
        damp = input(' Enter the vector:  ');
end
if(file_choice==2)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        damp = xlsread(xfile);
%         
end
%
size(m)
size(k);
size(damp);
%
num=max(size(m));
%
disp(' ');
disp(' The mass matrix is');
m
disp(' ');
disp(' The stiffness matrix is');
k
disp(' ');
disp(' The modal damping vector is');
damp
%
%  Calculate eigenvalues and eigenvectors
%
disp(' ');
[fn,omega,ModeShapes,MST]=Generalized_Eigen(k,m,1);
%
clear r;
clear part;
clear ModalMass;
%
r=ones(num,1);
%
part = MST*m*r;
%
disp(' Participation Factors  ');
part
%
ModalMass = (part.*part)/1.;
%
if(iu==1)
    ModalMass=ModalMass*386;
end
disp(' Effective Modal Mass ');
ModalMass
%
tm=0;
for(i=1:num)
   tm=tm+ModalMass(i,1);
end
%
out1=sprintf('\n Total Modal Mass = %12.4f ',tm);
disp(out1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Enter dt (sec)');
dt=input(' ');
sr=1/dt;
disp(' ');
disp(' Enter starting time (sec) ');
tstart=input(' ');
disp(' Enter ending time (sec) ');
tend=input(' ');
nt=round((tend-tstart)/dt);
nt=nt+1;
t =  linspace(tstart,tend,nt); 
%
disp(' ');
disp(' Each input force must have two columns: time(sec) & force ');
disp(' ');
disp(' Select file input method for forces');
disp('   1=file preloaded into Matlab ');
disp('   2=Excel file ');
file_choice = input('');
%
clear f;
f=zeros(nt,num);
for(i=1:num)
    clear FI;
    out1=sprintf(' Force Vector %d',i);
    disp(out1);
    file_choice;
    if(file_choice==1)
        FI = input(' Enter the matrix name:  ');
    end
    if(file_choice==2)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        FI = xlsread(xfile);
%         
    end 
    clear yi;
    yi = interp1(FI(:,1),FI(:,2),t);
    f(:,i)=yi';
end
t=t';
%%
%
if(sr<10*max(fn))
    disp(' ');
    disp(' Warning: insufficient sample rate. ');
end
%
for(i=1:num)
    omegad(i)=omegan(i)*sqrt(1-damp(i)^2);
end
%
clear Q;
Q=ModeShapes;
QT=Q';
%
%  displacement
%
clear C1;
clear C2;
clear CS;
clear SS;
clear dom;
%
nbb=zeros(num,1);
nb =zeros(num,1);
%
for(i=1:num)
    C1(i)=exp(  -damp(i)*omegan(i)*dt);
    C2(i)=exp(-2*damp(i)*omegan(i)*dt);
    CS(i)=cos(omegad(i)*dt);
    SS(i)=sin(omegad(i)*dt);
    dom(i)=dt/omegad(i);   
end
%
d=zeros(nt,num);
v=zeros(nt,num);
acc=zeros(nt,num);
%
for(i=1:nt)
%    
    for(j=1:num)
        n(j)= 2*C1(j)*CS(j)*nb(j) - C2(j)*nbb(j);
    end
%
    if(i>=2)
        for(j=1:num)
            clear sum;
            sum=0;
            for(ijk=1:num)
                sum=sum+QT(j,ijk)*f(i-1,ijk);
            end
            n(j)=n(j)+sum*dom(j)*C1(j)*SS(j);
        end   
    end
%
    for(j=1:num)
        nbb(j)=nb(j);
        nb(j)=n(j);
    end
%
   for(j=1:num)
        nd(j,i)=n(j);  
   end
%
   d(i,:)=(Q*nd(:,i))'; 
%
end
%
clear G;
for(j=1:num)
    G(j)=-damp(j)*omegan(j)/omegad(j);
end
%
%  velocity
%
nbb=zeros(num,1);
nb =zeros(num,1);
%
for(i=1:nt)
%  
    for(j=1:num)
        n(j)= 2*C1(j)*CS(j)*nb(j) - C2(j)*nbb(j);
    end
%    
    for(j=1:num)
        clear sum;
        sum=0;
        for(ijk=1:num)
            sum=sum+QT(j,ijk)*f(i,ijk);
        end
        n(j)=n(j)+dt*sum;
    end     
%
    if(i>=2)
%
        for(j=1:num)
            clear sum;
            sum=0;
            for(ijk=1:num)
                sum=sum+QT(j,ijk)*f(i-1,ijk);
            end
            n(j)=n(j)+sum*dt*(G(j)*SS(j)-CS(j) );
        end                  
%        
    end
%
    for(j=1:num)
        nbb(j)=nb(j);
        nb(j)=n(j);
    end
%
   for(j=1:num)
        nv(j,i)=n(j);  
   end
   v(i,:)=(Q*nv(:,i))'; 
%
end
%
%  acceleration
%
clear naa;
for(i=1:nt)
%    
    for(j=1:num)
        clear sum;
        sum=0;
        for(ijk=1:num)
            sum=sum+QT(j,ijk)*f(i,ijk);
        end
        na(j)=-2*damp(j)*omegan(j)*nv(j,i)-(omegan(j))^2*nd(j,i)+sum;
    end 
%    
    for(j=1:num)
        naa(j,i)=na(j);  
    end
   acc(i,:)=(Q*na')';    
%
end
%
%  modal acceleration method
%
disp(' ');
disp(' Enter number of modes for modal acceleration method ');
nmac=input(' ');
%
clear terms
clear dmac;
clear xmac;
clear QMAC;
QMAC=Q(:,1:nmac);
sum_mac=zeros(1,num);  
invk=inv(k);
for(i=1:nt)
    for(j=1:nmac)
        term1=((2*damp(j)/omegan(j))*nv(j,i));
        term2=(naa(j,i)/omegan(j)^2);
        terms(j)=term1+term2;
    end
    xmac=invk*(f(i,:))'-(QMAC*terms');
    dmac(i,:)=xmac';
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Currently set up for four dof
%
figure(1);
plot(t,d(:,1),t,d(:,2),t,d(:,3),t,d(:,4));
legend ('Mass 1','Mass 2','Mass 3','Mass 4');   
xlabel('Time(sec)');
title('Displacement');
grid on;
if(iu==1)
    ylabel(' Displacement(in) ');
else
%    ylabel(' Displacement(m) ');
end
figure(2);
plot(t,v(:,1),t,v(:,2),t,v(:,3),t,v(:,4));
legend ('Mass 1','Mass 2','Mass 3','Mass 4');    
xlabel('Time(sec)');
title('Velocity');
if(iu==1)
    ylabel(' Velocity(in/sec) ');
else
%    ylabel(' Velocity(m/sec) ');
end
grid on;
%
figure(3);
if(iu==1)
    acc=acc/386;
end
plot(t,acc(:,1),t,acc(:,2),t,acc(:,3),t,acc(:,4));
legend ('Mass 1','Mass 2','Mass 3','Mass 4');    
xlabel('Time(sec)');
title('Acceleration');
if(iu==1)
    ylabel(' Acceleration(G) ');
else
%    ylabel(' Acceleration(m/sec^2) ');
end
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%  Transmitted Forces
%
%  Assume proportional damping
%
om1=omegan(1);
om2=omegan(num);
damp1=damp(1);
damp2=damp(num);
den=om2^2-om1^2;
alpha=2*om1*om2*(damp1*om2-damp2*om1)/den;
beta=2*(damp2*om2-damp1*om1)/den;
m=mass;
k=stiffness;
out1=sprintf('\n alpha = %8.4g  beta = %8.4g \n',alpha,beta);
disp(out1);
disp(' The proportional damping matrix is ');
c=alpha*m + beta*k
%
QT*c*Q