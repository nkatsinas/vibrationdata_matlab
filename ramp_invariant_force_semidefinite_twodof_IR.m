%
%  ramp_invariant_force_semidefinite_twodof_IR.m  ver 1.1  by Tom Irvine
%

function[x]=...
            ramp_invariant_force_semidefinite_twodof_IR(ModeShapes,F,ndof,sys_dof,omegan,dampv,dt,Ge)

disp('********');  
          
a=0
v=0
          
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


nx=zeros(NT,1);
nv=zeros(NT,1);
na=zeros(NT,1);

ue=zeros(2,NT);  % because two physical dof

%

progressbar;

for j=2:ndof
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
    nx=d_resp;  % displacement
    nv=v_resp;  % velocity
    na=a_resp;  % acceleration  
    
    term=( (na/omegan(j)^2) + nv*(2*dampv(j)/omegan(j)) );

    qqq=ModeShapes(:,j)*term;
    
    ue=ue+qqq;

end

pause(0.3);
progressbar(1);

disp(' ref 1 ');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
size(ue')

size(Ge)

size(F')

GeF=Ge*F';

size(GeF)

x=GeF' - ue';
x=x';

size(x);
uuu=input(' ');

figure(109);
plot(F(:,1));
