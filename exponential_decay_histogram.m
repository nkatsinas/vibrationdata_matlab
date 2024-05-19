clear x
clear pdf
clear aband


x2=1;

a=(1/x2)*log(0.10);   %  10% at end

dx=0.001;

nt=floor(x2/dx);

x=zeros((nt+1),1);
pdf=zeros((nt+1),1);

for i=1:(nt+1)
   x(i)=(i-1)*dx; 
   pdf(i)=a*exp(a*x(i));
end    

area=sum(pdf)*dx;

pdf=pdf/area;

figure(1)
plot(x,pdf)
grid on;



aband=zeros(nt,2);

cpdf=cumsum(pdf);

for i=1:nt
    aband(i,2)=(x(i)+x(i+1))*0.5;
    aband(i,1)=(cpdf(i)+cpdf(i+1))*dx/2;
end

figure(8)
plot(x,cpdf)
grid on;

N=10000;

clear xx
clear yy

xx=zeros(N,1);
yy=zeros(N,1);

for i=1:N
   q=rand();
   tmp = abs(aband(:,1)-q);
   [c, idx] = min(tmp); %index of closest value
   ab = aband(idx,2); %closest value   
   xx(i)=i;
   yy(i)=ab;
end

cc=[xx yy];
figure(9);
plot(xx,yy);
grid on;











