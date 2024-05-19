
% strain_transformation_alt.m  ver 1.0  by Tom Irvine

function[Mr1,Pr1,Mmax1,Pmax1,Mr2,Pr2,Mmax2,Pmax2]=strain_transformation_alt(a,b)

sz=size(a);
n=sz(1);

A=0.93266;
E=1.0e+07;

C=25.866;

Mr1=zeros(n,2);
Pr1=zeros(n,2);
Mr2=zeros(n,2);
Pr2=zeros(n,2);

Mr1(:,1)=a(:,1);
Pr1(:,1)=a(:,1);
Mr2(:,1)=a(:,1);
Pr2(:,1)=a(:,1);

for i=1:n
    PTVC1=E*A*a(i,2)*1.0e-06;
    PTVC2=E*A*b(i,2)*1.0e-06;
    U=PTVC1*C;
    V=PTVC2*C;
    Mr1(i,2)=sqrt(U^2);
    Pr1(i,2)=Mr1(i,2)/C;
    Mr2(i,2)=sqrt(V^2);
    Pr2(i,2)=Mr2(i,2)/C;    
end

Pmax1=max(abs(Pr1(:,2)));
Mmax1=max(abs(Mr1(:,2)));
Pmax2=max(abs(Pr2(:,2)));
Mmax2=max(abs(Mr2(:,2)));

out1=sprintf(' %8.5g \t %8.5g \t %8.5g \t %8.5g  ',Pmax1,Mmax1,Pmax2,Mmax2);
disp(out1);