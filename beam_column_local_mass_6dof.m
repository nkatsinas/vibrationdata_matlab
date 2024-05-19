
% beam_column_local_mass.m  ver 1.0  by Tom Irvine


function[mlocal] = beam_column_local_mass_6dof(rho,J,dx,area,ne)
    
A=area;


for k=1:ne
%
    L=dx(k);
    L2=L^2;
%
    mlocal(k,:,:)=0;
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
%
% symmetry
%
	for i=1:12
		for j=i:12
            mlocal(k,i,j)=mlocal(k,i,j)*dx(k)*rho/420.; 
			mlocal(k,j,i)=mlocal(k,i,j);
        end
    end
        
%
end