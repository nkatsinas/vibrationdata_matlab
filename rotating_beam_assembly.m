%
%   rotating_beam_assembly.m  ver 1.0  August 3, 2015
%
function[stiff,mass,dof,dof_status]=...
                               rotating_beam_assembly(ne,klocal,mlocal,dof)
%
dof_status=ones(dof,1);
%
sg=zeros(dof,dof);
mg=zeros(dof,dof);    
%
ii=0;
jj=0;
%
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
mass=mg;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% left fixed
%
     stiff(1,:)=[];
     stiff(:,1)=[];
%
     mass(1,:)=[];
     mass(:,1)=[];     
%
%%%%%%%
%
     stiff(2,:)=[];
     stiff(:,2)=[];
%
     mass(2,:)=[];
     mass(:,2)=[];
%
     dof_status(1)=0;
     dof_status(2)=0; 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
dof=max(size(mass));
%