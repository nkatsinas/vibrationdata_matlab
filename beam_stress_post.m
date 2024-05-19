clear a;
clear stress1;
clear stress2;

a=camp.data';

a(1)=[];

L=length(a);
f1=1;
df=0.9995;

H=floor(L/2);

stress1=zeros(H,2);
stress2=zeros(H,2);

for i=1:H
   f=f1+(i-1)*df;
   s1=a(2*i-1);
   s2=a(2*i);
   stress1(i,:)=[f s1];
   stress2(i,:)=[f s2];
end