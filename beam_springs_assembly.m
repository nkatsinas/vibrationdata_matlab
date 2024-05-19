%
%   beam_springs_assembly.m  ver 1.0  July 24, 2015
%
function[stiff,mass,dof,dof_status,XL]=...
    beam_springs_assembly(ne,klocal,mlocal,LBC,RBC,dof,dx,k1,k2,npm,pmloc,pm,xx)
%
    dof_status=ones(dof,1);
%
    sg=zeros(dof,dof);
    mg=zeros(dof,dof);    
%
    for i=1:dof
			for j=1:dof
         		 sg(i,j)=0.;
				 mg(i,j)=0.;        
            end
    end
%
   ii=0;
   jj=0;
    for k=1:ne
        
        for i=1:4
			for j=1:4
				 sg(ii+i,jj+j)=sg(ii+i,jj+j)+klocal(k,i,j);
				 mg(ii+i,jj+j)=mg(ii+i,jj+j)+mlocal(k,i,j);
            end
        end
        ii=ii+2;
        jj=jj+2;
    end
%%%%

        sg(1,1)=sg(1,1)+k1;
sg(dof-1,dof-1)=sg(dof-1,dof-1)+k2;

%%%%

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
   
   k=2*ldof-1;
      
   mg(k,k)=mg(k,k)+pm(i);
   
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
clear mass;
clear stiff;
%
stiff=sg;
mass=mg;
%
N=max(size(mass));
%
%
if(RBC==2) % right pinned
%    
     stiff(N,:)=[];
     stiff(:,N)=[];
     mass(N,:)=[];
     mass(:,N)=[];
%
     dof_status(N)=0;       
%     
end
if(LBC==2) % left pinned
%    
     stiff(2,:)=[];
     stiff(:,2)=[];
%
     mass(2,:)=[];
     mass(:,2)=[];
%
     dof_status(2)=0; 
%
end
%
%
dof=max(size(mass));
%
