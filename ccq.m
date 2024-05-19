
k=beam_stiffness;

f=aff;

f(1)=0;


n1=21;
n2=79;


n1=3*n1-1;
n2=3*n2-1;


f(n1)=[];
f(n2)=[];

k(n1,:)=[];
k(:,n1)=[];

k(n2,:)=[];
k(:,n2)=[];


x=pinv(k)*f

x(1:10)