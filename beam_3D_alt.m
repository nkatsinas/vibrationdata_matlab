disp(' ');
disp(' beam_3D_alt.m,  ver 2.6, April 15, 2010 ');
disp(' ');
disp(' by Tom Irvine ');
disp(' ');
disp(' This script calculates the natural frequencies of a system of beams. ');
disp(' ');
%
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
%
clear E;
clear rho;
clear G;
clear mu;
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' The nodal coordinates must have three columns: X, Y & Z ');
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
hold on;
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
%
max_ux=max(nodex);
max_uy=max(nodey);
max_uz=max(nodez);
min_ux=min(nodex);
min_uy=min(nodey);
min_uz=min(nodez);
%
ux=max_ux-min_ux;
uy=max_uy-min_uy;
uz=max_uz-min_uz;
%
avex=(max_ux+min_ux)/2;
avey=(max_uy+min_uy)/2;
avez=(max_uz+min_uz)/2;
%
ddd=[ux,uy,uz];
dmax=max(ddd);
dmax=dmax*1.2;
%
xmin=avex-dmax/2;
xmax=avex+dmax/2;
ymin=avey-dmax/2;
ymax=avey+dmax/2;
zmin=avez-dmax/2;
zmax=avez+dmax/2;
%
axis([xmin,xmax,ymin,ymax,zmin,zmax]);
%
hold off;
%
nnum=length(nodex);
ndof=nnum*6;
Stiff=zeros(ndof,ndof);
Mass =zeros(ndof,ndof);
%
disp(' ');
disp('       Node Table ');
disp(' Number   X    Y    Z ');
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
hold on;
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
grid on;
for(i=1:enum)
  x=[nodex(node1(i)),nodex(node2(i))];
  y=[nodey(node1(i)),nodey(node2(i))];
  z=[nodez(node1(i)),nodez(node2(i))];
  plot3(x,y,z,'b');    
end
%
axis([xmin,xmax,ymin,ymax,zmin,zmax]);
%
hold off;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' Select material option ');
disp('   1=uniform ');
disp('   2=varies by element ');
imo=input(' ');
disp('  ');
%
for(i=1:enum)
   if(imo==1)  
       imat=input(' Enter material: \n 1=aluminum  2=steel  3=other ');
   else
       out1=sprintf(' Enter material for element %d: \n 1=aluminum  2=steel  3=other ',i);
   end
%
   if(imat==1) % aluminum
       rho(i)=(2.536e-04)*386;
       E(i)=1.0e+07;
       mu(i)=0.33;
   end
   if(imat==2) % steel
       rho(i)=0.29;
       E(i)=3.0e+007;
       mu(i)=0.33;
   end
%
   if(iunits==2)
       rho(i)=rho*27675;
       E(i)=E(i)*6891.2;
   end
%
   if(imat ~=1 && imat ~=2)
       disp(' ');   
       if(iunits==1)
           E(i)   = input(' Enter the elastic modulus (lbf/in^2) ');
           disp(' ');
           rho(i) = input(' Enter the mass density (lbm/in^3) ');
           disp(' '); 
       else
           E(i)   = input(' Enter the elastic modulus (N/m^2) ');
           disp(' ');
           rho(i) = input(' Enter the mass density (kg/m^3) ');
           disp(' ');       
       end
       mu(i)  = input(' Enter the Poisson ratio ');
   end
%
   G(i)=E(i)/(2*(1+mu(i)));
%
   if(imo==1)
       break;
   end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' Select geometry option ');
