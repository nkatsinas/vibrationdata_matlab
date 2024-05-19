
% strain_transformation.m  ver 1.0  by Tom Irvine

function[Mr,Pr,Mmax,Pmax]=strain_transformation(a,b)

sz=size(a);
n=sz(1);

A=0.93266;
E=1.0e+07;

C=25.866;

Mr=zeros(n,2);
Pr=zeros(n,2);

Mr(:,1)=a(:,1);
Pr(:,1)=a(:,1);

for i=1:n
    PTVC1=E*A*a(i,2)*1.0e-06;
    PTVC2=E*A*b(i,2)*1.0e-06;
    U=PTVC1*C;
    V=PTVC2*C;
    Mr(i,2)=sqrt(U^2+V^2);
    Pr(i,2)=Mr(i,2)/C;
end

Pmax=max(abs(Pr(:,2)));
Mmax=max(abs(Mr(:,2)));

out1=sprintf(' %8.5g \t %8.5g  ',Pmax,Mmax);
disp(out1);