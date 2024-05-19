%
%   freefree_beam_column_assembly_6dof.m  ver 1.1  by Tom Irvine
%
function[stiff,mass,ivector]=...
      freefree_beam_column_assembly_6dof(ne,klocal,mlocal,dof,npm,pmloc,pm,xx)
%    
    ivector=zeros(dof,3);   
%
    for i=1:6:dof
        ivector(i,1)=1;
    end
    for i=2:6:dof
        ivector(i,2)=1;
    end  
    for i=3:6:dof
        ivector(i,3)=1;
    end     
    

    sg=zeros(dof,dof);
    mg=zeros(dof,dof);    
%
    ii=0;
    jj=0;
    for k=1:ne
        
        for i=1:12
			for j=1:12
				 sg(ii+i,jj+j)=sg(ii+i,jj+j)+klocal(k,i,j);
				 mg(ii+i,jj+j)=mg(ii+i,jj+j)+mlocal(k,i,j);
            end
        end
        ii=ii+6;
        jj=jj+6;
    end

%%%%

%
clear mass;
clear stiff;
%
stiff=sg;
mass=mg;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

XL=zeros(npm,1);

for i=1:npm
 
   ldof=1; 
    
   err=1.0e+20; 
   
   for j=1:(ne+1)
 
       ae=abs(xx(j)-pmloc(i));
 
       if( ae<err)
           err=ae;
           ldof=j;
           XL(i)=xx(j);
       end
 
   end
   
   k=3*ldof-2;
   mass(k,k)=mass(k,k)+pm(i);
   k=3*ldof-1;
   mass(k,k)=mass(k,k)+pm(i);
   k=3*ldof;
   mass(k,k)=mass(k,k)+pm(i);   
   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
