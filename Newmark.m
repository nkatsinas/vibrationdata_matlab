%
%   Newmark.m   ver 1.1  November 30, 2011
%
%   by Tom Irvine   Email: tomirvine@aol.com
%
%   Reference:  Rao V. Dukkipati, Vehicle Dynamics
%
disp(' ');
disp(' This script uses the Newmark-Beta method to solve the following '); 
disp(' equation of motion:   M (d^2x/dt^2) + C dx/dt + K x = 0 ');
%
disp(' ');
disp(' The script is currently setup for a two-degree-of-freedom system');
disp(' but it can be readily modified for other systems. ');
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
tpi=2*pi;
%
disp(' Enter mass matrix name ');
M=input(' ');
%
disp(' Enter damping matrix name ');
C=input(' ');
%
disp(' Enter stiffness matrix name ');
K=input(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
if(iflag==1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Calculate eigenvalues and eigenvectors
%
    [ModeShapes,Eigenvalues]=eig(K,M);
%
    omega = sqrt(Eigenvalues);
    fn=omega/tpi;
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
    temp=M*ModeShapes;
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
end
%
clear Fin;
Fin(1)=0;
Fin(2)=0;
%
disp(' ');
disp(' Enter applied force?  1=yes  2=no ');
ia=input(' ');
if(ia==1)
    disp(' The input force must have three columns: ');
    disp(' Time(sec)   Force at node 1   Force at node 2 ');
    disp(' ');
%
    disp(' ')
    disp(' Select file input method ');
    disp('   1=external ASCII file ');
    disp('   2=file preloaded into Matlab ');
    disp('   3=Excel file');
    file_choice = input('');
%
    if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        F = fscanf(fid,'%g %g %g',[3 inf]);
        fclose(fid);
        F=F';
    end
    if(file_choice==2)
        F = input(' Enter the matrix name:  ');
    end
    if(file_choice==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        F = xlsread(xfile);
%         
    end
%
    tf=double(F(:,1));
    nn=max(size(tf));
%
    out1 = sprintf('\n  %d samples ',nn);
    disp(out1)
end
%
U=zeros(ndof,1);
Ud=zeros(ndof,1);
Udd=zeros(ndof,1);
%
disp(' ');
disp(' Enter initial conditions?  1=yes  2=no ');
ic=input(' ');
if(ic==1)
%
    disp(' ');
    disp(' Enter initial displacement ');
%
    U(1)=input(' U(1)= ');
    U(2)=input(' U(2)= ');
%
    disp(' ');
    disp(' Enter initial velocity ');
%
    Ud(1)=input(' Ud(1)= ');
    Ud(2)=input(' Ud(2)= ');
%
%%    disp(' ');
%%    disp(' Enter initial acceleration ');
%
%%    Udd(1)=input(' Udd(1)= ');
%%    Udd(2)=input(' Udd(2)= ');
    U=U';
    Ud=Ud';
    disp(' ');
    clear B;
    B=Fin'-C*Ud'-K*U';
    Udd=pinv(M)*B;
%
end
%
alpha=0.25;
beta=0.5;
%
disp(' ');
disp(' Enter time step (sec)');
if(iflag==1)
    st=(1/fn(2,2))/10;
    out1=sprintf(' Suggest <= %12.5g ',st);
    disp(out1);
end
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
%
t=zeros(nt,1);
dis=zeros(nt,ndof);
vel=zeros(nt,ndof);
acc=zeros(nt,ndof);
%
t(1)=0;
%
dis(1,:)=U(:);
%
vel(1,:)=Ud(:);
%
acc(1,:)=Udd(:);
%
jj=1;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ndofp1=ndof+1;
%
for(i=2:nt)
    t(i)=(i-1)*dt;  
    if(ia==1)
%
        FP=zeros(ndof,1);
%       
        for(j=jj:nn)
%            out1=sprintf('i=%d j=%d nn=%d %8.4g  %8.4g  %8.4g ',i,j,nn,t(i),tf(j),tf(j+1));
%            disp(out1);         
            if(t(i)==tf(j))
 %               disp('type 1');
                FP(1:ndof)=F(j,2:ndofp1);
                jj=j;
                break;
            end
            if(j<nn)           
                if(t(i)>tf(j) && t(i)<tf(j+1))
  %                  disp('type 2');    
                    length=tf(j+1)-tf(j);
                    x=t(i)-tf(j);
                    c2=x/length;
                    c1=1-c2;
                    FP(1:ndof)=c1*F(j,2:ndofp1)+c2*F(j+1,2:ndofp1); 
                    jj=j;
                    break;
                end
            end
        end
%        out1=sprintf('%d  %8.4g  %8.4g ',i,FP(1),FP(2));
%        disp(out1);      
%
        FH=FP'+M*(a0*U+a2*Ud+a3*Udd)+C*(a1*U+a4*Ud+a5*Udd);
    else
        FH=  M*(a0*U+a2*Ud+a3*Udd)+C*(a1*U+a4*Ud+a5*Udd);       
    end
    Un=KH\FH;   
    Uddn=a0*(Un-U)-a2*Ud-a3*Udd;
    Udn=Ud+a6*Udd+a7*Uddn;
    U=Un;
    Ud=Udn;
    Udd=Uddn;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%    out1=sprintf('%d  %8.4g  %8.4g ',i,U(1),U(2));
%    disp(out1);
    dis(i,:)=U(:);
%
    vel(i,:)=Ud(:);
%
    acc(i,:)=Udd(:);    
%
end
figure(1);
plot(t,dis(:,1),'b',t,dis(:,2),'r');
title('Displacement');
xlabel('Time(sec)');
legend ('Mass 1','Mass 2'); 
grid on;
%
figure(2);
plot(t,vel(:,1),'b',t,vel(:,2),'r');
title('Velocity');
xlabel('Time(sec)');
legend ('Mass 1','Mass 2'); 
grid on;
%
figure(3);
plot(t,acc(:,1),'b',t,acc(:,2),'r');
title('Acceleration');
xlabel('Time(sec)');
legend ('Mass 1','Mass 2'); 
grid on;