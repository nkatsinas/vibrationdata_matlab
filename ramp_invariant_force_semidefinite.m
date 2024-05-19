%
%  ramp_invariant_force_semidefinite.m  ver 1.1  by Tom Irvine
%

function[x,v,a,nx,nv,na]=...
                 ramp_invariant_force_semidefinite(ModeShapes,F,ndof,sys_dof,omegan,dampv,dt,Ge,num_modes)

             
sz=size(F);

NT=sz(1);
             
MST=ModeShapes';             

try
    nodal_force=MST*F';
catch
    size(MST)
    size(F')
    warndlg(' Dimension error in:  ramp_invariant_force ');
    return;
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Calculate Filter Coefficients
%

[a1,a2,df1,df2,df3,vf1,vf2,vf3,af1,af2,af3]=...
             ramp_invariant_filter_coefficients_force(ndof,omegan,dampv,dt);
         
%
%  Numerical Engine
%
disp(' ')
disp(' Calculating response...');
%
nx=zeros(NT,ndof);
nv=zeros(NT,ndof);
na=zeros(NT,ndof);
%

progressbar;

for j=1:ndof
    progressbar(j/ndof);
%
%  displacement
%
    d_forward=[   df1(j),  df2(j), df3(j) ];
    d_back   =[     1, -a1(j), -a2(j) ];
    d_resp=filter(d_forward,d_back,nodal_force(j,:));
%    
%  velocity
%
    v_forward=[   vf1(j),  vf2(j), vf3(j) ];
    v_back   =[     1, -a1(j), -a2(j) ];
    v_resp=filter(v_forward,v_back,nodal_force(j,:));
%    
%  acceleration
%   
    a_forward=[   af1(j),  af2(j), af3(j) ];
    a_back   =[     1, -a1(j), -a2(j) ]; 
    a_resp=filter(a_forward,a_back,nodal_force(j,:));
%
    nx(:,j)=d_resp;  % displacement
    nv(:,j)=v_resp;  % velocity
    na(:,j)=a_resp;  % acceleration  
%
    ue=ue+ModeShapes(:,j)*( (na(:,j)/omegan(j)^2) + na(:,j)*(2*dampv(j)/omegan(j)) )';
%
end
pause(0.3);
progressbar(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

clear x;
clear v;
clear a;
%
%%% x=zeros(NT,sys_dof);
v=zeros(NT,sys_dof);
a=zeros(NT,sys_dof);
%
for i=1:NT
%%%    x(i,:)=(ModeShapes(:,1:ndof)*((nx(i,:))'))';
    v(i,:)=(ModeShapes(:,1:ndof)*((nv(i,:))'))';
    a(i,:)=(ModeShapes(:,1:ndof)*((na(i,:))'))';    
end
%

x=( (Ge*F)' - ue);
