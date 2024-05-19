disp(' ');
disp('  beam_3D_nastran.m  ver 1.4  March 29, 2010');
disp('  by Tom Irvine');
disp('  ');
%
disp(' Elements supported: ');
disp('   CBAR   ');
disp('   CBEAM  ');
disp(' ');
%
clear elem_prop;
clear node_numo;
clear nodex;
clear nodey;
clear nodez;
%
clear node1;
clear node2;
clear elem_n1;
clear elem_n2;
clear length;
clear E;
clear G;
clear pr;
clear rho;
clear mat_num;
clear prop_num;
clear A;
clear Iyy;
clear Izz;
clear J;
%
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
clear Mass_unconstrained;
clear Stiff_unconstrained;
%
clear cdof;
cdof(1)=0;
clear ctotal;
clear constraint_node;
%
disp(' ');
disp(' Select Nastran File ');
%
[filename, pathname] = uigetfile('*.*');
filename = fullfile(pathname, filename);
fid = fopen(filename,'r');
%
%
%%%%%%%%% Read Nodes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
i=1;
while(1)
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
%    disp(tline);
%
    k1=strfind(tline, 'GRID');
    k2=strfind(tline, 'PRINT');
    if(k2>=1)
    else
        if(k1>=1)
%        
            clear nss; 
            nss=sscanf(tline,'GRID %d %d %f %f %f');
            node_numo(i)=nss(1);
            nodex(i)=nss(3); 
            nodey(i)=nss(4);
            nodez(i)=nss(5); 
            i=i+1;
        end
    end
%
end
frewind(fid);
%
%%%%%%% Read Elements %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
i=1;
while(1)
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
%    disp(tline);
%
    k=strfind(tline, 'CBAR');
    if(k>=1)
        clear nss;
        nss=sscanf(tline,'CBAR %d %d %d %d ');
        elem_prop(i)=nss(2);
        elem_n1(i)=nss(3);
        elem_n2(i)=nss(4); 
        i=i+1;
    end
%
end
%
frewind(fid);
%
while(1)
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
%    disp(tline);
%
    k=strfind(tline, 'CBEAM');
    if(k>=1)
        clear nss;
        nss=sscanf(tline,'CBEAM %d %d %d %d ');
        elem_prop(i)=nss(2);
        elem_n1(i)=nss(3);
        elem_n2(i)=nss(4); 
        i=i+1;
    end
%
end
%
frewind(fid);
%
%%%%%% Read Constraints %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
i=1;
ctotal=0;
clear constraint;
clear constraint_node;
while(1)
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
%    disp(tline);
%
    k=strfind(tline, 'SPC1');
    if(k>=1)
        clear nss;
        nss=sscanf(tline,'SPC1 %d %d %d ');
%
              sn=num2str(nss(2));
%              
              cstring=num2str(nss(2));
              constraint_node(i)=nss(3); 
%                
%%        out1=sprintf('nss1= %d',nss(1));
%%          disp(out1);
%%          out1=sprintf('nss2= %d',nss(2));
%%          disp(out1);
%%          out1=sprintf('nss3= %d',nss(3));
%%          disp(out1);
%%          out1=sprintf('constraint(%d)=%d',i,constraint_node(i));
%%          disp(out1);
%        constraint(i,1)=nss(3);  
%        constraint(i,2)=nss(2);
%
              for(jj=1:6)
                 constraint(i,jj)=0;
              end
              if(strfind(sn,'1')>=1) 
                 constraint(i,1)=1;
              end              
              if(strfind(sn,'2')>=1) 
                 constraint(i,2)=1;
              end   
              if(strfind(sn,'3')>=1) 
                 constraint(i,3)=1;
              end 
              if(strfind(sn,'4')>=1) 
                 constraint(i,4)=1;          
              end
              if(strfind(sn,'5')>=1) 
                 constraint(i,5)=1;      
              end
              if(strfind(sn,'6')>=1) 
                 constraint(i,6)=1;        
              end 
%
        i=i+1;
        ctotal=i-1;
    end
end 
%
disp(' ');
constraint_node
constraint
ctotal
frewind(fid);
%
%%%%%% Read Materials %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
nv=0;
while(1)
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
%    disp(tline);
%
    k=strfind(tline, 'MAT1');
%    
%    
    if(k>=1)
        nv=nv+1; 
%        tline
        clear nss;
%        
        nss=tline;
%       
        ii=8;
        jj=16;
        [mat_num(nv)]=beam_3D_nastran_find(nss,ii,jj); 
%
%**** Find Elastic Modulus *************************************
%
        ii=jj+1;
        jj=ii+7;
        [E(nv)]=beam_3D_nastran_find(nss,ii,jj);        
%
%**** Find Shear Modulus *************************************
%
        ii=jj+1;
        jj=ii+7;
        [G(nv)]=beam_3D_nastran_find(nss,ii,jj);        
%
%**** Find Poisson Ratio *************************************
%
        ii=jj+1;
        jj=ii+7;
        [pr(nv)]=beam_3D_nastran_find(nss,ii,jj);  
%
%
%**** Find Mass Density *************************************
%
        ii=jj+1;
        jj=ii+7;
        [rho(nv)]=beam_3D_nastran_find(nss,ii,jj);  
%
        if(G(nv)<1.0e-08)
            G(nv)=E(nv)/(2*(1+pr(nv)));
        end
%
        out1=sprintf(' nv=%d  mat_num=%d E=%g  G=%g  pr=%g  rho=%g \n',nv,mat_num(nv),E(nv),G(nv),pr(nv),rho(nv));
        disp(out1);
%
    end
