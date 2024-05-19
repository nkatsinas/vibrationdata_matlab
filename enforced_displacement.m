disp(' ');
disp('  enforced_displacement.m  ver 1.4  May 3, 2010 ');
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
out1=sprintf(' Enter the number of dofs with enforced displacement. (maximum = %d) ',nkk);
disp(out1)
%
nem=input(' ');
if(nem>4)nem=4;end
%
nff=num-nem;
%
disp(' ');
disp(' Each input file must have two columns: time & displacement ');
disp(' ');
%
clear daccel;
clear dvelox;
clear ddisp;
%
for(ijk=1:nem)
    if(ijk==1)disp(' Enter the first dof  ');end
    if(ijk==2)disp(' Enter the second dof ');end
    if(ijk==3)disp(' Enter the third dof  ');end
    if(ijk==4)disp(' Enter the fourth dof ');end
    ea(ijk)=input(' ');
%    
    disp(' Enter the applied displacement input matrix name for this dof.   ')    
    clear FI;
    clear yi;
    clear max;
    clear L;   
    FI=input(''); 
    L=length(FI(:,1));
    jmin=1;
    for(i=1:nt)  
        f(i,ijk)=0;
        for(j=jmin:L)
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
    ddisp(:,ijk)=f(:,ijk);
%
    clear y;
    clear n;
    y=f(:,ijk);
    a=y;  
%%%
    disp(' ');
    disp(' Enter lowpass filter frequency (Hz) for displacement. ');
    disp(' (This only effects the velocity and acceleration at the enforced locations.) ');
    hpf=input(' ');
%%%
        sr=1/dt;
        if(hpf>sr/3.)hpf=sr/3.;end
        x = sr/hpf;
		yy=0.695*x + 1.76;
%
		for(i=1:20001)
            j=2*i+1;
			if( yy == double(j))
				w=i;
				break;
            end
            if( yy>=double(j) && yy<=double(j+2))
				w=i;
				break;
            end
        end
%
        out1=sprintf('\n w=%d \n',w);
        disp(out1);
%
        k=fix(double(w-1)/2.);
%
        last=nt;
%
            for(i=1:last)
%
                ave=0.;
                n=0;
%
                for(j=(i-k):(i+k))
%
                    if(j>=1 && j<=last )
%
                        ave=ave+a(j);
                        n=n+1;
                    end 
                end
                if(n>1)
                    a(i)=ave/double(n);
                end
            end
 %
            y=a';   
%%%
    n=nt;
    ddt=12.*dt;
%
	dvelox(1,ijk)=( -y(3)+4.*y(2)-3.*y(1) )/(2.*dt);
	dvelox(2,ijk)=( -y(4)+4.*y(3)-3.*y(2) )/(2.*dt);
%  	
    dvelox(3:(n-2),ijk)=(-y(5:n)+8*y(4:(n-1))-8*y(2:(n-3))+y(1:(n-4)))/ddt;
%
    dvelox(n-1,ijk)=( +y(n-1)-y(n-3) )/(2.*dt);
    dvelox(n,ijk)  =( +y(n-1)-y(n-2) )/dt;
%%%
            clear a;
            a=dvelox(:,ijk);   
            for(i=1:last)
%
                ave=0.;
                n=0;
%
                for(j=(i-k):(i+k))
%
                    if(j>=1 && j<=last )
%
                        ave=ave+a(j);
                        n=n+1;
                    end 
                end
                if(n>1)
                    a(i)=ave/double(n);
                end
            end
 %
            y=a';   
            clear dvelox;
            dvelox(:,ijk)=y;
%%%
    clear y;
    y=dvelox(:,ijk);
    n=nt;
%
	daccel(1,ijk)=( -y(3)+4.*y(2)-3.*y(1) )/(2.*dt);
	daccel(2,ijk)=( -y(4)+4.*y(3)-3.*y(2) )/(2.*dt);
%  	
    daccel(3:(n-2),ijk)=(-y(5:n)+8*y(4:(n-1))-8*y(2:(n-3))+y(1:(n-4)))/ddt;
%
    daccel(n-1,ijk)=( +y(n-1)-y(n-3) )/(2.*dt);
    daccel(n,ijk)  =( +y(n-1)-y(n-2) )/dt; 
%
    clear n;
