
clear aff;

ne=100;

nn=ne+1;

ndof=nn*3;

aff=zeros(ndof,1);


L=3740;

dx=L/ne;


for i=1:nn
   
    ijk=3*i-1;
    
    aff(ijk)=dx*((i-1)/nn)*50;
    
     
    out1=sprintf(' %d  %8.4g ',i,aff(ijk));
    disp(out1);
    
end

aff(1)=4500000;
aff(2)=200000;

aff;

bff=aff;
bff(1)=5000000;
bff(2)=0;

bff;


cff=bff*0;
cff(1)=5000000;
cff(2)=200000;