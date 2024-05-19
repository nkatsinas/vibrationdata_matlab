%
%  Generalized_Eigen_subspace.m  ver 1.1  August 31, 2012
%
function[fn,omega,ModeShapes,MST,nv]=Generalized_Eigen_subspace(S2,M2,ijk)
%
M=M2;
K=S2;
%
disp(' ');
disp(' Enter number of vectors ');
nv=input(' ');
%
disp(' ');
disp(' Enter maximum number of iterations ');
niter=input(' ');
%
%  Sample trial vectors
%
%
ndof=max(size(M));
%
Uhat2=zeros(ndof,nv);
U1=zeros(ndof,nv);
%
disp('  form trial vectors ');
%
U1=4*(0.5-rand(ndof,nv)); 
%
disp(' Normalize trial eigenvectors with respect to mass matrix ');
%
    nn=U1'*M*U1;
%
for i=1:nv
    U1(:,i)= U1(:,i)/sqrt(nn(i,i));
end
%
disp(' Calculate Kinv ');
%
Kinv=pinv(K);
%
disp(' Calculate Kinv_M ');
%
Kinv_M=Kinv*M;
%
disp(' Calculate U2 ');
%
U2=Kinv_M*U1;
%
error=zeros(nv,1);
%
disp(' ');
%
progressbar;
%
for ivk=1:niter
%
    progressbar(ivk/niter);
%
    K2=U2'*K*U2;
    M2=U2'*M*U2;
%
    [P2,A2]=eig(K2,M2);
%
    if ivk>1
        for i=1:nv
            error(i)=abs(  (A2(i,i)-A2_old(i,i))/A2(i,i) );
        end
 %
        max_error=max(error);
 %
        out1=sprintf(' %d  %8.4g ',ivk,max_error);
        disp(out1);
 %
        if(max_error<0.01)
            break;
        end
    end
%
    A2_old=A2;
%   
%   normalize with respect to mass matrix
%
    nn=P2'*M2*P2;
    for i=1:nv
        P2(:,i)= P2(:,i)/sqrt(nn(i,i));
    end    
%
    Uhat2=U2*P2;
%
    U3=Kinv_M*Uhat2;
    U2=U3;
end
%
progressbar(1);
%
%% disp(' Eigenvectors ');
%% Uhat2;
%% disp(' Eigenvalues ');
%% A2;
%
eee=zeros(nv,1);
for i=1:nv
    eee(i)=A2(i,i);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' Uhat2 ');
%
Eigenvalues=eee;
%
clear EEE;
clear max;
%
EEE=zeros(nv,ndof+1);
%
EEE=[eee Uhat2'];
EEE=sortrows(EEE);
%
ModeShapes=EEE(:,2:ndof+1)';
%
Eigenvalues=EEE(:,1);
%
omega = sqrt(Eigenvalues);
%
if(ijk==1 || ijk==3)
	disp(' Natural Frequencies ');
    disp(' No.      f(Hz)');
end
for(i=1:nv)
    fn(i)=omega(i)/(2*pi);
    if(ijk==1 || ijk==3)
       out1=sprintf('%d.  %12.5g ',i,fn(i));
       disp(out1);
    end
end
%
%
clear MST;
clear temp;
clear QTMQ;
%
MST=ModeShapes';
%
sz_M=size(M);
sz_ModeShapes=size(ModeShapes);
%
temp=zeros(sz_M(1),sz_ModeShapes(2));
temp=M*ModeShapes;
QTMQ=MST*temp;
%   
clear scale;
for(i=1:nv)
    scale(i)=1./sqrt(QTMQ(i,i));
    if(sum(ModeShapes(:,i))<0)
        scale=-scale;
    end
    ModeShapes(:,i) = ModeShapes(:,i)*scale(i);    
end
%
MST=ModeShapes';
%
if(ijk==1)
   disp(' ');
   disp('  Modes Shapes (column format)');
   ModeShapes
end