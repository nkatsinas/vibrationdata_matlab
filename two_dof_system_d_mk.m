
%   two_dof_system_d_mk.m  ver 1.0 by Tom Irvine

function[mass,stiffness]=two_dof_system_d_mk(M,J,K1,K2,L1,L2,iu)

if(iu==1)
    M=M/386;
    J=J/386;
end

mass=[M 0; 0 J];
stiffness(1,1)=K1+K2;
stiffness(1,2)=-K1*L1+K2*L2;
stiffness(2,2)=K1*L1^2+K2*L2^2;
stiffness(2,1)=stiffness(1,2);

if(iu==1)
    disp(' mass matrix:  m11 (lbf sec^2/in) & m22 (lbf sec^2 in) ');
else
    disp(' mass matrix:  m11 (kg) & m22 (kg m^2) ');    
end
    
fprintf(' %8.4g  %8.4g  \n',mass(1,1),mass(1,2));
fprintf(' %8.4g  %8.4g \n\n',mass(2,1),mass(2,2));


if(iu==1)
    disp(' stiffness matrix:  ');
    disp('     k11 (lbf/in) & k12 (lbf/rad) & k22 (lbf in/rad) ');    
else
    disp(' stiffness matrix:  ');    
    disp('     k11 (N/m) & k12 (N/rad) & k22 (N m/rad) ');    
end


fprintf(' %8.4g  %8.4g \n',stiffness(1,1),stiffness(1,2));
fprintf(' %8.4g  %8.4g \n\n',stiffness(2,1),stiffness(2,2));