end
%
%  Track changes
%
ijk=nem+1;
ngw=zeros(num,1);
ngw(1:nem)=ea;
for(i=1:num)
    iflag=0;
    for(nv=1:nem)
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Partition Mass & Stiffness Matrices
%
%%%%%%%%%%%%%%%%%%%%% Mdd Kdd %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ic=1;
for(i=1:num)
   iflag=0;          
   for(nv=1:nem)
      if(i==ea(nv))
         iflag=1;
         break;
      end
   end
   if(iflag==1)
      jc=1;      
      for(j=1:num)
          jflag=0;
          for(nv=1:nem)
             if(j==ea(nv))
                jflag=1;
                break;
             end   
          end
          if(jflag==1)             
             Mdd(ic,jc)=mass(i,j);
             Kdd(ic,jc)=stiff(i,j);
             jc=jc+1;
          end
      end
   end
   if(iflag==1)
       ic=ic+1;
   end
end
%
%%%%%%%%%%%%%%%%%%%%% Mdf Kdf %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ic=1;
for(i=1:num)
   iflag=0;          
   for(nv=1:nem)
      if(i==ea(nv))
         iflag=1;
         break;
      end
   end
   if(iflag==1)
      jc=1;      
      for(j=1:num)
          jflag=0;
          for(nv=1:nem)
             if(j==ea(nv))
                jflag=1;
                break;
             end   
          end
          if(jflag==0)            
             Mdf(ic,jc)=mass(i,j);
             Kdf(ic,jc)=stiff(i,j);
             jc=jc+1;
          end
      end
   end
   if(iflag==1)
       ic=ic+1;
   end
end
%
%%%%%%%%%%%%%%%%%%%%% Mfd Kfd %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ic=1;
for(i=1:num)
   iflag=0;          
   for(nv=1:nem)
      if(i==ea(nv))
         iflag=1;
         break;
      end
   end
   if(iflag==0)
      jc=1;      
      for(j=1:num)
          jflag=0;
          for(nv=1:nem)
             if(j==ea(nv))
                jflag=1;
                break;
             end   
          end
          if(jflag==1)             
             Mfd(ic,jc)=mass(i,j);
             Kfd(ic,jc)=stiff(i,j);
             jc=jc+1;
          end
      end
   end
   if(iflag==0)
       ic=ic+1;
   end
end
%
%%%%%%%%%%%%%%%%%%%%%%% Mff Kff %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ic=1;
for(i=1:num)
   iflag=0;          
   for(nv=1:nem)
      if(i==ea(nv))
         iflag=1;
         break;
      end
   end
   if(iflag==0)
      jc=1;      
      for(j=1:num)
          jflag=0;
          for(nv=1:nem)
             if(j==ea(nv))
                jflag=1;
                break;
             end   
          end
          if(jflag==0)     
             Mff(ic,jc)=mass(i,j);
             Kff(ic,jc)=stiff(i,j);
             jc=jc+1;
          end
      end
   end
   if(iflag==0)
       ic=ic+1;
   end
end
%
I=eye(nem,nem);
T2=eye(nff,nff);
nMff=max(size(Mff));
III=eye(nMff,nMff);
invMff=Mff\III;
%
T1=-invMff*Mfd;
%
TT=zeros(num,num);
%
TT(1:nem,1:nem)=I;
TT(nem+1:num,1:nem)=T1;
TT(nem+1:num,nem+1:num)=T2;
%
MP=zeros(num,num);
MP(1:nem,1:nem)=Mdd;
MP(1:nem,nem+1:num)=Mdf;
MP(nem+1:num,1:nem)=Mfd;
MP(nem+1:num,nem+1:num)=Mff;
%
KP=zeros(num,num);
KP(1:nem,1:nem)=Kdd;
KP(1:nem,nem+1:num)=Kdf;
KP(nem+1:num,1:nem)=Kfd;
KP(nem+1:num,nem+1:num)=Kff;
%
MT=TT'*MP*TT
%
KT=TT'*KP*TT
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[fn,omega,ModeShapes,MST]=Generalized_Eigen(KT,MT,1);
%
disp(' ');
clear Mwd;
clear Mww;
clear Kww;
%
Kwd=KT(nem+1:num,1:nem)
Kww=KT(nem+1:num,nem+1:num)
Mww=MT(nem+1:num,nem+1:num)
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Modal Transient
%
clear omegad;
for(i=1:nff)
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
clear C1;
clear C2;
clear CS;
clear SS;
clear dom;
%
nbb=zeros(num,1);
nb =zeros(num,1);
%
for(i=1:nff)
    C1(i)=exp(  -damp(i)*omegan(i)*dt);
    C2(i)=exp(-2*damp(i)*omegan(i)*dt);
    CS(i)=cos(omegad(i)*dt);
    SS(i)=sin(omegad(i)*dt);
    if(omegan(i)>1.0e-04)
       dom(i)=dt/omegad(i);
    else
       dom(i)=0.;
    end   
