
%   step_partition_function.m  ver 1.1  by Tom Irvine

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables:
%
%     dof status = 1D constraint array.  
%                         Index is the dof number.
%                         Value=0 for fixed
%                               1 for free
%
%                         Row 1 is node 1 translation
%                         Row 2 is node 1 rotation
%                         Then repeat pattern for each pair
%
%      mass_unc,stiff_unc = unconstrained mass & stiffness matrices
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions: 
% 
%      enforced_partition_matrices
%      Generalized_Eigen
%      track_changes
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output variables:
%
%   TT,T1,T2 = transformation matrices from Reference 1
%   Mwd,Mww,Kwd,Kww = mass & stiffness matrices from Reference 1.
%
%  Reference 1:
%  \\blueorigin\fs\Systems\Loads-Dynamics\Vibroacoustics\Tools\tutorials\FRF_enforced_motion.pdf
%
%   omegan = angular natural frequencies from partitioned system
%   ModeShapes = mass-normalized mode shapes from partitioned system
%   
%      num_Tz=length of TZ_tracking array
%      TZ_tracking_array=reordered displacement vector Ur index referenced 
%                        to all translational dof
%
%      constraint_matrix:
%                column 1:  node
%                column 2:  translation 0=free 1=fixed
%                column 3:  rotation:   0=free 1=fixed
%
%      ngw=array with displacement U row for: 
%          each driven translation dof in order
%          followed by each remaining dof in order omitting constrained 
%          rotational dof
%
%      nem=number of dof with enforced acceleration
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Internal variables:
%
%    ea = array with enforced translational dof numbers
%
%    num = total dof
%
%    etype =1  enforced acceleration
%           2  enforced displacement
%

function[TT,T1,T2,Mwd,Mww,Kwd,Kww,num_Tz,TZ_tracking_array,free_dof_array,...
   constraint_matrix,omegan,ModeShapes,ngw,nem]=step_partition_function(dof_status,mass_unc,stiff_unc)

mass=mass_unc;
stiff=stiff_unc;

sz=size(mass);
dof=sz(1);

tracking_array=zeros(dof,1);
free_dof_array=zeros(dof,1);

for i=1:dof
    tracking_array(i)=i;
    free_dof_array(i)=i;
end

num_nodes_Tz_free=round(dof/2);

TZ_tracking_array=zeros(num_nodes_Tz_free,1);

for i=1:num_nodes_Tz_free
   TZ_tracking_array(i)=2*i-1;
end

num_Tz=length(TZ_tracking_array);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k=1;

for i=1:num_nodes_Tz_free
    
    if( dof_status(2*i-1)==0 || dof_status(2*i)==0)
        constraint_matrix(k,:)=[i 0 0];
        
        if(dof_status(2*i-1)==0)
            constraint_matrix(k,2)=1;
        end
        if(dof_status(2*i)==0)
            constraint_matrix(k,3)=1;
        end     
        
        k=k+1;
    end    
        
end


k=1;

ibc=1;

n=length(constraint_matrix(:,1));   
    
for i=1:n
    
    if(constraint_matrix(i,2)==1)
        ea(k)=2*constraint_matrix(i,1)-1;
        k=k+1;
    end
        
    if(constraint_matrix(i,3)==1)
        rot_constraint_matrix(ibc,1)=constraint_matrix(i,1);
        rot_constraint_matrix(ibc,2)=0;
        rot_constraint_matrix(ibc,3)=constraint_matrix(i,3);
        ibc=ibc+1;
    end
            
end

ibc=ibc-1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(constraint_matrix);

nc=sz(1);

k=1;
for i=1:nc 
    
     cmn=constraint_matrix(i,1);
    
     if(constraint_matrix(i,2)==1)
        cdof(k)=2*cmn-1;
        k=k+1;
     end    
     if(constraint_matrix(i,3)==1)
        cdof(k)=2*cmn;
        k=k+1;
     end   
end

cdof=sort(cdof,'descend');

for i=1:length(cdof)
    free_dof_array(cdof(i))=[];
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k=1;
for i=1:ibc 
     if(rot_constraint_matrix(i,3)==1)
        rot_dof(k)=2*rot_constraint_matrix(i,1);
        k=k+1;
     end
end

try
    rot_dof=sort(rot_dof);
    ibc=length(rot_dof);    
catch
    rot_dof=0;
    ibc=0;
end
    
ea=unique(ea);
nem=length(ea);
ea=fix_size(ea);

if(ibc>=1)  % correct enforced acceleration ea matrix
    
    rot_dof=sort(rot_dof,'descend');
    
    for i=1:ibc
        for j=1:nem
            if(ea(j)>rot_dof(i))
                ea(j)=ea(j)-1;
            end
        end
    end
    
    drot_dof=sort(rot_dof,'descend');
    
    for i=1:ibc
        
      tracking_array(drot_dof(i))=[];
         
    end   

    
    for i=1:ibc
        for j=1:num_nodes_Tz_free
            if( TZ_tracking_array(j)>rot_dof(i) )
                   TZ_tracking_array(j)=TZ_tracking_array(j)-1;
            end       
        end
    end    
    
    
end

ea=unique(ea);
nem=length(ea);

if(nem==0)
    warndlg('No drive dofs');
    return;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Apply rotational constraints
%
try
    sz=size(rot_constraint_matrix);
catch
    rot_constraint_matrix=0;
    sz(1)=0;
end
    
for i=sz(1):-1:1
    if(rot_constraint_matrix(i,3)==1)
        p=2*rot_constraint_matrix(i,1);
         mass(:,p)=[];
         mass(p,:)=[];
        stiff(:,p)=[];
        stiff(p,:)=[];      
    end
end


sz=size(mass);
num=sz(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ngw]=track_changes(nem,num,ea);
 
etype=1;  % enforced acceleration 
dtype=2;  % do not display partitioned matrices

% partition matrices according to enforced motion dof

[TT,T1,T2,Mwd,Mww,Kwd,Kww]=...
                enforced_partition_matrices(num,ea,mass,stiff,etype,dtype);

% Generalized eigenvalue problem for partitioned matrices            
            
[~,part_omega,part_ModeShapes,~]=Generalized_Eigen(Kww,Mww,2);            
            
omegan=part_omega;
ModeShapes=part_ModeShapes;