disp('   1=uniform ');
disp('   2=varies by element ');
igo=input(' ');
%
disp('  ');
disp(' Local Axis convention for a rectangular beam is: ');
disp(' X=length.   Y=width.   Z=thickness ');
disp(' ');
%
for(i=1:enum)
%
   icross=input(' Enter the cross-section: \n 1=rectangle  2=solid cylinder  3=other ');
   disp(' ');
   if(icross==1)
			width=input(' Enter the width (inch) ');
			thick=input(' Enter the thickness (inch) ');
			A(i)=width*thick;
			Iyy(i)=(1/12)*width*(thick^3);
            Izz(i)=(1/12)*thick*(width^3);
            J(i)=Iyy(i)+Izz(i);  % perpendicular axis theorem
   end
   if(icross==2)
			diam=input(' Enter the diameter (inch) ');
			A(i)=(pi/4)*(diam^2);
			Iyy(i)=(pi/64)*(diam^4);
            Izz(i)=Iyy(i);
            J(i)=Iyy(i)+Izz(i);  % perpendicular axis theorem
   end
   if(icross ~=1 && icross ~=2)
        if(iunits==1)
            disp(' ');
            J(i) = input(' Enter the Ixx (polar) area moment of inertia (in^4) '); 
            disp(' ');
            Iyy(i) = input(' Enter the Iyy area moment of inertia (in^4) ');
            disp(' ');
            Izz(i) = input(' Enter the Izz area moment of inertia (in^4) ');
            disp(' ');
            A(i) = input(' Enter the cross-section area (in^2) ');
        else
            disp(' ');
            J(i) = input(' Enter the Ixx (polar) area moment of inertia (m^4) '); 
            disp(' ');
            Iyy(i) = input(' Enter the Iyy area moment of inertia (m^4) ');
            disp(' ');
            Izz(i) = input(' Enter the Izz area moment of inertia (m^4) ');
            disp(' ');
            A(i) = input(' Enter the cross-section area (m^2) ');           
        end
   end 
%
   out1=sprintf('\n rho=%8.4g  J=%8.4g  Iyy=%8.4g  Izz=%8.4g  \n',rho(i),J(i),Iyy(i),Izz(i));
   disp(out1);
%
   if(igo==1)
       break;
   end
%
end
if(iunits==1)
    rho=rho/386;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%     Form local mass
%
mlocal=zeros(enum,12,12);
%     
for(k=1:enum)
     if(imo==1)
         rrr=rho(1);
         JJ=J(1);
         AA=A(1);
     else
         rrr=rho(k); 
         JJ=J(k);
         AA=A(k);
     end
%    
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
     mlocal(k,4,4) =140*JJ/AA;       
     mlocal(k,4,10)= 70*JJ/AA;
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
            mlocal(k,i,j)=mlocal(k,i,j)*L*rrr*AA/420.; 
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
%
     if(imo==1)
         EE=E(1);
         G(1)=E(1)/(2*(1+mu(1)));
         GG=G(1);
         AA=A(1);
         JJ=J(1);
         Iyym=Iyy(1);
         Izzm=Izz(1);
     else
         G(k)=E(k)/(2*(1+mu(k)));
         EE=E(k);
         GG=G(k);
         AA=A(k);
         JJ=J(k);
         Iyym=Iyy(k);
         Izzm=Izz(k);         
     end
%     
     L=LEN(k);
     L2=L^2;
     L3=L^3;
     klocal(k,1,1) = EE*AA/L;  
     klocal(k,1,7) =-klocal(k,1,1);
%     
     klocal(k,2,2) = 12*EE*Izzm/L3;  
     klocal(k,2,6) =  6*EE*Izzm/L2;  
     klocal(k,2,8) =-klocal(k,2,2);
     klocal(k,2,12)= klocal(k,2,6);
%     
     klocal(k,3,3) = 12*EE*Iyym/L3;
     klocal(k,3,5) = -6*EE*Iyym/L2;  
     klocal(k,3,9) = -klocal(k,3,3);  
     klocal(k,3,11)=  klocal(k,3,5);
%     
     klocal(k,4,4) =  GG*JJ/L;       
     klocal(k,4,10)= -klocal(k,4,4);
%     
     klocal(k,5,5) =  4*EE*Iyym/L;
     klocal(k,5,9) = -klocal(k,3,5);
     klocal(k,5,11)=  0.5*klocal(k,5,5);     
