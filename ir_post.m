
id=eye(2,2);

R=id-two_dof_mass*1*1

Gc=two_dof_stiffness;

Gc(1,:)=[];
Gc(:,1)=[];

Gc

Ge=R'*Gc*R