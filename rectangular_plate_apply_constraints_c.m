%
%   rectangular_plate_apply_constraints_c.m  ver 1.3  by Tom Irvine
%
function[mass,stiff,pp,con,qicenter,qctdof,ivector]=...
    rectangular_plate_apply_constraints_c(constraint_matrix,ibc,mass,stiff,icenter,ctdof)
%
disp('Constraint matrix')
constraint_matrix
disp('ibc')
ibc
disp('ctdof')
ctdof
disp('icenter')
icenter

sz=size(mass);

ivector=zeros(sz(1),1);

for i=1:3:(sz(1)-2)
   ivector(i)=1; 
end


qicenter=icenter;
qctdof=ctdof;

clear THM;
THM = constraint_matrix;
%
sz = size(THM);
nc=sz(1);

pp=0;  % need this line
%
if(nc>=1)
%%     disp(' ');
%%     disp(' The constraint matrix must have three four columns:  node number   TZ RX RY ');
%%     disp(' A value of 1 indicates a constraint.  A value of 0 indicates free. ');
%%     disp(' ');
%

    disp(' Apply constraints to dof ');

    disp('nc')
    nc
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
           con(ij)=3*nodec-2;
           ij=ij+1;
        end
%        
        if(THM(i,3)==1)
           con(ij)=3*nodec-1;
           ij=ij+1;
        end
%     
        if(THM(i,4)==1)
           con(ij)=3*nodec;
           ij=ij+1;
        end       
%
    end
    pause(0.3);
    progressbar(1);
%
    disp(' Sort constraints ');

    clear length;
    pp=length(con);
    con=con';
    con=sort(con,1,'descend');
    con;
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for i=1:length(nc)
       if(THM(i,1)<icenter)

           qctdof=qctdof-sum(THM(i,2:4));
           
       end
    end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    disp(' Apply constraints to mass and stiffness matrices ');

    progressbar;
    for ij=1:pp
        progressbar(ij/pp);
%        
         k=con(ij);

         mass(:,k)=[];
         mass(k,:)=[];
        stiff(:,k)=[];
        stiff(k,:)=[];   
        ivector(k)=[];
%
    end
    pause(0.3);
    progressbar(1);
%
end

