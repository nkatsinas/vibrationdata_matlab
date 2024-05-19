
clear x;
clear y;
clear crest;
clear alpha;


arg=10000;


n=1000;

x=zeros(n,1);
y=zeros(n,1);
yd=zeros(n,1);
crest=zeros(n,1);
alpha=zeros(n,1);

dx=0.01;

for i=1:n
    
   crest(i)=(i-1)*dx;
   c=crest(i);
   c2=c^2;
   
   lna=log(arg);
   
   A= ( sqrt(2*lna)  +  0.5772/sqrt(2*lna) );
   
   term=1-exp(-c2*lna/A^2);
   
   alpha(i)=1-term^arg;
   
   y(i)=alpha(i);    
   
   AA=2*c*arg*lna/A^2;
   BB=( 1-exp(-c2*lna/A^2) )^(arg-1);
   CC=exp(-c2*lna/A^2);
   
   yd(i)=AA*BB*CC;
    
end

figure(100);
plot(crest,y);
grid on;

figure(101);
plot(crest,yd);
grid on;

sum(yd)*dx