disp(' ');
disp(' mdof_arb_force.m   ver 1.5  February 10, 2010 ');
disp(' ');
disp(' by Tom Irvine   Email: tomirvine@aol.com ');
disp(' ');
disp(' This program solves the following equation of motion: ');
disp('    M (d^2x/dt^2) + C (dx/dt)+ K x = f(T) ');
%
clear acc;
clear dis;
clear vel;
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
clear max;
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
[fn,omega,ModeShapes,MST]=Generalized_Eigen(k,m,1);
%
omegan=omega;
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
disp(' Select entry method:   ') 
disp('    1=sample rate ');
disp('    2=time step ');
ise=input(' ');
if(ise==1)
    disp(' Enter sr (samples/sec)');
    sr=input(' ');
    dt=1/sr;
else
    disp(' Enter dt (sec)');
    dt=input(' ');
    sr=1/dt;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    out1=sprintf(' Enter Force Vector at dof %d ?',i); 
    disp(out1);  
    disp('  1=yes  2=no ');
    ief=input(' ');
    if(ief==2)
        FI(1,1)= -1.;
        FI(1,2)=  0.;
        FI(2,1)= 10.;
        FI(2,2)=  0.;        
    else
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
    end    
    clear yi;
    clear max;
    if(max(FI(:,1))<max(t))
        sz=size(FI);
        msz=max(sz);
        FI(msz+1,1)=max(t);
        FI(msz+1,2)=0.;
    end
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
disp(' ');
disp(' Enter velocity calculation method: ');
disp('  1=digital recursive filtering ');
disp('  2=derivative of displacement ');
ivm=input(' ');
%
d=zeros(nt,num);
v=zeros(nt,num);
acc=zeros(nt,num);
%
clear progressbar
progressbar
for(i=1:nt)
progressbar(i/nt) % Update figure     
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
clear progressbar % Create figure and set starting time  
progressbar
%        
for(i=1:nt)
%
    progressbar(i/nt) % Update figure 
%
    if(ivm==1)
        for(j=1:num)
            n(j)= 2*C1(j)*CS(j)*nb(j) - C2(j)*nbb(j);
        end
%    
        for(j=1:num)
            clear sum1;
            sum1=0;
            for(ijk=1:num)
                sum1=sum1+QT(j,ijk)*f(i,ijk);
            end
            n(j)=n(j)+dt*sum1;
        end     
%
        if(i>=2)
%
            for(j=1:num)
                clear sum2;
                sum2=0;
                for(ijk=1:num)
                    sum2=sum2+QT(j,ijk)*f(i-1,ijk);
                end
                n(j)=n(j)+sum2*dt*C1(j)*(G(j)*SS(j)-CS(j) );
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
%
    else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ddt=12*dt;
        if(i==1)
            for(j=1:num)
                n(j)=0;
            end
        end
        if(i==2)
            for(j=1:num)
                n(j)=(-nd(j,3)+4*nd(j,2)-3*nd(j,1))/(2*dt);
            end           
        end
        if(i==3)
            for(j=1:num)
                n(j)=(-nd(j,4)+4*nd(j,3)-3*nd(j,2))/(2*dt);
            end           
        end
%
        if(i>=3 && i<=(nt-2))
            for(j=1:num)
                n(j)=( -nd(j,i+2) +8*nd(j,i+1) -8*nd(j,i-1) +nd(j,i-2) ) / ddt; 
            end           
        end
        if(i==(nt-1))
            for(j=1:num)  
               n(j)=(nd(j,i+1)-nd(j,i-1))/(2*dt);
            end               
        end
        if(i==nt)
            for(j=1:num)  
               n(j)=(nd(j,i)-nd(j,i-1))/dt;
            end               
        end        
%
        for(j=1:num)
            nv(j,i)=n(j);  
        end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    v(i,:)=(Q*nv(:,i))';     
