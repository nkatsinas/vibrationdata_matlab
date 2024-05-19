%
disp(' twodof_wavelet.m   ver 1.1  May 26, 2010');
disp(' by Tom Irvine  Email: tomirvine@aol.com ');
disp(' ');
%
disp(' This script calculates the response of a two-degree-of-freedom ');
disp(' system to a wavelet base input ');
disp(' ');
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
[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiff,mass,1);
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
disp(' ');
A=input(' Enter the wavelet amplitude (G) ');
%
f=input(' Enter wavelet frequency (Hz) ');
%
iflag=0;
while(iflag==0)
    N=input(' Enter number of half-sines, odd integer >=3 ');
%    
    for(i=3:2:100)
        if(N==i)
            iflag=1;
            break;
        end
    end
end
%
alpha=(N+1)*(2*pi*f)/N;
alpha2=alpha^2;
%
beta=(N-1)*(2*pi*f)/N;
beta2=beta^2;
%
B=A/2;
%
%%*************************************************************************
%
T=N/(2*f);
tpi=2*pi;
%
maxT=T+(5/fn(1));
%
fm=[alpha,beta,f,fn(2)];
maxf=max(fm);
dt=1/(maxf*40);
nt=round(maxT/dt);
last=nt;
%
aT=alpha*T;
bT=beta*T;
%
%   initialize coefficients
%
for(i=1:2)
    BB=-B*PF(i);    %
%
    omegan(i)=2*pi*fn(i);
    domegan(i)=damp(i)*omegan(i);
    omegan2(i)=omegan(i)^2;
    omegan3(i)=omegan(i)^3;
    omegad(i)=omegan(i)*sqrt(1-damp(i)^2);
%
    da=(alpha2-omegan2(i))^2 + (2*damp(i)*alpha*omegan(i))^2;
    db=(beta2 -omegan2(i))^2 + (2*damp(i)*beta*omegan(i))^2;
%
    C1(i)=-BB*(alpha2-omegan2(i))/da;
    C2(i)= BB*(2*damp(i)*alpha2*omegan(i))/da;
    C3(i)=-C1(i);
    C4(i)= BB*(-2*damp(i)*omegan3(i))/da;
%
    C5(i)= BB*(beta2-omegan2(i))/db;
    C6(i)=-BB*(2*damp(i)*beta2*omegan(i))/db;
    C7(i)=-C5(i);
    C8(i)= BB*(2*damp(i)*omegan3(i))/db;
%
    C10(i)=C3(i)+C7(i);
    C11(i)=C4(i)+C8(i);
%
    C20(i)=C11(i)-domegan(i)*C10(i);
%
    omdT=omegad(i)*T;
    expdt=exp(-domegan(i)*T);
%
    rd1(i)=C1(i)*cos(aT)+(C2(i)/alpha)*sin(aT);  
    rd2(i)=C5(i)*cos(bT)+ (C6(i)/beta)*sin(bT); 
    rd3(i)=expdt*(C10(i)*cos(omdT)+(1/omegad(i))*C20(i)*sin(omdT));
    rdT(i)=rd1(i)+rd2(i)+rd3(i);
%
    rv1(i)=( -alpha*C1(i)*sin(aT) + C2(i)*cos(aT) );
    rv2(i)=(  -beta*C5(i)*sin(bT) + C6(i)*cos(bT) );
    rv3(i)=-domegan(i)*rd3(i);
    rv4(i)= expdt*(-omegad(i)*C10(i)*sin(omdT) + C20(i)*cos(omdT));
    rvT(i)=rv1(i)+rv2(i)+rv3(i)+rv4(i);
%
end
%
clear ax;
clear rd;
clear rv;
clear tx;
clear base;
%
for(j=1:2)
for(i=1:last)
    t=dt*(i-1);
    acc=0;
%    
    if(t<T)
        at=alpha*t;
        bt= beta*t;
        omdt=omegad(j)*t;
        expdt=exp(-domegan(j)*t);
%
        base(i)= B*cos(at)-B*cos(bt);
%
        rd1=C1(j)*cos(at)+(C2(j)/alpha)*sin(at);  
        rd2=C5(j)*cos(bt)+ (C6(j)/beta)*sin(bt); 
        rd3=expdt*(C10(j)*cos(omdt)+(1/omegad(j))*C20(j)*sin(omdt));
        rd(i,j)=rd1+rd2+rd3;