end    
%
%%%%%%%% Read Properties %%%%%%%%%%%%%%%%%%%%
%
frewind(fid);
nv=0;
while(1)
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
%    disp(tline);
%
    clear k1;
    clear k2;
    k1=strfind(tline, 'PBAR');
    k2=strfind(tline, 'PBEAM');
    k3=[k1 k2];
%    
    if(max(k3)>=1)
        nv=nv+1;
%        disp(' prop ');
%        tline;
        clear nss;
%
        nss=tline;
%       
        ii=8;
        jj=16;
        [prop_num(nv,1)]=beam_3D_nastran_find(nss,ii,jj); 
        ii=jj+1;
        jj=ii+7;
        [prop_num(nv,2)]=beam_3D_nastran_find(nss,ii,jj);     
%
%**** Find Area *************************************
%
        ii=jj+1;
        jj=ii+7;
        [A(nv)]=beam_3D_nastran_find(nss,ii,jj);        
%
%**** Find Iyy *************************************
%
        ii=jj+1;
        jj=ii+7;
        [Iyy(nv)]=beam_3D_nastran_find(nss,ii,jj);        
%
%**** Find Izz *************************************
%
        ii=jj+1;
        jj=ii+7;
        [Izz(nv)]=beam_3D_nastran_find(nss,ii,jj);  
%
%**** Find J *************************************
%
        if(k1==1)
            ii=jj+1;
            jj=ii+7;
        else
            ii=jj+1;
            jj=ii+7;   
            ii=jj+1;
            jj=ii+7;      
        end
        [J(nv)]=beam_3D_nastran_find(nss,ii,jj);  
%
        out1=sprintf(' nv=%d  prop_num=%d  prop_mat=%d  Area=%g Iyy=%g  Izz=%g  J=%g \n',nv,prop_num(nv,1),prop_num(nv,2),A(nv),Iyy(nv),Izz(nv),J(nv));
        disp(out1);
%
    end
end    
fclose(fid);
%
%%%%%%%% Organize Nodes & Elements %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
nnum=length(nodex);
enum=length(elem_n1);
%
for(i=1:enum)    
         for(j=1:nnum)
%             
              if(elem_n1(i)==node_numo(j))
                 node1(i)=j;
              end
%              
              if(elem_n2(i)==node_numo(j))
                 node2(i)=j;                            
              end
%              
        end                           
end 
%
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
figure(1);
plot3(nodex,nodey,nodez,'s');
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
%%%%%%%% Organize Constraints %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Constraints ');
%
ijk=1;
for(i=1:ctotal)
%
    for(j=1:nnum)
%
        if(constraint_node(i)==node_numo(j))
%              
            n1=j;
%                 
            for(k=1:6)
%                 
                if(  constraint(i,k) ~= 0 )               
                    out1=sprintf('%d \t %d ',n1,k);
                    cdof(ijk)=(n1-1)*6+k;
                    ijk=ijk+1;
                    disp(out1);
                end            
%                     
            end
            break;
        end
    end                       
end   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%     Form local mass
%
mlocal=zeros(enum,12,12);
klocal=zeros(enum,12,12);
%
disp(' ');
disp('El      A       Iyy       Izz        J        E         G         rho ');
for(k=1:enum)
     L=LEN(k);
     L2=L^2;
     L3=L^3;    
%
     sz_ep=length(elem_prop);
     sz_prop=length(prop_num);
%     
     jflag=0;
     for(i=1:sz_ep)
        for(j=1:sz_prop)
            if(prop_num(j,1)==elem_prop(i))
                pn=j;
                A_local=A(j);
                Iyy_local=Iyy(j);
                Izz_local=Izz(j);
                J_local=J(j);
                jflag=1;
                break;
            end
        end
        if(jflag==1)
           break;
        end
     end
%     
     sz=length(E);  
     for(i=1:sz)
         if(prop_num(pn,2)==mat_num(i))
             E_local=E(i);
             G_local=G(i);
             rho_local=rho(i);
             break;
         end
     end
%
     out1=sprintf('%d %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g %8.4g',k,A_local,Iyy_local,Izz_local,J_local,E_local,G_local,rho_local);
     disp(out1);
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
     mlocal(k,4,4) =140*J_local/A_local;       
     mlocal(k,4,10)= 70*J_local/A_local;
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
            mlocal(k,i,j)=mlocal(k,i,j)*L*rho_local*A_local/420.; 
			mlocal(k,j,i)=mlocal(k,i,j);
         end
     end
%    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Form local stiffness
%
     klocal(k,1,1) = E_local*A_local/L;  
     klocal(k,1,7) =-klocal(k,1,1);
%     
     klocal(k,2,2) = 12*E_local*Izz_local/L3;  
     klocal(k,2,6) =  6*E_local*Izz_local/L2;  
     klocal(k,2,8) =-klocal(k,2,2);
     klocal(k,2,12)= klocal(k,2,6);
%     
     klocal(k,3,3) = 12*E_local*Iyy_local/L3;
     klocal(k,3,5) = -6*E_local*Iyy_local/L2;  
     klocal(k,3,9) = -klocal(k,3,3);  
     klocal(k,3,11)=  klocal(k,3,5);
%     
     klocal(k,4,4) =  G_local*J_local/L;       
     klocal(k,4,10)= -klocal(k,4,4);
%     
     klocal(k,5,5) =  4*E_local*Iyy_local/L;
     klocal(k,5,9) = -klocal(k,3,5);
     klocal(k,5,11)=  0.5*klocal(k,5,5);     
%     
     klocal(k,6,6) =  4*E_local*Izz_local/L;  
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
Mass_unconstrained=Mass;
Stiff_unconstrained=Stiff;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%   Eliminate duplicate constraints entries and sort
%
if(ctotal>=1)
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