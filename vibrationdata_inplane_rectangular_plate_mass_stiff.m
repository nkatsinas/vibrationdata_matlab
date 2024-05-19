%
%   vibrationdata_inplane_rectangular_plate_mass_stiff.m  ver 1.2
%
function[mass,stiff]=vibrationdata_inplane_rectangular_plate_mass_stiff...
  (nelem,nodex,nodey,node1,node2,node3,node4,thick,dof,rho,E,mu)

%
mass=zeros(dof,dof);
stiff=zeros(dof,dof);
total_volume=0;
total_mass=0;
%
progressbar;
%
for ijk=1:nelem
%
    progressbar(ijk/nelem);
%
    el=abs(nodex(node1(ijk))-nodex(node2(ijk)));
    ew=abs(nodey(node1(ijk))-nodey(node4(ijk)));
    area=el*ew;
    volume=thick*area;
    elem_mass=volume*rho;
%
    a=el/2;
    b=ew/2;
%
    if ijk==1
        
        [klocal]=inplane_plate_local_stiff(a,b,thick,E,mu);
        [mlocal]=inplane_plate_local_mass(a,b,thick,rho);
        
    end
%
    total_volume=total_volume+volume;
    total_mass=total_mass+elem_mass;
    
%%    out1=sprintf(' %d %8.4g %8.4g  ',ijk,total_mass,elem_mass);    
%%    disp(out1);
%
    n1=(2*node1(ijk))-1;
    n2=(2*node2(ijk))-1;
    n3=(2*node3(ijk))-1;
    n4=(2*node4(ijk))-1;
%
    pr=[n1 n1+1  n2 n2+1  n3 n3+1  n4 n4+1  ];
    pc=pr;       
%
    for i=1:8 
        for j=1:8
             mass(pr(i),pc(j))= mass(pr(i),pc(j))+mlocal(i,j);            
            stiff(pr(i),pc(j))=stiff(pr(i),pc(j))+klocal(i,j);
        end
    end
%
end
%
pause(0.5);
%
%% if(dof==8)
%%     mass
%%     stiff
%% end

disp(' ');
out1=sprintf(' total_volume = %8.4g  ',total_volume);
disp(out1);
out1=sprintf(' total_mass = %8.4g  \n',total_mass);
disp(out1);

