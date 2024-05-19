disp(' ');
disp(' mdof_reduced_arb_force_CB.m   ver 2.0  March 13, 2010 ');
disp(' ');
disp(' by Tom Irvine   Email: tomirvine@aol.com ');
disp(' ');
disp(' This program solves the following equation of motion: ');
disp('    M (d^2x/dt^2) + K x = 0 ');
disp('  ');
disp(' where M and K are reduced according to the users specification ');
disp(' ');
disp(' The discarded dof are brought back in using the Craig-Bampton method. ');
disp(' ');
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
size(m);
size(k);
%
num=max(size(m));
%
disp(' ');
disp(' The mass matrix is');
m
disp(' ');
disp(' The stiffness matrix is');
k
%
disp(' ');
iret=input(' Enter the number of degrees-of-freedom to retain: ');
disp(' ');
clear ret;
for(i=1:iret)
   ret(i)=input(' Enter retained dof number: ');
end
%
clear mr;
clear kr;
kr=zeros(iret,iret);
mr=zeros(iret,iret);
%
clear M11;
clear M12;
clear M21;
clear M22;
%
clear K11;
clear K12;
clear K21;
clear K22;
%
clear ngw;
ijk=iret+1;
ngw=zeros(num,1);
ngw(1:iret)=ret;
for(i=1:num)
    iflag=0;
    for(nv=1:iret)
      if(i==ret(nv))
          iflag=1;
      end
    end
    if(iflag==0)
        ngw(ijk)=i;
        ijk=ijk+1;
    end
end
%
%%%%%%%%%%%%%%%%%%%%% M11 K11 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ic=1;
for(i=1:num)
   iflag=0;          
   for(nv=1:iret)
      if(i==ret(nv))
         iflag=1;
         break;
      end
   end
   if(iflag==1)
      jc=1;      
      for(j=1:num)
          jflag=0;
          for(nv=1:iret)
             if(j==ret(nv))
                jflag=1;
                break;
             end   
          end
          if(jflag==1)
 %            out1=sprintf(' i=%d j=%d ic=%d jc=%d \n',i,j,ic,jc);
 %            disp(out1);             
             M11(ic,jc)=m(i,j);
             K11(ic,jc)=k(i,j);
             jc=jc+1;
          end
%         out1=sprintf(' i=%d j=%d iflag=%d jflag=%d \n',i,j,iflag,jflag);
%         disp(out1);
      end
   end
   if(iflag==1)
       ic=ic+1;
   end
end
%
%%%%%%%%%%%%%%%%%%%%% M12 K12 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ic=1;
for(i=1:num)
   iflag=0;          
   for(nv=1:iret)
      if(i==ret(nv))
         iflag=1;
         break;
      end
   end
   if(iflag==1)
      jc=1;      
      for(j=1:num)
          jflag=0;
          for(nv=1:iret)
             if(j==ret(nv))
                jflag=1;
                break;
             end   
          end
          if(jflag==0)
 %            out1=sprintf(' i=%d j=%d ic=%d jc=%d \n',i,j,ic,jc);
 %            disp(out1);             
             M12(ic,jc)=m(i,j);
             K12(ic,jc)=k(i,j);
             jc=jc+1;
          end
%         out1=sprintf(' i=%d j=%d iflag=%d jflag=%d \n',i,j,iflag,jflag);
%         disp(out1);
      end
   end
   if(iflag==1)
       ic=ic+1;
   end
end
%
%%%%%%%%%%%%%%%%%%%%% M21 K21 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ic=1;
for(i=1:num)
   iflag=0;          
   for(nv=1:iret)
      if(i==ret(nv))
         iflag=1;
         break;
      end
   end
   if(iflag==0)
      jc=1;      
      for(j=1:num)
          jflag=0;
          for(nv=1:iret)
             if(j==ret(nv))
                jflag=1;
                break;
             end   
          end
          if(jflag==1)
 %            out1=sprintf(' i=%d j=%d ic=%d jc=%d \n',i,j,ic,jc);
 %            disp(out1);             
             M21(ic,jc)=m(i,j);
             K21(ic,jc)=k(i,j);
             jc=jc+1;
          end
