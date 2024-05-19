function[q,C,B]=cpf_C_coefficients(ba,bb)
%
    C=zeros(8,8);
%
    C(1,2)=1;
    C(1,4)=1;
    C(2,1)=1;
    C(2,3)=1;
%
    C(3,1)=sinh(ba);
    C(3,2)=cosh(ba);
    C(3,3)=sin(ba);
    C(3,4)=cos(ba);
%    
    C(4,1)=cosh(ba);
    C(4,2)=sinh(ba);
    C(4,3)=cos(ba);
    C(4,4)=-sin(ba);
    C(4,5)=-1;
    C(4,7)=-1;
%
    C(5,1)=sinh(ba);
    C(5,2)=cosh(ba);
    C(5,3)=-sin(ba);
    C(5,4)=-cos(ba);
    C(5,6)=-1;
    C(5,8)=1;
%
    C(6,6)=1;
    C(6,8)=1;
%
    C(7,5)=sinh(bb);
    C(7,6)=cosh(bb);
    C(7,7)=-sin(bb);
    C(7,8)=-cos(bb);
%
    C(8,5)=cosh(bb);
    C(8,6)=sinh(bb);
    C(8,7)=-cos(bb);
    C(8,8)=sin(bb);
%
    C(1,:)=0;
    C(1,1)=1;
%
    B=zeros(8,1);
    B(1)=1;
%
    q=C\B;