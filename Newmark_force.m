
%
% Newmark_force_mdof.m  ver 1.0  by Tom Irvine
%

function[U,Ud,Udd]=Newmark_force(DI,VI,dt,NT,ndof,M,C,K,FFI,force_dof)
%
alpha=0.25;
beta=0.5;
a0=1/(alpha*(dt^2));
a1=beta/(alpha*dt);
a2=1/(alpha*dt);
a3=(1/(2*alpha))-1;
a4=(beta/alpha)-1;
a5=(dt/2)*((beta/alpha)-2);
a6=dt*(1-beta);
a7=beta*dt;
%
KH=zeros(ndof,ndof);
%
KH=K+a0*M+a1*C;
%    
U=zeros(ndof,NT);
Ud=zeros(ndof,NT);
Udd=zeros(ndof,NT);
%
U(:,1)=DI;
Ud(:,1)=VI;    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
for(i=2:NT)
%
   F=zeros(ndof,1);
%
   for j=1:ndof
      j_index=force_dof(j);
      if(j_index~=-999)
         F(j)=FFI(i,j_index);
      end
   end         
%
   V1=(a1*U(:,i-1)+a4*Ud(:,i-1)+a5*Udd(:,i-1));
   V2=(a0*U(:,i-1)+a2*Ud(:,i-1)+a3*Udd(:,i-1));
%        
   CV=C*V1;
   MA=M*V2;
%
   FH=F+MA+CV;
%
%  solve for displacements
%
   if(ndof>1)
      Un = KH\FH;
   else
      Un= FH/KH;
   end    
%        
   Uddn=a0*(Un-U(:,i-1))-a2*Ud(:,i-1)-a3*Udd(:,i-1);
   Udn=Ud(:,i-1)+a6*Udd(:,i-1)+a7*Uddn;
%        
   U(:,i)=Un;
   Ud(:,i)=Udn;
   Udd(:,i)=Uddn; 
%
end