end
%
disp(' ');
disp(' Enter velocity calculation method: ');
disp('  1=digital recursive filtering ');
disp('  2=derivative of displacement ');
ivm=input(' ');
%
clear d;
clear v;
clear acc;
d=zeros(nt,nff);
v=zeros(nt,nff);
acc=zeros(nt,nff);
%
clear forig;
forig=f;
clear f;
f=(Kwd*forig')';
%
clear progressbar
progressbar
for(i=1:nt)
    clear n;
    progressbar(i/nt) % Update figure     
%    
    for(j=1:nff)
        if(omegan(j)>1.0e-04)
           n(j)= 2*C1(j)*CS(j)*nb(j) - C2(j)*nbb(j);
        else
           n(j)=0.;
        end
    end
%
    if(i>=2)
        for(j=1:nff)
            if(omegan(j)>1.0e-04)
               clear sum;
               sum=0;
               for(ijk=1:nem)
                   sum=sum+QT(j,ijk)*f(i-1,ijk);     
               end
               n(j)=n(j)+sum*dom(j)*C1(j)*SS(j);
           end
        end   
    end
%
    for(j=1:nff)
        nbb(j)=nb(j);
        nb(j)=n(j);
    end
%
   for(j=1:nff)
        nd(j,i)=n(j);
   end
%
   d(i,:)=(Q*nd(:,i))'; 
%
end
%
clear G; 
for(j=1:nff)
    G(j)=0;
    if(omegan(j)>1.0e-04)    
       G(j)=-damp(j)*omegan(j)/omegad(j);
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  velocity
%
nbb=zeros(nff,1);
nb =zeros(nff,1);
%
clear progressbar % Create figure and set starting time  
progressbar
%        
for(i=1:nt)
%
    clear n;
    progressbar(i/nt) % Update figure 
%
    if(ivm==1)
        for(j=1:nff)
            if(omegan(j)>1.0e-04)
                n(j)= 2*C1(j)*CS(j)*nb(j) - C2(j)*nbb(j);
            else
                n(j)=0;
            end    
        end
%    
        for(j=1:nff)
            clear sum1;
            sum1=0;
            for(ijk=1:nff)   
                   sum1=sum1+QT(j,ijk)*f(i,ijk);
            end
            n(j)=n(j)+dt*sum1;
        end     
%
        if(i>=2)
%
            for(j=1:nff)
                if(omegan(j)>1.0e-04)
                   clear sum2;
                   sum2=0;
                   for(ijk=1:nff)
                       sum2=sum2+QT(j,ijk)*f(i-1,ijk);
                   end
                   n(j)=n(j)+sum2*dt*C1(j)*(G(j)*SS(j)-CS(j) );
                end
            end                  
%        
        end
%
        for(j=1:nff)
            nbb(j)=nb(j);
            nb(j)=n(j);
        end
%
        for(j=1:nff)
            nv(j,i)=n(j);  
        end
%
    else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ddt=12*dt;
        if(i==1)
            for(j=1:nff)
                n(j)=0;
            end
        end
        if(i==2)
            for(j=1:nff)
                n(j)=(-nd(j,3)+4*nd(j,2)-3*nd(j,1))/(2*dt);
            end           
        end
        if(i==3)
            for(j=1:nff)
                n(j)=(-nd(j,4)+4*nd(j,3)-3*nd(j,2))/(2*dt);
            end           
        end
%
        if(i>=3 && i<=(nt-2))
            for(j=1:nff)
                n(j)=( -nd(j,i+2) +8*nd(j,i+1) -8*nd(j,i-1) +nd(j,i-2) ) / ddt; 
            end           
        end
        if(i==(nt-1))
            for(j=1:nff)  
               n(j)=(nd(j,i+1)-nd(j,i-1))/(2*dt);
            end               
        end
        if(i==nt)
            for(j=1:nff)  
               n(j)=(nd(j,i)-nd(j,i-1))/dt;
            end               
        end        
%
        for(j=1:nff)
            nv(j,i)=n(j);  
        end
%
    end
    v(i,:)=(Q*nv(:,i))';     
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear progressbar;
progressbar % Create figure and set starting time 
%
%  displacement
%
for(i=1:nt)
%    
    progressbar(i/nt) % Update figure 
    for(j=1:nff)
        clear sum;
        sum=0;
        for(ijk=1:nem)
              sum=sum+QT(j,ijk)*f(i,ijk);     
        end
        na(j)=-2*damp(j)*omegan(j)*nv(j,i)-(omegan(j))^2*nd(j,i)+sum;
    end 
%    
   acc(i,:)=(Q*na')';    
%
end
%
clear d_save;
clear v_save;
clear a_save;
d_save=d;
v_save=v;
a_save=acc;
%
%    Transformation back to xd xf
%
clear dT;
clear vT;
clear accT;
%
%%    dT=TT*d';
%%    vT=TT*v';
%%    accT=TT*acc';
%
sz=size(ddisp);
if(sz(1)>sz(2))ddisp=ddisp';end
sz=size(d);
if(sz(1)>sz(2))d=d';end
dT=T1*ddisp + T2*d;
%
sz=size(dvelox);
if(sz(1)>sz(2))dvelox=dvelox';end
sz=size(v);
if(sz(1)>sz(2))v=v';end
vT=T1*dvelox + T2*v;
%
sz=size(forig);
if(sz(1)>sz(2))forig=forig';end
sz=size(acc);
if(sz(1)>sz(2))acc=acc';end
accT=T1*forig + T2*acc;
%
%  Put in original order
%
clear ZdT;
clear ZvT;
clear ZaccT;
%
ZdT=[ forig ; dT ];
ZvT=[ dvelox ; vT ];
ZaccT=[ daccel' ; accT ];
%
clear d;   
clear v;
clear acc;
d=zeros(nt,num);
v=zeros(nt,num);
acc=zeros(nt,num);
%
for(i=1:num)
   for(j=1:nt)
        d(j,ngw(i))=  (ZdT(i,j));        
        v(j,ngw(i))=  (ZvT(i,j));     
      acc(j,ngw(i))=(ZaccT(i,j));
   end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Currently setup for 2 to 5 masses
%
if(num==2)
    figure(1);
    plot(t,d(:,1),t,d(:,2));
    legend ('dof 1','dof  2');   
end
if(num==3)
    figure(1);
    plot(t,d(:,1),t,d(:,2),t,d(:,3));
    legend ('dof  1','dof  2','dof  3');   
end
if(num==4)
    figure(1);
    plot(t,d(:,1),t,d(:,2),t,d(:,3),t,d(:,4));
    legend ('dof  1','dof  2','dof  3','dof  4');   
end
if(num==5)
    figure(1);
    plot(t,d(:,1),t,d(:,2),t,d(:,3),t,d(:,4),t,d(:,5));
    legend ('dof  1','dof  2','dof  3','dof  4','dof  5');   
end
if(num>5)
   disp(' ');
   disp(' Enter a dof number for displacement plot ');
   idof=input(' ');
   plot(t,d(:,idof));
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
if(num==2)
    figure(2);
    plot(t,v(:,1),t,v(:,2));
    legend ('dof 1','dof 2');   
end
if(num==3)
    figure(2);
    plot(t,v(:,1),t,v(:,2),t,v(:,3));
    legend ('dof 1','dof 2','dof 3');   
end
if(num==4)
    figure(2);
    plot(t,v(:,1),t,v(:,2),t,v(:,3),t,v(:,4));
    legend ('dof 1','dof 2','dof 3','dof 4');   
end
if(num==5)
    figure(2);
    plot(t,v(:,1),t,v(:,2),t,v(:,3),t,v(:,4),t,v(:,5));
    legend ('dof 1','dof 2','dof 3','dof 4','dof 5');   
end
if(num>5)
   disp(' ');
   disp(' Enter a dof number for velocity plot ');
   idof=input(' ');
   plot(t,v(:,idof));
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
if(num==2)
    figure(3);
    plot(t,acc(:,1),t,acc(:,2));
    legend ('dof 1','dof 2');   
end
if(num==3)
    figure(3);
    plot(t,acc(:,1),t,acc(:,2),t,acc(:,3));
    legend ('dof 1','dof 2','dof 3');   
end
if(num==4)
    figure(3);
    plot(t,acc(:,1),t,acc(:,2),t,acc(:,3),t,acc(:,4));
    legend ('dof 1','dof 2','dof 3','dof 4');   
end
if(num==5)
    figure(3);
    plot(t,acc(:,1),t,acc(:,2),t,acc(:,3),t,acc(:,4),t,acc(:,5));
    legend ('dof 1','dof 2','dof 3','dof 4','dof 5');   
end
if(num>5)
   disp(' ');
   disp(' Enter a dof number for acceleration plot ');
   idof=input(' ');
   plot(t,acc(:,idof));
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
%