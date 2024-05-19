function[Mass,Stiff,T]=mass_stiffness_matricesR(enum,ndof,LEN,rho,E,G,Iyy,Izz,J,A,nodex,nodey,nodez,node1,node2)
R=rotz(-45);


T(1:3,1:3)=R;
T(4:6,4:6)=R;
T(7:9,7:9)=R;
T(10:12,10:12)=R;

Mass=zeros(ndof,ndof);
Stiff=zeros(ndof,ndof);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  
%     Form local mass
%
mlocal=zeros(enum,12,12);
%     
for k=1:enum
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
     for i=1:12
         for(j=i:12)
            mlocal(k,i,j)=mlocal(k,i,j)*L*rho*A/420.; 
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
for k=1:enum
%
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
     for i=1:12
         for(j=i:12) 
            klocal(k,j,i)=klocal(k,i,j);
         end
     end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Coordinate transformations
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

for k=1:enum
     clear TT;
     TT=zeros(12,ndof);
%     
     dof=node1(k)*6-5;
     for i=1:6
       TT(i,dof)=1;
       dof=dof+1;
     end
%     
     dof=node2(k)*6-5;
     for i=7:12
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