%         out1=sprintf(' i=%d j=%d iflag=%d jflag=%d \n',i,j,iflag,jflag);
%         disp(out1);
      end
   end
   if(iflag==0)
       ic=ic+1;
   end
end
%
%%%%%%%%%%%%%%%%%%%%%%% M22 K22 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ic=1;
for(i=1:num)
   iflag=0;          
   for(nv=1:iret)
      if(i==ret(nv))
         iflag=1;
         break;
      end
   end
   if(iflag==0)
      jc=1;      
      for(j=1:num)
          jflag=0;
          for(nv=1:iret)
             if(j==ret(nv))
                jflag=1;
                break;
             end   
          end
          if(jflag==0)
 %            out1=sprintf(' i=%d j=%d ic=%d jc=%d \n',i,j,ic,jc);
 %            disp(out1);             
             M22(ic,jc)=m(i,j);
             K22(ic,jc)=k(i,j);
             jc=jc+1;
          end
%         out1=sprintf(' i=%d j=%d iflag=%d jflag=%d \n',i,j,iflag,jflag);
%         disp(out1);
      end
   end
   if(iflag==0)
       ic=ic+1;
   end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% M11
%% if(iret<num)
%%    M12
%%    M21
%%    M22
%%end
%
%% K11
%% if(iret<num)
%%    K12
%%    K21
%%    K22
%% end
%
clear C;
clear CC;
%
d2=iret;
nmds=num-d2;
if(iret<num)
%%
    clear invK22;
    clear QQQ;
    disp(' ');
    disp(' Select submatrix inverse method ');
    disp(' 1=inv   2=pinv  3=backslash ');
    im=input(' ');
    if(im==1)
        invK22=inv(K22);
    end
    if(im==2)
        invK22=pinv(K22);
    end
    if(im==3)
        QQQ=eye(nmds,nmds);
        invK22=K22\QQQ;
    end
%%        
    CC=-invK22*K21;
end
for i=1:d2
    for j=1:d2
         C(i,j)=0;
    end
    C(i,i)=1;
end
for i=1:nmds
    for j=1:d2
         if(iret<num)
            C(i+d2,j)=CC(i,j);
         else
            C(i+d2,j)=0;    
         end
     end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[fn,omega,ModeShapes,MST]=Generalized_Eigen(K22,M22,1);
%
C(:,(d2+1):num)=0;
C((d2+1):num,(d2+1):num)=ModeShapes;
%
disp(' ');
disp(' Transformation Matrix ');
C
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Calculate eigenvalues and eigenvectors
%
clear mq;
clear kq;
clear m_partition;
clear k_partition;
%
m_partition(1:iret,1:iret)        =M11;
m_partition(1:iret,iret+1:num)    =M12;
m_partition(iret+1:num,1:iret)    =M21;
m_partition(iret+1:num,iret+1:num)=M22;
%
k_partition(1:iret,1:iret)        =K11;
k_partition(1:iret,iret+1:num)    =K12;
k_partition(iret+1:num,1:iret)    =K21;
k_partition(iret+1:num,iret+1:num)=K22;
%
disp(' Partitioned Matrices ');
%
m_partition
k_partition
%
disp(' Transformed matrices ');
%
mq=C'*m_partition*C
kq=C'*k_partition*C
%
[ModeShapes,Eigenvalues]=eig(kq,mq);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
omega = sqrt(Eigenvalues);
%
dof=max(size(kq));
disp(' Natural Frequencies (Hz)');
for(i=1:dof)
    fn(i)=omega(i,i)/(2*pi);
    out1=sprintf(' %8.4g ',fn(i));
    disp(out1);
end
omegan=(2*pi)*fn;
%
clear MST;
clear temp;
clear QTMQ;
%
MST=ModeShapes';
temp=zeros(dof,dof);
temp=mq*ModeShapes;
QTMQ=MST*temp;
%   
clear scale;
for(i=1:dof)
    scale(i)=1./sqrt(QTMQ(i,i));
    ModeShapes(:,i) = ModeShapes(:,i)*scale(i);    
