%
%   vibrationdata_rectangular_plate_mass_stiff.m  ver 1.1  May 7, 2015
%
function[mass,stiff,total_volume]=vibrationdata_rectangular_plate_mass_stiff...
  (nelem,nodex,nodey,node1,node2,node3,node4,mu,beta,thick,dof,rho,D)
%
mass=zeros(dof,dof);
stiff=zeros(dof,dof);
total_volume=0;
%
progressbar;
%
for ijk=1:nelem
%
    progressbar(ijk/nelem);
%
    if ijk==1
        [mass_local,stiff_local,area]=...
         plate_mass_stiff(nodex,nodey,node1,node2,node3,node4,mu,beta,ijk);
    end
%
    total_volume=total_volume+area*thick;
%
    n1=(3*node1(ijk))-2;
    n2=(3*node2(ijk))-2;
    n3=(3*node3(ijk))-2;
    n4=(3*node4(ijk))-2;
%
    pr=[n1 n1+1 n1+2  n2 n2+1 n2+2  n3 n3+1 n3+2  n4 n4+1 n4+2  ];
    pc=pr;       
%
    for i=1:12 
        for j=1:12
             mass(pr(i),pc(j))= mass(pr(i),pc(j))+mass_local(i,j);            
            stiff(pr(i),pc(j))=stiff(pr(i),pc(j))+stiff_local(i,j);
        end
    end
%
end
%
pause(0.5);
%
progressbar(1); 
%
stiff=stiff*D;
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass=mass*rho*thick;
%