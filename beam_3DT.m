disp(' ');
disp(' beam_3D.m,  ver 1.0, March 3, 2010 ');
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
clear THM;
for(i=1:20)
THM(i,1)=i;
THM(i,2)=i+1;
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
E=10000000.;
mu=0.33;
rho=2.536e-4; 
%
G=E/(2*(1+mu));
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
A=0.1;
J=1.577e-3;
Iyy=7.884e-4;  
Izz=7.884e-4;  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%     Form local mass
%
mlocal=zeros(enum,12,12);
%     
for(k=1:enum)
    clear m;
     L=LEN(k);
     L2=L^2;
     mbar=rho*A;
AA=mbar*L/420;
Im=mbar*J/A;
%   diag
m(1,1)=     140;
m(2,2)=     156;
m(3,3)=     156;
m(4,4)=     140*Im/mbar;
m(5,5)=     4*L^2;
m(6,6)=     4*L^2;
m(7,7)=     140;
m(8,8)=     156;
m(9,9)=     156;
m(10,10)=   140*Im/mbar;
m(11,11)=   4*L^2;
m(12,12)=   4*L^2;
%   off diag
m(5,3)=-22*L;
m(3,5)=m(5,3);
m(6,2)=22*L;
m(2,6)=m(6,2);
m(7,1)=70;
m(1,7)=m(7,1);
m(8,2)=54;
m(2,8)=m(8,2);
m(8,6)=13*L;
m(6,8)=m(8,6);
m(9,3)=54;
m(3,9)=m(9,3);
m(9,5)=-13*L;
m(5,9)=m(9,5);
m(10,4)=70*Im/mbar;
m(4,10)=m(10,4);
m(11,3)=13*L;
m(3,11)=m(11,3);
m(11,5)=-3*L^2;
m(5,11)=m(11,5);
m(11,9)=22*L;
m(9,11)=m(11,9);
m(12,2)=-13*L;
m(2,12)=m(12,2);
m(12,6)=-3*L^2;
m(6,12)=m(12,6);
m(12,8)=-22*L;
m(8,12)=m(12,8);
%   multiply A time M to finish matrices

%   multiply A time M to finish matrices
     for(i=1:12)
         for(j=1:12) 
			mlocal(k,i,j)=AA*m(i,j);
         end
     end
%   
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Form local stiffness
%
for(kv=1:enum)
     L=LEN(kv);
     L2=L^2;
     L3=L^3;
     clear k;
     Iy=Iyy;
     Iz=Izz;
%
k(1,1)=     E*A/L;
k(2,2)=     12*E*Iz/(L^3);
k(3,3)=     12*E*Iy/(L^3);
k(4,4)=     G*J/L;
k(5,5)=     4*E*Iy/L;
k(6,6)=     4*E*Iz/L;
k(7,7)=     E*A/L;
k(8,8)=     12*E*Iz/(L^3);
k(9,9)=     12*E*Iy/(L^3);
k(10,10)=   G*J/L;
k(11,11)=   4*E*Iy/L;
k(12,12)=   4*E*Iz/L;
%   off diag
k(5,3)=     -6*E*Iy/L^2;
k(3,5)=     k(5,3);
k(6,2)=     6*E*Iz/L^2;
k(2,6)=     k(6,2);
k(7,1)=     -E*A/L;
k(1,7)=     k(7,1);
k(8,2)=     -12*E*Iz/L^3;
k(2,8)=     k(8,2);
k(8,6)=     -6*E*Iz/L^2;
k(6,8)=     k(8,6);
k(9,3)=     -12*E*Iy/L^3;
k(3,9)=     k(9,3);
k(9,5)=     6*E*Iy/L^2;
k(5,9)=     k(9,5);
k(10,4)=    -G*J/L; %
k(4,10)=    k(10,4);
k(11,3)=    -6*E*Iy/L^2;
k(3,11)=    k(11,3);
k(11,5)=    2*E*Iy/L;
k(5,11)=    k(11,5);
k(11,9)=    6*E*Iy/L^2;
k(9,11)=    k(11,9);
k(12,2)=    6*E*Iz/L^2;
k(2,12)=    k(12,2);
k(12,6)=    2*E*Iz/L;
k(6,12)=    k(12,6);
k(12,8)=    -6*E*Iz/L^2;
k(8,12)=    k(12,8);
%
     for(i=1:12)
         for(j=1:12) 
			klocal(kv,i,j)=k(i,j);
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
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Apply Boundary Conditions
%

    clear temp;
    clear length;
    cdof=[1 2 3 121 122 123 ];
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
   [fn,omega,ModeShapes,MST]=Generalized_Eigen(Stiff,Mass,3);
