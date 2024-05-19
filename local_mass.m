function [mlocal] = local_mass(rho,ne,dx)
%
 for k=1:ne
%
    mlocal(k,1,1)=156.;
    mlocal(k,1,2)=22.;
    mlocal(k,1,3)=54.;
    mlocal(k,1,4)=-13.;
    mlocal(k,2,2)=4.;
    mlocal(k,2,3)=13.;
    mlocal(k,2,4)=-3.;
    mlocal(k,3,3)=156.;
    mlocal(k,3,4)=-22.;
	mlocal(k,4,4)=4.;
%
	mlocal(k,1,1)=mlocal(k,1,1)*1.;
	mlocal(k,1,2)=mlocal(k,1,2)*dx(k);
	mlocal(k,1,3)=mlocal(k,1,3)*1.;
	mlocal(k,1,4)=mlocal(k,1,4)*dx(k);
	mlocal(k,2,2)=mlocal(k,2,2)*dx(k)^2;
	mlocal(k,2,3)=mlocal(k,2,3)*dx(k);
	mlocal(k,2,4)=mlocal(k,2,4)*dx(k)^2;
	mlocal(k,3,3)=mlocal(k,3,3)*1.;
	mlocal(k,3,4)=mlocal(k,3,4)*dx(k);
	mlocal(k,4,4)=mlocal(k,4,4)*dx(k)^2;
%
% symmetry
%
	for i=1:4
		for j=i:4
            mlocal(k,i,j)=mlocal(k,i,j)*dx(k)*rho/420.; 
			mlocal(k,j,i)=mlocal(k,i,j);
        end
    end
    
%
end