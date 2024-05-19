%
%   rectangular_inplane_plate_apply_constraints.m  ver 1.0
%
function[mass,stiff,pp,con]=...
    rectangular_inplane_plate_apply_constraints(ip_constraint_matrix,ibc,mass,stiff)
%
%  Need to apply BCs
%


pp=0;  % need this line
%
if(ibc~=1)
%
    clear THM;
    THM = ip_constraint_matrix;
%
    sz = size(THM);
    nc=sz(1);
%
    clear con;
    ij=1;
%
    progressbar;
    for i=1:nc
        progressbar(i/nc);
%        
        nodec=THM(i,1);
%        
        if(THM(i,2)==1)
           con(ij)=2*nodec-1;
           ij=ij+1;
        end
%        
        if(THM(i,3)==1)
           con(ij)=2*nodec;
           ij=ij+1;
        end
%
    end
    progressbar(1);
%
    clear length;
    pp=length(con);
    con=con';
    con=sort(con,1,'descend');
    con;
%
    progressbar;
    for ij=1:pp
        progressbar(ij/pp);
%        
         k=con(ij);
         sz=size(mass);
%%         out1=sprintf(' k=%d   %d %d',k,sz(1),sz(2));
%%         disp(out1);
         mass(:,k)=[];
         mass(k,:)=[];
        stiff(:,k)=[];
        stiff(k,:)=[];        
%
    end
    progressbar(1);
%
end