%     
     klocal(k,6,6) =  4*EE*Izzm/L;  
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
xp=(xi+xj)*0.5 +L;
yp=(yi+yj)*0.5 +L;
zp=(zi+zj)*0.5 +L;
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
%  Apply Boundary Conditions
%
    clear cdof;
    cflag=0;
    cdof(1)=0;
%    
    disp(' Select Constraint Option ')
    disp(' 1=none  2=keyboard entry  3=file entry ');
    ico=input(' ');
%    
    if(ico==3)
        clear THM;
%
        if(file_choice==1)
            [filename, pathname] = uigetfile('*.*');
            filename = fullfile(pathname, filename);
            fid = fopen(filename,'r');
            THM = fscanf(fid,' %g %g',[2 inf]);
            fclose(fid);
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
        cdof=(THM(:,1)-1)*6+(THM(:,2));
    end
    if(ico==2)
         disp('   ');
        disp(' Apply Translation Constraints? ');
        disp(' 1=yes  2=no ');
        iac=input(' ');
%
        if(iac==1)
            cflag=1;
        end
%
        i=1;
        while(iac==1)
            disp(' ');
            disp(' Enter node number to apply constraint. ');
            disp(' (Note that a value of 0 will apply constraint to all nodes) ');
            ncon=input(' ');
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
            if(ncon==0)
%           
                for(nc=1:nnum)
                    if(tchoice==1 || tchoice==4 || tchoice==5 || tchoice==7)
                        cdof(i)=nc*6-5;
                        i=i+1;
                    end
                    if(tchoice==2 || tchoice==4 || tchoice==6 || tchoice==7)
                        cdof(i)=nc*6-4;
                        i=i+1;          
                    end
                    if(tchoice==3 || tchoice==5 || tchoice==6 || tchoice==7)
                        cdof(i)=nc*6-3;
                        i=i+1;
                    end         
                end
%            
            else
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
        if(iac==1)
            cflag=1;
        end    
%
        while(iac==1)
            disp(' ');
            disp(' Enter node number to apply constraint. ');
            disp(' (Note that a value of 0 will apply constraint to all nodes) ');
            ncon=input(' ');
            if(ncon>nnum)
                disp(' Node number input error ');
            end     
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
            if(ncon==0)
%           
                for(nc=1:nnum)
                    if(tchoice==1 || tchoice==4 || tchoice==5 || tchoice==7)
                        cdof(i)=nc*6-2;
                        i=i+1;
                    end
                    if(tchoice==2 || tchoice==4 || tchoice==6 || tchoice==7)
                        cdof(i)=nc*6-1;
                        i=i+1;          
                    end
                    if(tchoice==3 || tchoice==5 || tchoice==6 || tchoice==7)
                        cdof(i)=nc*6;
                        i=i+1;
                    end         
                end
%            
            else
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
            end    
%        
            disp('   ');
            disp(' Apply another rotational constraint? ');
            disp(' 1=yes  2=no ');
            iac=input(' ');
        end
    end
%
    if(ico~=1)
%
%   Eliminate duplicate entries and sort
%        
        clear temp;
        clear length;
        cdof=unique(cdof);
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
    end
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
%
scale=1;
while(1)
    disp(' Plot mode shape ?');
    disp(' 1=yes  2=no ');
    ipm=input(' ');
    if(ipm==1)
        while(1)
            [mx,my,mz,scale]=beam_3D_modeplot(scale,nodex,nodey,nodez,node1,node2,cdof,nnum,enum,ModeShapes,fn);
%            
            disp(' Rescale ?');
            disp(' 1=yes  2=no ');
            ires=input(' ');     
            if(ires==1)
                disp(' Enter scale factor ');
                sf=input(' ');
                scale=scale*sf;
            else
               break;     
            end
        end     
    else
       break;
    end
end    