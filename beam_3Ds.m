disp(' ');
disp(' beam_3D.m,  ver 1.3, March 5, 2010 ');
disp(' ');
disp(' by Tom Irvine ');
disp(' ');
disp(' This script calculates the natural frequencies of a system of beams. ');
disp(' via the finite element method.');
%
clear cdof;
clear nodes;
clear nodex;
clear nodey;
clear nodez;
clear node1;
clear node2;
%
clear THM;
clear length;
clear nnum;
clear enum;
clear LEN;
%
clear mlocal;
clear klocal;
%
clear mlocal_ct;
clear klocal_ct;
%
clear mct;
clear kct;
%
clear Stiff;
clear Mass;
clear T;
clear TT;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Select units ');
disp(' 1=English  2=metric ');
iunits=input(' ');
disp(' ');
if(iunits==1)
    disp(' mass(lbm), stiffness(lbf/in), length(in), mass density(lbm/in^3)');    
else
    disp(' mass(kg), stiffness(N/m), length(m), mass density(kg/m^3)');
end
%
disp(' ');
if(iunits==1)
   disp(' The nodal coordinates must have three columns: X, Y & Z  (inches)');
else
   disp(' The nodal coordinates must have three columns: X, Y & Z  (meters)');    
end
disp(' Select the nodal coordinate input method ');
%
disp(' ')
disp(' Select data input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
disp('   3=Excel file');
file_choice = input('');
%
if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%g %g %g',[3 inf]);
        fclose(fid);
        THM=THM';
end
if(file_choice==2)
        THM = input(' Enter the node matrix name:  ');
end
if(file_choice==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        THM = xlsread(xfile);
%         
end
%
nodex=THM(:,1);
nodey=THM(:,2);
nodez=THM(:,3);
%
figure(1);
plot3(nodex,nodey,nodez,'s');
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
%
nnum=length(nodex);
ndof=nnum*6;
Stiff=zeros(ndof,ndof);
Mass =zeros(ndof,ndof);
%
disp(' ');
disp('       Node Table ');
disp(' Number   X    Y    X ');
%
for(i=1:nnum)
    out1=sprintf('    %d     %g    %g    %g ',i,nodex(i),nodey(i),nodez(i));
    disp(out1);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' The element file must have two columns: node1 node2  (integers)');
disp(' Select the element input method ');
%
disp(' ')
disp(' Select data input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
disp('   3=Excel file');
file_choice = input('');
%
if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%d %d ',[2 inf]);
        fclose(fid);
        THM=THM';
end
if(file_choice==2)
        THM = input(' Enter the element matrix name:  ');
end
if(file_choice==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        THM = xlsread(xfile);
%         
end
%
node1=THM(:,1);
node2=THM(:,2);
%
enum=length(node1);
%
disp(' ');
disp('       Element Table ');
disp(' Number    N1    N2   Length');
%
for(i=1:enum)
    dx=nodex(node1(i))-nodex(node2(i));
    dy=nodey(node1(i))-nodey(node2(i));
    dz=nodez(node1(i))-nodez(node2(i));
    LEN(i)=sqrt(dx^2+dy^2+dz^2);
    out1=sprintf('    %d  \t  %d  \t  %d \t %8.3g',i,node1(i),node2(i),LEN(i));
    disp(out1);
end
%
figure(2);
plot3(nodex,nodey,nodez,'s');
hold on;
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
for(i=1:enum)
  x=[nodex(node1(i)),nodex(node2(i))];
  y=[nodey(node1(i)),nodey(node2(i))];
  z=[nodez(node1(i)),nodez(node2(i))];
  plot3(x,y,z,'b');    
end
hold off;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp('  ');
disp(' Assume uniform material ');
disp('  ');
imat=input(' Enter material: \n 1=aluminum  2=steel  3=other ');
%
if(imat==1) % aluminum
    rho=0.1;
    E=1.0e+07;
    mu=0.33;
end
if(imat==2) % steel
    rho=0.29;
    E=3.0e+007;
    mu=0.33;
end
%
if(iunits==2)
    rho=rho*27675;
    E=E*6891.2;
end
%
if(imat ~=1 && imat ~=2)
    disp(' ');   
    if(iunits==1)
        E   = input(' Enter the elastic modulus (lbf/in^2) ');
        disp(' ');
        rho = input(' Enter the mass density (lbm/in^3) ');
        disp(' '); 
    else
        E   = input(' Enter the elastic modulus (N/m^2) ');
        disp(' ');
        rho = input(' Enter the mass density (kg/m^3) ');
        disp(' ');       
    end
    mu  = input(' Enter the Poisson ratio ');
end
%
G=E/(2*(1+mu));
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp('  ');
disp(' Assume uniform cross-section geometry ');
disp('  ');
disp(' Local Axis convention for a rectangular beam is: ');
disp(' X is length.   Y=width.   Z=thickness ');
disp(' ');
icross=input(' Enter the cross-section: \n 1=rectangle  2=solid cylinder  3=other ');
disp(' ');
if(icross==1)
			width=input(' Enter the width (inch) ');
			thick=input(' Enter the thickness (inch) ');
			A=width*thick;
			Iyy=(1/12)*width*(thick^3);
            Izz=(1/12)*thick*(width^3);
            J=Iyy+Izz;  % perpendicular axis theorem
end
if(icross==2)
			diam=input(' Enter the diameter (inch) ');
			A=(pi/4)*(diam^2);
			Iyy=(pi/64)*(diam^4);
            Izz=Iyy;
            J=Iyy+Izz;  % perpendicular axis theorem
end
if(icross ~=1 && icross ~=2)
        if(iunits==1)
            disp(' ');
            J = input(' Enter the Ixx (polar) area moment of inertia (in^4) '); 
            disp(' ');
            Iyy = input(' Enter the Iyy area moment of inertia (in^4) ');
            disp(' ');
            Izz = input(' Enter the Izz area moment of inertia (in^4) ');
            disp(' ');
            A = input(' Enter the cross-section area (in^2) ');
        else
            disp(' ');
            J = input(' Enter the Ixx (polar) area moment of inertia (m^4) '); 
            disp(' ');
            Iyy = input(' Enter the Iyy area moment of inertia (m^4) ');
            disp(' ');
            Izz = input(' Enter the Izz area moment of inertia (m^4) ');
            disp(' ');
            A = input(' Enter the cross-section area (m^2) ');           
        end
end 
%
rho=rho*A;  % mass per unit length
if(iunits==1)
    rho=rho/386;
end
out1=sprintf('\n J=%8.4g  Iyy=%8.4g  Izz=%8.4g  \n',J,Iyy,Izz);
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%     Form local mass
%
mlocal=zeros(enum,12,12);
%     
for(k=1:enum)
     L=LEN(k);
     L2=L^2;
%
     mlocal(k,1,1) =140;  
     mlocal(k,1,7) =70;
%     
     mlocal(k,2,2) =156;  
     mlocal(k,2,6) =22*L;  
     mlocal(k,2,8) =54;
     mlocal(k,2,12)=-13*L;
%     
     mlocal(k,3,3) = mlocal(k,2,2);
     mlocal(k,3,5) =-mlocal(k,2,6);  
     mlocal(k,3,9) = mlocal(k,2,8);  
     mlocal(k,3,11)=-mlocal(k,2,12);
%     
     mlocal(k,4,4) =140*J/A;       
     mlocal(k,4,10)= 70*J/A;
%     
     mlocal(k,5,5) = 4*L2;
     mlocal(k,5,9) = mlocal(k,2,12);
     mlocal(k,5,11)=-3*L2;     
%     
     mlocal(k,6,6) = mlocal(k,5,5);  
     mlocal(k,6,8) =-mlocal(k,2,12);
     mlocal(k,6,12)= mlocal(k,5,11);  
%      
     mlocal(k,7,7)  =mlocal(k,1,1);       
%
     mlocal(k,8,8) = mlocal(k,2,2);  
     mlocal(k,8,12)=-mlocal(k,2,6); 
%
     mlocal(k,9,9)  =mlocal(k,2,2);  
     mlocal(k,9,11) =mlocal(k,2,6); 
%
     mlocal(k,10,10)=mlocal(k,4,4);  
%
     mlocal(k,11,11)=mlocal(k,5,5); 
%
     mlocal(k,12,12)=mlocal(k,5,5); 
%
%    symmetry
%
     for(i=1:12)
         for(j=i:12)
            mlocal(k,i,j)=mlocal(k,i,j)*L*rho/420.; 
			mlocal(k,j,i)=mlocal(k,i,j);
         end
     end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Form local stiffness
%
for(k=1:enum)
     L=LEN(k);
     L2=L^2;
     L3=L^3;
     klocal(k,1,1) = E*A/L;  
     klocal(k,1,7) =-klocal(k,1,1);
%     
     klocal(k,2,2) = 12*E*Izz/L3;  
     klocal(k,2,6) =  6*E*Izz/L2;  
     klocal(k,2,8) =-klocal(k,2,2);
     klocal(k,2,12)= klocal(k,2,6);
%     
     klocal(k,3,3) = 12*E*Iyy/L3;
     klocal(k,3,5) = -6*E*Iyy/L2;  
     klocal(k,3,9) = -klocal(k,3,3);  
     klocal(k,3,11)=  klocal(k,3,5);
%     
     klocal(k,4,4) =  G*J/L;       
     klocal(k,4,10)= -klocal(k,4,4);
%     
     klocal(k,5,5) =  4*E*Iyy/L;
     klocal(k,5,9) = -klocal(k,3,5);
     klocal(k,5,11)=  0.5*klocal(k,5,5);     
%     
     klocal(k,6,6) =  4*E*Izz/L;  
     klocal(k,6,8) = -klocal(k,2,6);
     klocal(k,6,12)=  0.5*klocal(k,6,6);  
%      
     klocal(k,7,7) = klocal(k,1,1);       
%
     klocal(k,8,8)  = klocal(k,2,2);  
     klocal(k,8,12) = klocal(k,6,8); 
%
     klocal(k,9,9)  =  klocal(k,3,3);  
     klocal(k,9,11) = -klocal(k,3,5); 
%
     klocal(k,10,10)=klocal(k,4,4);  
%
     klocal(k,11,11)=klocal(k,5,5); 
%
     klocal(k,12,12)=klocal(k,6,6);  
%     
%    symmetry
%
     for(i=1:12)
         for(j=i:12) 
			klocal(k,j,i)=klocal(k,i,j);
         end
     end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Coordinate transformations
%
for(k=1:enum)
%
     clear T;
     clear tm_ol;
     clear C;
     T1=zeros(3,3);
     T=zeros(12,12);
     L=LEN(k);
%
     xi=nodex(node1(k));
     xj=nodex(node2(k));
     yi=nodey(node1(k));
     yj=nodey(node2(k));     
     zi=nodez(node1(k));
     zj=nodez(node2(k));
%
     x=xj-xi;
     y=yj-yi;
     z=zj-zi;
%
%   point p
xp=xi;
yp=yi+1;
zp=zi;
%   T1 -1,1  1,2  1,3
T1(1,1)=(xj-xi)/L;      %cosxX
T1(1,2)=(yj-yi)/L;      %cosxY
T1(1,3)=(zj-zi)/L;      %cosxZ
%
zx=((yj-yi)*(zp-zi))-((zj-zi)*(yp-yi));
zy=((zj-zi)*(xp-xi))-((xj-xi)*(zp-zi));
zz=((xj-xi)*(yp-yi))-((yj-yi)*(xp-xi));
Z=sqrt((zx^2)+(zy^2)+(zz^2));
%   T1 - 3,1  3,2  3,3
T1(3,1)=zx/Z;           %coszX
T1(3,2)=zy/Z;           %coszY
T1(3,3)=zz/Z;           %coszZ    
%
yx=-(T1(1,2)*T1(3,3))+(T1(1,3)*T1(3,2));
yy=-(T1(1,3)*T1(3,1))+(T1(1,1)*T1(3,3));
yz=-(T1(1,1)*T1(3,2))+(T1(1,2)*T1(3,1));
Y=sqrt((yx^2)+(yy^2)+(yz^2));
%   T1 - 2,1  2,2  2,3
T1(2,1)=yx/Y;           %cosyX
T1(2,2)=yy/Y;           %cosyY
T1(2,3)=yz/Y;           %cosyZ
%
%   T
T(1,1)=T1(1,1);
T(1,2)=T1(1,2);
T(1,3)=T1(1,3);
T(2,1)=T1(2,1);
T(2,2)=T1(2,2);
T(2,3)=T1(2,3);
T(3,1)=T1(3,1);
T(3,2)=T1(3,2);
T(3,3)=T1(3,3);
%
T(4,4)=T1(1,1);
T(4,5)=T1(1,2);
T(4,6)=T1(1,3);
T(5,4)=T1(2,1);
T(5,5)=T1(2,2);
T(5,6)=T1(2,3);
T(6,4)=T1(3,1);
T(6,5)=T1(3,2);
T(6,6)=T1(3,3);
%
T(7,7)=T1(1,1);
T(7,8)=T1(1,2);
T(7,9)=T1(1,3);
T(8,7)=T1(2,1);
T(8,8)=T1(2,2);
T(8,9)=T1(2,3);
T(9,7)=T1(3,1);
T(9,8)=T1(3,2);
T(9,9)=T1(3,3);
%
T(10,10)=T1(1,1);
T(10,11)=T1(1,2);
T(10,12)=T1(1,3);
T(11,10)=T1(2,1);
T(11,11)=T1(2,2);
T(11,12)=T1(2,3);
T(12,10)=T1(3,1);
T(12,11)=T1(3,2);
T(12,12)=T1(3,3); 
%
     clear ml;
     clear kl;
     ml((1:12),(1:12))=mlocal(k,(1:12),(1:12));
     kl((1:12),(1:12))=klocal(k,(1:12),(1:12));
%
     mlocal_ct=T'*ml*T;
     klocal_ct=T'*kl*T;
% 
     mct(k,(1:12),(1:12))=mlocal_ct;
     kct(k,(1:12),(1:12))=klocal_ct;
%
%%     if(k==5)
%%         T
%%         sadfsd=input(' ');
%%     end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Assembly global mass & stiffness
%
for(k=1:enum)
     clear TT;
     TT=zeros(12,ndof);
%     
     dof=node1(k)*6-5;
     for(i=1:6)
       TT(i,dof)=1;
       dof=dof+1;
     end
%     
     dof=node2(k)*6-5;
     for(i=7:12)
       TT(i,dof)=1; 
       dof=dof+1;       
     end
%
     clear mlocal_ct;
     clear klocal_ct;
     mlocal_ct((1:12),(1:12))=mct(k,(1:12),(1:12));
     klocal_ct((1:12),(1:12))=kct(k,(1:12),(1:12));
%
     Mass=Mass +TT'*mlocal_ct*TT;
    Stiff=Stiff+TT'*klocal_ct*TT;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Apply Point Mass
%
   disp(' ');
   disp(' Add point mass?');
   disp(' i=yes  2=no ');
   ipm=input(' ');
%
   if(ipm==1)
      disp(' ');
      disp(' Enter number of point masses ');
      npm=input(' ');
      for(i=1:npm)
         disp(' Enter node number ');
         node_pm=input(' ');
         if(iunits==1)
             mass_point=input(' Enter mass (lbm)');
             mass_point=mass_point/386;
         else
             mass_point=input(' Enter mass (kg)');             
         end
         for(jk=3:5)
            mass_dof=(node_pm*6)-jk;  
            Mass(mass_dof,mass_dof)=Mass(mass_dof,mass_dof)+mass_point;   
         end
      end
   end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Apply Boundary Conditions
%
    disp('   ');
    disp(' Apply Translation Constraints? ');
    disp(' 1=yes  2=no ');
    iac=input(' ');
%
    i=1;
    clear cdof;
    while(iac==1)
        disp(' ');
        ncon=input(' Enter node number to apply constraint ');
        disp(' ');
        disp(' Select dofs to constrain ');
        disp(' 1=TX ');  
        disp(' 2=TY '); 
        disp(' 3=TZ ');
        disp(' 4=TX & TY ');  
        disp(' 5=TX & TZ '); 
        disp(' 6=TY & TZ ');      
        disp(' 7=TX,TY,TZ ');             
        tchoice=input(' ');
%
        if(tchoice==1 || tchoice==4 || tchoice==5 || tchoice==7)
            cdof(i)=ncon*6-5;
            i=i+1;
        end
        if(tchoice==2 || tchoice==4 || tchoice==6 || tchoice==7)
            cdof(i)=ncon*6-4;
            i=i+1;          
        end
        if(tchoice==3 || tchoice==5 || tchoice==6 || tchoice==7)
            cdof(i)=ncon*6-3;
            i=i+1;
        end
%        
        disp('   ');
        disp(' Apply another translational constraint? ');
        disp(' 1=yes  2=no ');
        iac=input(' ');
%           
    end
%
    disp('   ');
    disp(' Apply Rotational Constraints? ');
    disp(' 1=yes  2=no ');
    iac=input(' ');
%
    while(iac==1)
        disp(' ');
        ncon=input(' Enter node number to apply constraint ');
        disp(' ');
        disp(' Select dofs to constrain ');
        disp(' 1=RX ');  
        disp(' 2=RY '); 
        disp(' 3=RZ ');
        disp(' 4=RX & RY ');  
        disp(' 5=RX & RZ '); 
        disp(' 6=RY & RZ ');      
        disp(' 7=RX,RY,RZ ');             
        tchoice=input(' ');
%
        if(tchoice==1 || tchoice==4 || tchoice==5 || tchoice==7)
            cdof(i)=ncon*6-2;
            i=i+1;
        end
        if(tchoice==2 || tchoice==4 || tchoice==6 || tchoice==7)
            cdof(i)=ncon*6-1;
            i=i+1;          
        end
        if(tchoice==3 || tchoice==5 || tchoice==6 || tchoice==7)
            cdof(i)=ncon*6;
            i=i+1;
        end
%        
        disp('   ');
        disp(' Apply another rotational constraint? ');
        disp(' 1=yes  2=no ');
        iac=input(' ');
%           
    end
    clear temp;
    clear length;
    cdof=sort(cdof);
    temp=cdof(end:-1:1);
    cdof=temp;
    num_con=length(cdof);
%
%   Apply constraints to global matrices
%
    for(i=1:num_con)
        Stiff(cdof(i),:)=[];
        Stiff(:,cdof(i))=[];
         Mass(cdof(i),:)=[];
         Mass(:,cdof(i))=[];
    end
%    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Solve generalized eigenvector problem
%
disp(' ');
disp(' Apply mass condensation? ')
disp(' 1=yes  2=no ');
imc=input(' ');
if(imc==1)
   disp(' ');
   disp(' Enter number of degrees-of-freedom ');
   disp(' to retain in reduced model ');
   nr=input(' ');    
   [fn,omega,ModeShapes,MST]=beam_3D_mass_condensation(Stiff,Mass,nr); 
else
   [fn,omega,ModeShapes,MST]=Generalized_Eigen(Stiff,Mass,3);
end