end
%
MST=ModeShapes';
%
disp(' ');
disp('  Modes Shapes (column format)');
ModeShapes
%
disp(' ');
disp(' node switch vector ');
ngw'
%
clear MS_switched
MS_switched=C*ModeShapes
%
clear MS_ordered;
MS_ordered=zeros(num,dof);
%
for(i=1:num)
    for(j=1:dof)
        MS_ordered(ngw(i),j)=MS_switched(i,j);
    end    
end
disp(' ');
disp(' Modeshapes with original dof order ');
MS_ordered
%
disp(' Mass Normalized Modeshapes with original dof order ');
%
clear MSTT;
clear temp;
clear QTMQ;
clear MN_MS_ordered;
%
MSTT=MS_ordered';
temp=zeros(dof,dof);
temp=m*MS_ordered;
QTMQ=MSTT*temp;
%   
clear scale;
for(i=1:dof)
    scale(i)=1./sqrt(QTMQ(i,i));
    MN_MS_ordered(:,i) = MS_ordered(:,i)*scale(i);    
end
%
MN_MS_ordered
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%      ModeShapes, omegan, ngw, C
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
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
    out1=sprintf(' Enter Force Vector at dof %d ?',ngw(i));   % switched order
    disp(out1);  
    disp('  1=yes  2=no ');
    ief=input(' ');
    if(ief==2)
        FI(1,1)= -1.;
        FI(1,2)=  0.;
        FI(2,1)= 10.;
        FI(2,2)=  0.;        
    else
 %       out1=sprintf(' Force Vector at dof %d',ngw(i));   % switched order
 %       disp(out1);       
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
    end
%    
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
clear Cf;
Cf=C'*f';
Cf=Cf';
%%
%
if(sr<10*max(fn))
    disp(' ');
    disp(' Warning: insufficient sample rate. ');
end
%
clear omegad;
for(i=1:dof)
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
nbb=zeros(dof,1);
nb =zeros(dof,1);
%
for(i=1:dof)
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
d=zeros(nt,dof);
v=zeros(nt,dof);
acc=zeros(nt,num);
%
clear dbt;
clear vbt;
clear abt;
clear acc_switched;
clear v_switched;
clear d_switched;
%
dbt=zeros(nt,dof);
vbt=zeros(nt,dof);
abt=zeros(nt,dof);
%
clear progressbar
progressbar
for(i=1:nt)
progressbar(i/nt) % Update figure     
%    
    for(j=1:dof)
        n(j)= 2*C1(j)*CS(j)*nb(j) - C2(j)*nbb(j);
    end
%
    if(i>=2)
        for(j=1:dof)
            clear sum;
            sum=0;
            for(ijk=1:dof)
                sum=sum+QT(j,ijk)*Cf(i-1,ijk);
            end
            n(j)=n(j)+sum*dom(j)*C1(j)*SS(j);
        end   
    end
%
    for(j=1:dof)
        nbb(j)=nb(j);
        nb(j)=n(j);
    end
%
   for(j=1:dof)
        nd(j,i)=n(j);  
   end
%
   dbt(i,:)=(Q*nd(:,i))'; 
