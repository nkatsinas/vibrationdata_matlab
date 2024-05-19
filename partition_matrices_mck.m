%
%  partition_matrices_mck.m  ver 1.3  by Tom Irvine
%
%  Partition Mass, Damping Coefficient & Stiffness Matrices
%
%%%%%%%%%%%%%%%%%%%%% Mdd Kdd %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[fn,omega,ModeShapes,MST,Mwd,Cwd,Kwd,Mww,Cww,Kww,TT,T1,T2,KT,CT,MT]=...
    partition_matrices_mck(mass,cdamping,stiff,num,nfree,nem,free_dof,...
                                        enforced_dof,enforced_string,dispm)
%
disp(' ')
enforced_string
disp(' ')
%
Mdd=mass;
Cdd=cdamping;
Kdd=stiff;


for i=nfree:-1:1
    row=free_dof(i);
    col=row;
    
%
    Mdd(row,:)=[];
    Mdd(:,col)=[];   
%
    Cdd(row,:)=[];
    Cdd(:,col)=[];     
%
    Kdd(row,:)=[];
    Kdd(:,col)=[];   
%
end
%
%%%%%%%%%%%%%%%%%%%%% Mdf Kdf %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
Mdf=mass;
Cdf=cdamping;
Kdf=stiff;
for i=nfree:-1:1
    row=free_dof(i);
%
    Mdf(row,:)=[];
    Cdf(row,:)=[];    
    Kdf(row,:)=[]; 
%
end
%
for i=nem:-1:1
    col=enforced_dof(i);
%
    Mdf(:,col)=[];
    Cdf(:,col)=[];    
    Kdf(:,col)=[]; 
%
end
%
%%%%%%%%%%%%%%%%%%%%% Mfd Kfd %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
Mfd=Mdf';
Cfd=Cdf';
Kfd=Kdf';
%
%%%%%%%%%%%%%%%%%%%%%%% Mff Kff %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
Mff=mass;
Cff=cdamping;
Kff=stiff;
%
for i=nem:-1:1
    row=enforced_dof(i);
    col=row;
%
    Mff(row,:)=[];
    Mff(:,col)=[];  
%
    Cff(row,:)=[];
    Cff(:,col)=[];    
%
    Kff(row,:)=[];
    Kff(:,col)=[];   
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
I=eye(nem,nem);
T2=eye(nfree,nfree);
%
if(strcmp(enforced_string, 'disp')==1)
   invMff=pinv(Mff);
   T1=-invMff*Mfd;
else
   invKff=pinv(Kff);
   T1=-invKff*Kfd;
end
%
TT=zeros(num,num);
%
TT(1:nem,1:nem)=I;
TT(nem+1:num,1:nem)=T1;
TT(nem+1:num,nem+1:num)=T2;
%
MP=zeros(num,num);
MP(1:nem,1:nem)=Mdd;
MP(1:nem,nem+1:num)=Mdf;
MP(nem+1:num,1:nem)=Mfd;
MP(nem+1:num,nem+1:num)=Mff;
%
CP=zeros(num,num);
CP(1:nem,1:nem)=Cdd;
CP(1:nem,nem+1:num)=Cdf;
CP(nem+1:num,1:nem)=Cfd;
CP(nem+1:num,nem+1:num)=Cff;
%
KP=zeros(num,num);
KP(1:nem,1:nem)=Kdd;
KP(1:nem,nem+1:num)=Kdf;
KP(nem+1:num,1:nem)=Kfd;
KP(nem+1:num,nem+1:num)=Kff;
%
MT=TT'*MP*TT;
%
CT=TT'*CP*TT;
%
KT=TT'*KP*TT;
%
if(dispm==1)
    MT
    CT
    KT
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% [fn,omega,ModeShapes,MST]=Generalized_Eigen(KT,MT,1);
%
disp(' ');

Mwd=MT(nem+1:num,1:nem);
Cwd=CT(nem+1:num,1:nem);
Kwd=KT(nem+1:num,1:nem);
%
Mww=MT(nem+1:num,nem+1:num);
Cww=CT(nem+1:num,nem+1:num);
Kww=KT(nem+1:num,nem+1:num);
%
if(dispm==1)
    Mww
    Cww
    Kww
end
%
%
disp(' Calculating eigenvalues... ');
%
N=max(size(Mww));
%
if(N<30)
    [fn,omega,ModeShapes,MST]=Generalized_Eigen(Kww,Mww,1);
else
    [fn,omega,ModeShapes,MST]=Generalized_Eigen(Kww,Mww,2);    
end