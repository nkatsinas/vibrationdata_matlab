
% beam_column_local_mass.m  ver 1.0  by Tom Irvine


function [mlocal] = beam_column_local_mass(rho,ne,dx)
    

 for k=1:ne
%
    mlocal(k,:,:)=0;
%
    mlocal(k,1,1)=140;
    mlocal(k,1,4)=70;
%
    mlocal(k,2,2)=156.;
    mlocal(k,2,3)=22.;
    mlocal(k,2,5)=54.;
    mlocal(k,2,6)=-13.;
%    
    mlocal(k,3,3)=4.;
    mlocal(k,3,5)=13.;
    mlocal(k,3,6)=-3.;
%
    mlocal(k,4,4)=140;   
%
    mlocal(k,5,5)=156.;
    mlocal(k,5,6)=-22.;
%    
	mlocal(k,6,6)=4.;
%
	mlocal(k,2,2)=mlocal(k,2,2)*1.;
	mlocal(k,2,3)=mlocal(k,2,3)*dx(k);
	mlocal(k,2,5)=mlocal(k,2,5)*1.;
	mlocal(k,2,6)=mlocal(k,2,6)*dx(k);
	mlocal(k,3,3)=mlocal(k,3,3)*dx(k)^2;
	mlocal(k,3,5)=mlocal(k,3,5)*dx(k);
	mlocal(k,3,6)=mlocal(k,3,6)*dx(k)^2;
	mlocal(k,5,5)=mlocal(k,5,5)*1.;
	mlocal(k,5,6)=mlocal(k,5,6)*dx(k);
	mlocal(k,6,6)=mlocal(k,6,6)*dx(k)^2;
%
   
%
% symmetry
%
	for i=1:6
		for j=i:6
            mlocal(k,i,j)=mlocal(k,i,j)*dx(k)*rho/420.; 
			mlocal(k,j,i)=mlocal(k,i,j);
        end
    end
        
%
end