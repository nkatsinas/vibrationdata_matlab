%
%   Newmark_modal_force_MA.m  ver 1.5  January 20, 2014
%
function[U,Ud,Udd]=...
   Newmark_modal_force_MA(DI,VI,dt,NT,ndof,damp,omegan,FFI,force_dof,ModeShapes,M,K)
%
disp(' ');
out1=sprintf(' Select number of modes to include (max=%d) ',ndof);
num_modes=input(out1);
if(num_modes>ndof)
    num_modes=ndof;
end
%
MS=ModeShapes(:,1:num_modes);
clear ModeShapes;
ModeShapes=MS;
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
KH=zeros(num_modes,1);
%
mm=zeros(num_modes,1);
cc=zeros(num_modes,1);
kk=zeros(num_modes,1);
%
for j=1:num_modes
    mm(j)=1;
    cc(j)=2*damp(j)*omegan(j);
    kk(j)=(omegan(j))^2;
    KH(j)=kk(j)+a0*mm(j)+a1*cc(j);
end
%
U=zeros(ndof,NT);
Ud=zeros(ndof,NT);
Udd=zeros(ndof,NT); 
%
nU=zeros(num_modes,NT);
nUd=zeros(num_modes,NT);
nUdd=zeros(num_modes,NT); 
%
sz=size(DI);
if(sz(2)>sz(1))
    DI=DI';
end
%
sz=size(VI);
if(sz(2)>sz(1))
    VI=VI';
end
%
MST=ModeShapes';
nU(:,1)=MST*(M*DI);
nUd(:,1)=MST*(M*VI);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
for i=2:NT
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
%%    num_modes
%%    size(MST)
%%    size(F)
   nF=MST*F;
%
   for j=1:num_modes
      V1=(a1*nU(j,i-1)+a4*nUd(j,i-1)+a5*nUdd(j,i-1));
      V2=(a0*nU(j,i-1)+a2*nUd(j,i-1)+a3*nUdd(j,i-1));
%        
      CV=cc(j)*V1;
      MA=mm(j)*V2;
%
      FH=nF(j)+MA+CV;
%
%  solve for displacements
%   
      nUn= FH/KH(j);
%        
      nUddn=a0*(nUn-nU(j,i-1))-a2*nUd(j,i-1)-a3*nUdd(j,i-1);
      nUdn=nUd(j,i-1)+a6*nUdd(j,i-1)+a7*nUddn;
%
      nU(j,i)=nUn;
      nUd(j,i)=nUdn;
      nUdd(j,i)=nUddn;
%
   end
%
end
%
for i=1:NT
    U(:,i)=ModeShapes*nU(:,i);
   Ud(:,i)=ModeShapes*nUd(:,i);
  Udd(:,i)=ModeShapes*nUdd(:,i);
end  
%
if(num_modes<ndof)
    disp(' ');
    disp(' Apply mode acceleration method to refine displacements?  1=yes 2=no ');
    ima=input(' ');
%    
    if(ima==1)
        disp(' ');
        disp(' Select technique: ');
        disp('  1=subset of modes x modal forces ');
        disp('  2=inverse of stiffness matrix x external forces ');
        itech=input(' ');
%
        a=zeros(num_modes,1);
        b=zeros(num_modes,1);
%        
        for i=1:num_modes
            a(i)=2*damp(i)/omegan(i);
            b(i)=1/omegan(i)^2;
        end
%
        terms=zeros(num_modes,NT);
        for ijk=1:NT 
           for i=1:num_modes
               terms(i,ijk)=terms(i,ijk)+(a(i)*nUd(i,ijk) + b(i)*nUdd(i,ijk));
           end
        end
%%        num_modes
%
        if(itech==1)
            for ijk=1:NT   
%
                for j=1:ndof
                    j_index=force_dof(j);
                    if(j_index~=-999)
                        F(j)=FFI(ijk,j_index);
                    end
                end
%
                nF=MST*F;
                A=zeros(ndof,1);
                for k=1:ndof
                    for i=1:num_modes
                        A=A+MS(k,i)*nF(i)*b(i);
                    end
                end
%
                U(:,ijk)=A-MS*terms(:,ijk); 
            end      
        else
            invK=pinv(K);
            for ijk=1:NT
%
                for j=1:ndof
                    j_index=force_dof(j);
                    if(j_index~=-999)
                        F(j)=FFI(ijk,j_index);
                    end
                end 
%
%%                size(invK)
%%                size(F)
%%                size(MS)
%%                size(terms)
                U(:,ijk)=invK*F-MS*terms(:,ijk);                 
            end               
        end
%      
    end
%
end    