disp(' ');
disp(' rectangular_plate_fea.m   ver 1.9   February 26, 2013');
disp('  ');
disp(' by Tom Irvine   Email: tom@vibrationdata.com ');
disp(' ');
disp(' This script calculates the natural frequencies and ');
disp(' mode shapes of a flat, thin, rectangular plate. ');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
close all hidden;
%
clear mass;
clear stiff;
clear fn;
clear omega;
clear ModeShapes;
clear MST;
clear modes;
%
clear node_matrix;
clear element_matrix;
clear constraint_matrix;
%
clear emm;
clear pdof;
%
clear fig_num;
clear con;
%
iu=1;
%
fig_num=1;
%
[fig_num,number_nodes,node_matrix,element_matrix,nelem,...
       nodex,nodey,nx,ny,node1,node2,node3,node4,dof,L,W]=...
                rectangular_plate_nodes_elements(fig_num);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[D,rho,mu,beta,thick]=rectangular_plate_materials(iu,L,W);
rho_s=rho*thick;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
[mass,stiff,total_volume,total_mass]=rectangular_plate_mass_stiff...
  (nelem,nodex,nodey,node1,node2,node3,node4,mu,beta,thick,dof,rho,D);   
%
mass_unc=mass;
stiff_unc=stiff;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp('  ');
disp(' Select boundary Condition ');
disp(' 1=all free   2=corners pinned  3=corners fixed  4=other ');
disp('  ');
ibc=input(' ');
%
if(ibc ~=1)
%    
  [constraint_matrix,ibc,e1,e2,e3,e4]=...
    rectangular_plate_constraints(nx,ny,ibc);
%
  [mass,stiff,pp,con]=...
    rectangular_plate_apply_constraints(constraint_matrix,ibc,mass,stiff);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(ibc==1 || (e1+e2+e3+e4)==4)
    rigid=1;   % rigid body mode case
else
    rigid=0;
end
%
[fn,omega,ModeShapes,MST,nv]=Generalized_Eigen_fea(stiff,mass,rigid);
%
mstore=mass;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(ibc ~=1)
    [ModeShapes]=mode_shape_correction(dof,pp,con,ModeShapes);
end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
total_mass=total_mass/386;
[~]=pf_emm_fea_post1(mass_unc,dof,fn,total_mass,ModeShapes);
%
[fig_num]=...
rectangular_elements_plot_modes(nodex,nodey,fig_num,ModeShapes,fn,number_nodes);
%
disp(' ');
disp(' Output Matrices ');
disp(' ');
disp('    node_matrix ');
disp('    element_matrix ');
%
if(ibc ~=1)
    disp('    constraint_matrix ');
end