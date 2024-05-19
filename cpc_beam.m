close all
clear C;
clear x;
clear y;
clear length
%
a=0.5;
b=(1-a);
%
x=linspace(0,12,2001);
%
for(i=1:length(x))
%
    ba=x(i);
    bb=ba;
%
    C=zeros(8,8);
%    
    C(1,2)=1;
    C(1,4)=1;
    C(2,1)=1;
    C(2,3)=1;
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
    C(7,5)=cos(ba);
    C(7,6)=
    C(7,7)=
    C(7,8)=
%
    C(8,5)=
    C(8,6)=
    C(8,7)=
    C(8,8)=
%
    y(i)=det(C);
%
end
%
clear roots;
%
k=1;
for(i=2:length(x))
    if(y(i-1)*y(i)<=0)
        roots(k)=x(i);
        k=k+1;
    end
end
%
roots'
%
figure(1);
plot(x,y);
axis([0,max(x),-2,2]);
grid on;