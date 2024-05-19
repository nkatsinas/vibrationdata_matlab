
function[ua1,ua2,ua3]=CB_example(THM)

t=THM(:,1);
y=THM(:,2);

Mbb=10;
Mib=[0 0 0]'
Mbi=Mib';
Mii=[8 0 0; 0 6 0; 0 0 5];
M=[Mii Mib; Mbi Mbb]

Kbb=100000;
Kib=[-100000 0 0]';
Kbi=Kib';
Kii=[190000 -90000 0; -90000 170000 -80000; 0 -80000 80000];
K=[Kii Kib; Kbi Kbb]

ijk=1;
S2=Kii;
M2=Mii;
[fn,omega,ModeShapes,MST]=Generalized_Eigen(S2,M2,ijk)

ndof=length(fn);


Lambda = diag(omega.^2);

Lambda

disp(' ')
disp('-pinv(Kii)*Kib')
-pinv(Kii)*Kib

psi_ib=-pinv(Kii)*Kib

CB=[ModeShapes psi_ib ; 0 0 0 1]


Mhat=CB'*M*CB

Khat=CB'*K*CB

Mhatkb=Mhat(1:3,4)

nt=length(y);

F=zeros(nt,ndof);

F = -y .* Mhatkb(1:ndof)';

nodal_force=F';



dampv=ones(ndof,1)*0.05;

dt=mean(diff(t));

omegan=omega;

[a1,a2,df1,df2,df3,vf1,vf2,vf3,af1,af2,af3]=...
             ramp_invariant_filter_coefficients_force(ndof,omegan,dampv,dt);
  
           
%
%  Numerical Engine
%
disp(' ')
disp(' Calculating response...');
%
nx=zeros(nt,ndof);
nv=zeros(nt,ndof);
na=zeros(nt,ndof);
%

for j=1:ndof
 
    fprintf('  j=%d ndof=%d \n',j,ndof);
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
end

ua=zeros(nt,ndof);

size(ua)
size(na)

 for i=1:nt
    for j=1:ndof
        ua(i,j)= ModeShapes(j,:)*na(i,:)' + psi_ib(j)*y(i);
    end
 end

% ua = ModeShapes(:, 1:ndof) * na' + psi_ib(1:ndof)' * y;  did not work



figure(1);
plot(t,ua(:,1))
xlabel('Time (sec)')

ua1=[t ua(:,1)];
ua2=[t ua(:,2)];
ua3=[t ua(:,3)];