%
end
%
d_switched=(C*dbt')';
%
clear G;
for(j=1:dof)
    G(j)=-damp(j)*omegan(j)/omegad(j);
end
%
%  velocity
%
nbb=zeros(dof,1);
nb =zeros(dof,1);
%
clear progressbar % Create figure and set starting time  
progressbar
%        
for(i=1:nt)
%
    progressbar(i/nt) % Update figure 
%
    if(ivm==1)
        for(j=1:dof)
            n(j)= 2*C1(j)*CS(j)*nb(j) - C2(j)*nbb(j);
        end
%    
        for(j=1:dof)
            clear sum1;
            sum1=0;
            for(ijk=1:dof)
                sum1=sum1+QT(j,ijk)*Cf(i,ijk);
            end
            n(j)=n(j)+dt*sum1;
        end     
%
        if(i>=2)
%
            for(j=1:dof)
                clear sum2;
                sum2=0;
                for(ijk=1:dof)
                    sum2=sum2+QT(j,ijk)*Cf(i-1,ijk);
                end
                n(j)=n(j)+sum2*dt*C1(j)*(G(j)*SS(j)-CS(j) );
            end                  
%        
        end
%
        for(j=1:dof)
            nbb(j)=nb(j);
            nb(j)=n(j);
        end
%
        for(j=1:dof)
            nv(j,i)=n(j);  
        end
%
    else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ddt=12*dt;
        if(i==1)
            for(j=1:dof)
                n(j)=0;
            end
        end
        if(i==2)
            for(j=1:dof)
                n(j)=(-nd(j,3)+4*nd(j,2)-3*nd(j,1))/(2*dt);
            end           
        end
        if(i==3)
            for(j=1:dof)
                n(j)=(-nd(j,4)+4*nd(j,3)-3*nd(j,2))/(2*dt);
            end           
        end
%
        if(i>=3 && i<=(nt-2))
            for(j=1:dof)
                n(j)=( -nd(j,i+2) +8*nd(j,i+1) -8*nd(j,i-1) +nd(j,i-2) ) / ddt; 
            end           
        end
        if(i==(nt-1))
            for(j=1:dof)  
               n(j)=(nd(j,i+1)-nd(j,i-1))/(2*dt);
            end               
        end
        if(i==nt)
            for(j=1:dof)  
               n(j)=(nd(j,i)-nd(j,i-1))/dt;
            end               
        end        
%
        for(j=1:dof)
            nv(j,i)=n(j);  
        end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    vbt(i,:)=(Q*nv(:,i))';     
end
v_switched=(C*vbt')';
clear progressbar;
progressbar % Create figure and set starting time 
%
%  acceleration
%
for(i=1:nt)
%    
    progressbar(i/nt) % Update figure 
    for(j=1:dof)
        clear sum;
        sum=0;
        for(ijk=1:dof)
            sum=sum+QT(j,ijk)*Cf(i,ijk);
        end
        na(j)=-2*damp(j)*omegan(j)*nv(j,i)-(omegan(j))^2*nd(j,i)+sum;
    end 
%    
   abt(i,:)=(Q*na')';    
%
end
%
acc_switched=(C*abt')';
%
clear acc;
clear v;
clear d;
%
for(i=1:num)
    for(j=1:nt)
        d(j,ngw(i))=d_switched(j,i);        
        v(j,ngw(i))=v_switched(j,i);     
        acc(j,ngw(i))=acc_switched(j,i);
    end    
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear xt;
xt=1:num;
figure(4);
if(dof==2)
    plot(xt,MN_MS_ordered(:,1),xt,MN_MS_ordered(:,2));
    title('Mass-Normalized Modeshapes');
    xlabel('dof');
    grid on;
    legend ('Mode 1','Mode 2');
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',11)
        h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',11)
end
if(dof==3)
    plot(xt,MN_MS_ordered(:,1),xt,MN_MS_ordered(:,2),xt,MN_MS_ordered(:,3));
    title('Mass-Normalized Modeshapes');
    xlabel('dof');
    grid on;
    legend ('Mode 1','Mode 2','Mode 3');
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',11)
        h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',11)
end
clear xc;
xc=1:dof;
figure(5);
if(dof==2)
    plot(xc,ModeShapes(:,1),xc,ModeShapes(:,2));
    title('Constraint Modeshapes');
    xlabel('dof');
    grid on;
    legend ('Mode 1','Mode 2');
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',11)
        h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',11)
end    
if(dof==3)
    plot(xc,ModeShapes(:,1),xc,ModeShapes(:,2),xc,ModeShapes(:,3));
    title('Constraint Modeshapes');
    xlabel('dof');
    grid on;
    legend ('Mode 1','Mode 2','Mode 3');
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',11)
        h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',11)
end    