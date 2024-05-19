disp(' ');
disp('  enforced_acceleration.m  ver 2.4  October 29, 2013 ');
disp('  by Tom Irvine ');
%
%
clear Mdd;  % driven
clear Mdf;
clear Mfd;
clear Mff;  % free
%
clear Mdw;
clear Mwd;
clear Mww;
%
clear MP;
clear MT;
%
clear Kdd;  
clear Kdf;
clear Kfd;
clear Kff;
%
clear invKff;
%
clear Kww;
%
clear KP;
clear KT;
%
clear n;
clear na;
clear nv;
clear nd;
%
clear m;
clear k;
%
clear TT;
clear T1;
clear T2;
%
clear I;
clear Idd;
clear Iff;
%
clear damp;
clear ea;
clear f;
clear ngw;
%
clear ttend;
clear ttstart;
%
close all;
%
disp(' ');
disp(' Enter the units system ');
disp(' 1=English: G, in/sec, in'); 
disp(' 2= metric: G,  m/sec, mm');
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' Select modal damping input method ');
disp('  1=uniform damping for all modes ');
disp('  2=damping vector ');
idm=input(' ');
%
disp(' ');
if(idm==1)
   disp(' Enter damping ratio ');
   dampr=input(' ');
   damp(1:num)=dampr;
else
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
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sz=size(mass);
dof=(sz(1));
num=dof;
%
out1=sprintf('\n number of dofs =%d \n',num);
disp(out1);
%
disp(' ');
disp(' How many of these dof are rotational? ');
nrot=input(' ');
%
if(nrot>=1)
%
    rot=zeros(nrot,1);
    for i=1:nrot
        out1=sprintf(' Enter a rotational dof number: ');
        rot(i)=input(out1);
    end    
%    
end
%
disp(' ');
disp(' Enter the starting time (sec) ');
tstart=input(' ');
disp(' ');
disp(' Enter the end time (sec) ');
tend=input(' ');
disp(' ');
disp(' Enter the sample rate (samples/sec)');
sr=input(' ');
dt=1/sr;
nt=1+round((tend-tstart)/dt);
%
t =  linspace(tstart,tend,nt);
t=t';
%
nkk=4;
if(num<nkk)nkk=num;end
disp(' ');
out1=sprintf(' Enter the number of dofs with enforced acceleration. (min=1, max=%d) ',nkk);
disp(out1)
%
nem=input(' ');
if(nem>4)nem=4;end
%
nff=num-nem;
%
disp(' ');
disp(' Each enforced acceleration input should be translational. ');
disp(' ');
disp(' Each input file must have two columns: time & acceleration (G) ');
disp(' ');
%
clear dvelox;
clear ddisp;
%
f=zeros(nt,nem);
size(f)

for ijk=1:nem
    if(ijk==1)disp(' Enter the first dof  ');end
    if(ijk==2)disp(' Enter the second dof ');end
    if(ijk==3)disp(' Enter the third dof  ');end
    if(ijk==4)disp(' Enter the fourth dof ');end
    ea(ijk)=input(' ');
%    
    disp(' Enter the applied acceleration input array name for this dof.   ')    
    clear FI;
    clear yi;
    clear max;
    clear L;   
    FI=input('');
%
    if(iu==1)
        FI(:,2)=FI(:,2)*386;        
    else
        FI(:,2)=FI(:,2)*9.81;        
    end
%
    L=length(FI(:,1));
    jmin=1;
    for i=1:nt

        for j=jmin:L
            if(t(i)==FI(j,1))
                f(i,ijk)=FI(j,2);
                jmin=j;
                break;
            end
            if(j>=2 && FI(j-1,1) < t(i) && t(i) < FI(j,1) )
                    l=FI(j,1)-FI(j-1,1);
                    x=t(i)-FI(j-1,1);
                    c2=x/l;
                    c1=1-c2;
                    f(i,ijk)=c1*FI(j-1,2)+ c2*FI(j,2);
                    jmin=j;
                break;
            end
        end
    end
%
    [dvelox(:,ijk)]=integrate_function(f(:,ijk),dt);
     [ddisp(:,ijk)]=integrate_function(dvelox(:,ijk),dt);
%
end
%
%  Track changes
%
ijk=nem+1;
ngw=zeros(num,1);
ngw(1:nem)=ea;
for i=1:num
    iflag=0;
    for nv=1:nem
      if(i==ea(nv))
          iflag=1;
      end
    end
    if(iflag==0)
        ngw(ijk)=i;
        ijk=ijk+1;
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Display partitioned matrices?  1=yes 2=no ');
dtype=input(' ');
%
etype=1;  % enforced acceleration
[TT,T1,T2,Mwd,Mww,Kwd,Kww]=enforced_partition_matrices(num,ea,mass,stiff,etype,dtype);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
[fn,omega,ModeShapes,MST]=Generalized_Eigen(Kww,Mww,1);
%
omegan=omega;
%
clear r;
clear part;
clear ModalMass;
%
r=ones(nff,1);
%
part = MST*Mww*r;
%
disp(' Participation Factors  ');
part
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Modal Transient
%
clear omegad;
omegad=zeros(nff,1);
for i=1:nff
    omegad(i)=omegan(i)*sqrt(1-damp(i)^2);
end
%
clear Q;
Q=ModeShapes;
QT=Q';
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  displacement
%
%  d
%  v
%  acc
%
%%
forig=f;
%%
n=max(size(Q));
%
num_modes=n;
%
FP=zeros(num_modes,nt);
%
for i=1:nt
    t(i)=(i-1)*dt; 
    ff=f(i,:);
    FP(:,i)=-QT*Mwd*ff';    
