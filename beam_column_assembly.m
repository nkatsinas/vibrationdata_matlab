%
%   beam_column_assembly.m  ver 1.2  by Tom Irvine
%
function[stiff,mass,stiff_unc,mass_unc,dof,dof_status,XL,ivector_x,ivector_y]=...
                beam_column_assembly(ne,klocal,mlocal,LBC,RBC,dof,npm,pmloc,pm,xx)
%
    dof_status=ones(dof,1);
    ivector_x=zeros(dof,1);
    ivector_y=zeros(dof,1);
%
    for i=1:3:dof
        ivector_x(i)=1;
    end
    for i=2:3:dof
        ivector_y(i)=1;
    end    
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
        
        for i=1:6
			for j=1:6
				 sg(ii+i,jj+j)=sg(ii+i,jj+j)+klocal(k,i,j);
				 mg(ii+i,jj+j)=mg(ii+i,jj+j)+mlocal(k,i,j);
            end
        end
        ii=ii+3;
        jj=jj+3;
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
   
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

N=max(size(mass));
%

mass_unc=mass;
stiff_unc=stiff;


if(RBC==3) % right fixed
%
     stiff(N,:)=[];
     stiff(:,N)=[];
     mass(N,:)=[];
     mass(:,N)=[];
     ivector_x(N)=[];
     ivector_y(N)=[];     
%
     dof_status(N)=0;
%
end

if(RBC==2 || RBC==3) % right pinned or fixed
%    
     Nm1=N-1; 
     stiff(Nm1,:)=[];
     stiff(:,Nm1)=[];
     mass(Nm1,:)=[];
     mass(:,Nm1)=[];
     ivector_x(Nm1)=[];
     ivector_y(Nm1)=[];     
%
     dof_status(Nm1)=0;            
%     
     Nm2=N-2; 
     stiff(Nm2,:)=[];
     stiff(:,Nm2)=[];
     mass(Nm2,:)=[];
     mass(:,Nm2)=[];
     ivector_x(Nm2)=[];
     ivector_y(Nm2)=[];     
%
     dof_status(Nm2)=0;  
%
end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
if(LBC==3) % left fixed
%    
     stiff(3,:)=[];
     stiff(:,3)=[];
     mass(3,:)=[];
     mass(:,3)=[];
     ivector_x(3)=[];
     ivector_y(3)=[];     
%
     dof_status(2)=0; 
%
end
%
if(LBC==2 || LBC==3) % left pinned or fixed
%
     stiff(2,:)=[];
     stiff(:,2)=[];
     mass(2,:)=[];
     mass(:,2)=[];
     ivector_x(2)=[];
     ivector_y(2)=[];     
%
     dof_status(2)=0; 
%    
     stiff(1,:)=[];
     stiff(:,1)=[];
     mass(1,:)=[];
     mass(:,1)=[];
     ivector_x(1)=[];
     ivector_y(1)=[];     
%
     dof_status(1)=0; 
%
end
%
%
dof=max(size(mass));
%
dof
