
%  beam_column_local_stiffness_6dof.m  ver 1.0  by Tom Irvine

function[klocal] = beam_column_local_stiffness_6dof(E,G,J,Iyy,Izz,area,ne,dx)

A=area;

%
for k=1:ne

    L=dx(k);
    L2=L^2;
    L3=L^3;    
    
    klocal(k,:,:)=0;

%

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
         for j=i:12 
			klocal(k,j,i)=klocal(k,i,j);
         end
     end
%
end