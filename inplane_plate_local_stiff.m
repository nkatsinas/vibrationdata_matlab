%
%  inplane_plate_local_stiff.m  ver 1.1  by Tom Irvine
%
function[klocal]=inplane_plate_local_stiff(a,b,thick,E,v)
%
q=(1-v)/2;


out1=sprintf(' a=%g  b=%g   ',a,b);
disp(out1);

klocal=zeros(8,8);


    
    a2=a^2;
    b2=b^2;
    
    a2q=a2*q;
    b2q=b2*q;
   
    area=a*b; 
    den=(3*a2*b2);
    
    k11=(16*(a2q+b2))/den;
    k12=(4*(v+q))/area;
    k13=(8*(a2q-2*b2))/den;
    k14=(4*(v-q))/area;
    k15=k11/2;
    k17=(8*(2*a2q-b2))/den;
    
    k22=(16*(b2q+a2))/den;
    k24=(8*(2*b2q-a2))/den;
    k26=k22/2;
    k28=(8*(b2q-2*a2))/den;

    klocal(1,1)=k11;
    klocal(1,2)=k12;
    klocal(1,3)=k13;
    klocal(1,4)=k14;
    klocal(1,5)=-k15;
    klocal(1,6)=-k12;
    klocal(1,7)=-k17;
    klocal(1,8)=-k14;
%
    klocal(2,1)=klocal(1,2);
    klocal(2,2)=k22;
    klocal(2,3)=-k14;
    klocal(2,4)=-k24;
    klocal(2,5)=-k12;
    klocal(2,6)=-k26;
    klocal(2,7)=k14;
    klocal(2,8)=k28;
%
    klocal(3,1)=klocal(1,3);
    klocal(3,2)=klocal(2,3);
    klocal(3,3)=k11;
    klocal(3,4)=-k12;
    klocal(3,5)=-k17;
    klocal(3,6)=k14;
    klocal(3,7)=-k15;
    klocal(3,8)=k12;
%
    klocal(4,1)=klocal(1,4);
    klocal(4,2)=klocal(2,4);
    klocal(4,3)=klocal(3,4);
    klocal(4,4)=k22;
    klocal(4,5)=-k14;
    klocal(4,6)=k28;
    klocal(4,7)=k12;
    klocal(4,8)=-k26;
%
    klocal(5,1)=klocal(1,5);
    klocal(5,2)=klocal(2,5);
    klocal(5,3)=klocal(3,5);
    klocal(5,4)=klocal(4,5);
    klocal(5,5)=k11;
    klocal(5,6)=k12;
    klocal(5,7)=k13;
    klocal(5,8)=k14;
%
    klocal(6,1)=klocal(1,6);
    klocal(6,2)=klocal(2,6);
    klocal(6,3)=klocal(3,6);
    klocal(6,4)=klocal(4,6);
    klocal(6,5)=klocal(5,6);
    klocal(6,6)=k22;
    klocal(6,7)=-k14;
    klocal(6,8)=-k24;
%
    klocal(7,1)=klocal(1,7);
    klocal(7,2)=klocal(2,7);
    klocal(7,3)=klocal(3,7);
    klocal(7,4)=klocal(4,7);
    klocal(7,5)=klocal(5,7);
    klocal(7,6)=klocal(6,7);
    klocal(7,7)=k11;
    klocal(7,8)=-k12;
%
    klocal(8,1)=klocal(1,8);
    klocal(8,2)=klocal(2,8);
    klocal(8,3)=klocal(3,8);
    klocal(8,4)=klocal(4,8);
    klocal(8,5)=klocal(5,8);
    klocal(8,6)=klocal(6,8);
    klocal(8,7)=klocal(7,8);
    klocal(8,8)=k22;

klocal=klocal*(E*thick*a*b/(1-v^2))/16;
