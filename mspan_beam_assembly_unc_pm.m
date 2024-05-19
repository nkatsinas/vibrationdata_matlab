%
%   mspan_beam_assembly_unc_pm.m  ver 1.0  by Tom Irvine
%
function[stiff,mass,stiff_unc,mass_unc,dof,dof_status,ivector]=...
                mspan_beam_assembly_unc_pm(ne,klocal,mlocal,LBC,RBC,dof,numi,int_index,npm,pmloc,pm,xx)
%
    dof_status=ones(dof,1);
    ivector=zeros(dof,1);
    
    for i=1:2:(dof-1)
        ivector(i)=1;
    end
%
    sg=zeros(dof,dof);
    mg=zeros(dof,dof);    
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

%
clear mass;
clear stiff;
%
stiff=sg;

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

mass=mg;

stiff_unc=sg;
mass_unc=mg;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

N=max(size(mass));
%

if(RBC==3) % right fixed
%
     stiff(N,:)=[];
     stiff(:,N)=[];
     mass(N,:)=[];
     mass(:,N)=[];
%
     dof_status(N)=0;
     ivector(N)=[];
%
end

if(RBC==2 || RBC==3) % right pinned or fixed
%    
     Nm1=N-1; 
     stiff(Nm1,:)=[];
     stiff(:,Nm1)=[];
     mass(Nm1,:)=[];
     mass(:,Nm1)=[];
%
     dof_status(Nm1)=0; 
     ivector(Nm1)=[];
%     
end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

for i=numi:-1:1
   
     np=2*int_index(i)-1;
    
     stiff(np,:)=[];
     stiff(:,np)=[];
     mass(np,:)=[];
     mass(:,np)=[];    
    
     dof_status(np)=0; 
     ivector(np)=[];
     
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
if(LBC==3) % left fixed
%    
     stiff(2,:)=[];
     stiff(:,2)=[];
%
     mass(2,:)=[];
     mass(:,2)=[];
%
     dof_status(2)=0;
     ivector(2)=[];
%
end
%
if(LBC==2 || LBC==3) % left pinned or fixed
%    
     stiff(1,:)=[];
     stiff(:,1)=[];
%
     mass(1,:)=[];
     mass(:,1)=[];
%
     dof_status(1)=0; 
     ivector(1)=[];     
%
end
%
%
dof=max(size(mass));
%
