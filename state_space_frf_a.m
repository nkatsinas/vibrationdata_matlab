%
% state_space_frf_a.m  ver 1.0  by Tom Irvine
%
%
%  This script calculates an FRF for a system with a damping matrix
%  using the state space method.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input variables
%
%    M - mass array
%    C - damping array
%    K - stiffness array
%
%    freq - frequency (Hz) vector for the FRF.
%
%    dof1 - force input dof
%    dof2 - response dof
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output arrays, all complex
%
%    Hd - FRF (displacement/force)
%    Hv - FRF (velocity/force)
%    Ha - FRF (acceleration/force)
%
%    lambda - eigenvalues
%    ModeShapes  - mode shapes
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[Hd,Hv,Ha,lambda,ModeShapes]=state_space_frf_a(M,C,K,freq,dof1,dof2)

sz=size(M);

Z=zeros(sz(1),sz(1));

A=[ C M ; M  Z ];
B=[ K Z ; Z -M ];

[ModeShapes,Evals]=eig(B,-A);

szz=max(size(Evals));

EEE=zeros(szz,szz+2);

for i=1:szz
    EEE(i,1)=abs(Evals(i,i));
    EEE(i,2)=Evals(i,i);    
end
EEE(:,3:szz+2)=transpose(ModeShapes);
EEE=sortrows(EEE);

% Eigenvalues=EEE(:,2);
ModeShapes=transpose(EEE(:,3:szz+2));
MST=transpose(ModeShapes);

ar=MST*A*ModeShapes;
br=MST*B*ModeShapes;


lambda = -diag(br) ./ diag(ar);

two_N=length(lambda);

i=dof1;
j=dof2;

np=length(freq);

Hd=zeros(np,1);
Hv=zeros(np,1);      
Ha=zeros(np,1);   
        
omega=2*pi*freq;

for kj=1:np
            
    jomega=omega(kj)*1i;

    for r=1:two_N
                
        num=ModeShapes(i,r)*ModeShapes(j,r);
                
        den=ar(r,r)*( jomega -lambda(r));

        Hd(kj)=Hd(kj)+num/den;
                
    end
                
    Hv(kj)=jomega*Hd(kj);
    Ha(kj)=-omega(kj)^2*Hd(kj);
            
end            
            