end    
%
num_modes=n;
%
nx=zeros(nt,num_modes);
nv=zeros(nt,num_modes);
na=zeros(nt,num_modes);
%
[a1,a2,df1,df2,df3,vf1,vf2,vf3,af1,af2,af3]=...
              ramp_invariant_filter_coefficients(num_modes,omegan,damp,dt);
%
for j=1:num_modes
%
    amodal=FP(j,:);
%
%  displacement
%
    d_forward=[   df1(j),  df2(j), df3(j) ];
    d_back   =[     1, -a1(j), -a2(j) ];
    d_resp=filter(d_forward,d_back,amodal);
%    
%  velocity
%
    v_forward=[   vf1(j),  vf2(j), vf3(j) ];
    v_back   =[     1, -a1(j), -a2(j) ];
    v_resp=filter(v_forward,v_back,amodal);
%    
%  acceleration
%   
    a_forward=[   af1(j),  af2(j), af3(j) ];
    a_back   =[     1, -a1(j), -a2(j) ]; 
    a_resp=filter(a_forward,a_back,amodal);
%
    nx(:,j)=d_resp;  % displacement
    nv(:,j)=v_resp;  % velocity
    na(:,j)=a_resp;  % acceleration  
%
end
%
clear d_resp;
clear v_resp;
clear a_resp;
%
disp(' Calculate d');
d=zeros(nt,num_modes);
for i=1:nt
      d(i,:)=(Q*(nx(i,:))')';  
end
clear nx;
%
disp(' Calculate v');
v=zeros(nt,num_modes);
for i=1:nt
      v(i,:)=(Q*(nv(i,:))')';
end
clear nv;
%
disp(' Calculate a');
a=zeros(nt,num_modes);
for i=1:nt
    a(i,:)=(Q*(na(i,:))')';    
end
clear na;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear d_save;
clear v_save;
clear a_save;
d_save=d;
v_save=v;
a_save=a;
%
%    Transformation back to xd xf
%
clear dT;
clear vT;
clear accT;
%
a=fix_size(a);
v=fix_size(v);
d=fix_size(d);
%
ddisp=fix_size(ddisp);
dvelox=fix_size(dvelox);
forig=fix_size(forig);
%
dT=T1*ddisp' + T2*d';
vT=T1*dvelox' + T2*v';
accT=T1*forig' + T2*a';
%
%  Put in original order
%
clear ZdT;
clear ZvT;
clear ZaccT;
%
ZdT=[ ddisp  dT' ];
ZvT=[ dvelox  vT' ];
ZaccT=[ forig  accT' ];
%
clear d;   
clear v;
clear a;
clear acc;
d=zeros(nt,num);
v=zeros(nt,num);
acc=zeros(nt,num);
%
for i=1:num
   for j=1:nt
        d(j,ngw(i))=  (ZdT(j,i));        
        v(j,ngw(i))=  (ZvT(j,i));     
      acc(j,ngw(i))=(ZaccT(j,i));
   end
end
%
clear ea_disp;
clear ea_vel;
clear ea_acc;
%
if(iu==1)
   acc=acc/386;
else
   acc=acc/9.81;
   d=d/1000;
end
%
ea_disp=[t d];
ea_vel=[t v];
ea_acc=[t acc];
%
disp(' ');
disp(' Output arrays: ');
disp('  ea_disp - displacement');
disp('  ea_vel  - velocity');
disp('  ea_acc  - acceleration');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
fig_num=1;
if(num<=10)
   figure(fig_num);
   fig_num=fig_num+1;
   hold all;
   for i=1:num
       iflag=0;
       for j=1:nrot
           if(i==rot(j))
               iflag=1;
               break;
           end
       end 
       if(iflag==0)
           out4=sprintf('dof %d',i);
           plot(t,d(:,i),'DisplayName',out4);
           legend('-DynamicLegend');
       end
   end 
end
hold off;
%
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
%
if(num<=10)
   figure(fig_num);
   fig_num=fig_num+1;
   hold all;
   for i=1:num
       iflag=0;
       for j=1:nrot
           if(i==rot(j))
               iflag=1;
               break;
           end
       end 
       if(iflag==0)
           out4=sprintf('dof %d',i);
           plot(t,v(:,i),'DisplayName',out4);
           legend('-DynamicLegend');
       end
   end 
end
hold off;
%
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
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(num<=10)
   figure(fig_num);
   fig_num=fig_num+1;
   hold all;
   for i=1:num
       iflag=0;
       for j=1:nrot
           if(i==rot(j))
               iflag=1;
               break;
           end
       end 
       if(iflag==0)
           out4=sprintf('dof %d',i);
           plot(t,acc(:,i),'DisplayName',out4);
           legend('-DynamicLegend');
       end
   end 
end
hold off;
%
%
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
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(num>10)
    while(1)
        disp(' ');
        ipa=input(' Plot acceleration?  1=yes 2=no ');
        if(ipa==2)
            break;
        else
            disp(' ');
            i=input(' Enter dof ');
%
            iflag=0;
            for j=1:nrot
                if(i==rot(j))
                    iflag=1;
                    break;
                end
            end 
%
            figure(fig_num);
            fig_num=fig_num+1;
            out4=sprintf('Acceleration  dof %d',i);
            plot(t,acc(:,i));
            grid on;
            title(out4);
            if(iflag==0)
                ylabel('Accel(G)');
            end           
            if(iflag==1)
                ylabel('Accel(rad/sec^2)');
            end           
            xlabel('Time(sec)');
            h = get(gca, 'title');
            set(h, 'FontName', 'Arial','FontSize',11)
            h = get(gca, 'xlabel');
            set(h, 'FontName', 'Arial','FontSize',11)
            h = get(gca, 'ylabel');
            set(h, 'FontName', 'Arial','FontSize',11)             
%
        end    
    end    
end    