%
        rv1=( -alpha*C1(j)*sin(at) + C2(j)*cos(at) );
        rv2=(  -beta*C5(j)*sin(bt) + C6(j)*cos(bt) );
        rv3=-domegan(j)*rd3;
        rv4= expdt*(-omegad(j)*C10(j)*sin(omdt) + C20(j)*cos(omdt));
        rv(i,j)=rv1+rv2+rv3+rv4;
%
        ra1=( -alpha^2*C1(j)*cos(at) - alpha*C2(j)*sin(at) );
        ra2=(  -beta^2*C5(j)*cos(bt) - beta*C6(j)*sin(bt) );
        ra3=(domegan(j))^2*rd3;
        ra4=-domegan(j)*rv4;
        ra5= omegad(j)*expdt*(-omegad(j)*C10(j)*cos(omdt) - C20(j)*sin(omdt)); 
        ra(i,j)=ra1+ra2+ra3+ra4+ra5;
%
    else
        tt=t-T;
        omdtt=omegad(j)*tt;
        expdtt=exp(-domegan(j)*tt);
        base(i)=0;      
%        
        rd(i,j)=expdtt*( rdT(j)*cos(omdtt)+ ((rvT(j) + domegan*rdT(j))/omegad)*sin(omdtt) );
%        
        rv(i,j)=-domegan(j)*rd(i,j)+omegad(j)*expdtt*( -rdT(j)*sin(omdtt)+ ((rvT(j) + domegan(j)*rdT(j))/omegad(j))*cos(omdtt) );
%
        ra(i,j)=-2*domegan(j)*rv(i,j)-(omegan(j))^2*rd(i,j);
%
    end   
%    
    if(j==1)
       tx(i)=t;
    end
%
end  % end i  time
end  % end j  modes
%
clear disp_rel;
clear acc_rel;
%
disp_rel=zeros(nt,2);
acc_rel=zeros(nt,2);
%
for(i=1:nt)
   disp_rel(i,:)=(ModeShapes*(rd(i,:))')';
    acc_rel(i,:)=(ModeShapes*(ra(i,:))')';
%
    ax(i,:)=acc_rel(i,:)+base(i);
%
end
%
if(iu==1)
%    
   figure(1);
   disp_rel=disp_rel*386;
   plot(tx,disp_rel(:,1),tx,disp_rel(:,2));
   legend ('dof 1','dof 2');   
   xlabel('Time(sec)');
   ylabel('Rel Disp (in)');
   grid on;
%
   figure(2);
   plot(tx,base,tx,ax(:,1),tx,ax(:,2));
   legend ('Input','dof 1','dof 2');  
   xlabel('Time(sec)');
   ylabel('Accel(G)');
   grid on;
%
else
%    
   figure(1);
   disp_rel=disp_rel/1000;
   plot(tx,disp_rel(:,1),tx,disp_rel(:,2));
   legend ('dof 1','dof 2');   
   xlabel('Time(sec)');
   ylabel('Rel Disp (mm)');
   grid on;
%
   figure(2);
   ax=ax/9.81;
   plot(tx,base,tx,ax(:,1),tx,ax(:,2));
   legend ('Input','dof 1','dof 2');    
   xlabel('Time(sec)');
   ylabel('Accel(G)');
   grid on;
%
end
disp(' ');
disp(' dof 1 ');
out1=sprintf(' maximum acceleration = %6.3g G',max(ax(:,1)));
disp(out1);
out1=sprintf(' minimum acceleration = %6.3g G',min(ax(:,1)));
disp(out1);
%
disp(' ');
disp(' dof 2 ');
out1=sprintf(' maximum acceleration = %6.3g G',max(ax(:,2)));
disp(out1);
out1=sprintf(' minimum acceleration = %6.3g G',min(ax(:,2)));
disp(out1);
%
clear acceleration;
clear relative_displacement;
%
disp(' ');
disp(' The output data files are: ');
disp('   relative_displacement ');
disp('   acceleration ');
%
acceleration=[tx',base',ax(:,1),ax(:,2)];
relative_displacement=[tx',disp_rel(:,1),disp_rel(:,2)];
%