%
%   clf_bolted_joint.m  ver 1.0  by Tom Irvine
%

function[clf_12,clf_21]=clf_bolted_joint(N,f,S_1,S_2,em_1,em_2,...
                                       mu_1,mu_2,md_1,md_2,thick_1,thick_2)
                                   

                                                                      
cL_1=sqrt(em_1/(md_1*(1-mu_1^2)));
cL_2=sqrt(em_2/(md_2*(1-mu_2^2)));

term1=md_1*(thick_1^2)*cL_1;
term2=md_2*(thick_2^2)*cL_2;

num=term1*term2;
den=(term1+term2)^2;

A=4*N/sqrt(3);

nf=length(f);

clf_12=zeros(nf,1);
clf_21=zeros(nf,1);

for i=1:nf

    omega=2*pi*f(i);

    B=(A*num/den)/omega;

    clf_12(i)=B*thick_1*cL_1/S_1;

    clf_21(i)=B*thick_2*cL_2/S_2;

end