end
clear progressbar;
progressbar % Create figure and set starting time 
%
%  acceleration
%
for(i=1:nt)
%    
    progressbar(i/nt) % Update figure 
    for(j=1:num)
        clear sum;
        sum=0;
        for(ijk=1:num)
            sum=sum+QT(j,ijk)*f(i,ijk);
        end
        na(j)=-2*damp(j)*omegan(j)*nv(j,i)-(omegan(j))^2*nd(j,i)+sum;
    end 
%    
   acc(i,:)=(Q*na')';    
%
end
%
if(iu==1)
    acc=acc/386;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Currently setup for 2 to 5 masses
%
figure(1);
if(num==2)
    plot(t,d(:,1),t,d(:,2));
    legend ('Mass 1','Mass 2');   
end
if(num==3)
    plot(t,d(:,1),t,d(:,2),t,d(:,3));
    legend ('Mass 1','Mass 2','Mass 3');   
end
if(num==4)
    plot(t,d(:,1),t,d(:,2),t,d(:,3),t,d(:,4));
    legend ('Mass 1','Mass 2','Mass 3','Mass 4');   
end
if(num==5)
    plot(t,d(:,1),t,d(:,2),t,d(:,3),t,d(:,4),t,d(:,5));
    legend ('Mass 1','Mass 2','Mass 3','Mass 4','Mass 5');   
end
xlabel('Time(sec)');
title('Displacement');
grid on;
if(iu==1)
    ylabel(' Displacement(in) ');
else
    ylabel(' Displacement(m) ');
end
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',11)
        h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',11)
         h = get(gca, 'ylabel');
    set(h, 'FontName', 'Arial','FontSize',11)   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);
if(num==2)
    plot(t,v(:,1),t,v(:,2));
    legend ('Mass 1','Mass 2');   
end
if(num==3)
    plot(t,v(:,1),t,v(:,2),t,v(:,3));
    legend ('Mass 1','Mass 2','Mass 3');   
end
if(num==4)
    plot(t,v(:,1),t,v(:,2),t,v(:,3),t,v(:,4));
    legend ('Mass 1','Mass 2','Mass 3','Mass 4');   
end
if(num==5)
    plot(t,v(:,1),t,v(:,2),t,v(:,3),t,v(:,4),t,v(:,5));
    legend ('Mass 1','Mass 2','Mass 3','Mass 4','Mass 5');   
end
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);
if(num==2)
    plot(t,acc(:,1),t,acc(:,2));
    legend ('Mass 1','Mass 2');   
end
if(num==3)
    plot(t,acc(:,1),t,acc(:,2),t,acc(:,3));
    legend ('Mass 1','Mass 2','Mass 3');   
end
if(num==4)
    plot(t,acc(:,1),t,acc(:,2),t,acc(:,3),t,acc(:,4));
    legend ('Mass 1','Mass 2','Mass 3','Mass 4');   
end
if(num==5)
    plot(t,acc(:,1),t,acc(:,2),t,acc(:,3),t,acc(:,4),t,acc(:,5));
    legend ('Mass 1','Mass 2','Mass 3','Mass 4','Mass 5');   
end
xlabel('Time(sec)');
title('Acceleration');
grid on;
if(iu==1)
    ylabel(' Accel(G) ');
else
    ylabel(' Accel(m/sec^2) ');
end
%
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',11)
        h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',11)
         h = get(gca, 'ylabel');
    set(h, 'FontName', 'Arial','FontSize',11) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Calculate damping coefficient matrix? ');
disp(' 1=yes  2=no ');
icm=input(' ');
%
if(icm==1)
    disp(' Enter method ');
    disp('  1=Rayleigh, proportional damping ');
    disp('  2=Fully populated damping matrix');
    idm=input(' ');
    if(idm==1)
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
    else
        for(i=1:num)
            vdm(i,i)=2*damp(i)*omegan(i);
        end
        c=inv(Q')*vdm*inv(Q)
    end
end