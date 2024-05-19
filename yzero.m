


b=1;
h=0.25;
I=(1/12)*b*h^3;
E=1.0e+07;

P1=1
P2=1

L=48
L1=10.5
L2=37.5-L1
L3=L1

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x1=0;

a1=P1*(x1-L1)^3;

term=P1*L1*(L2-3*L1)-P2*L2*(L3+3*L1);

b2=term*(x1-L1);

y1=(a1+b2)/(6*E*I);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x2=(L2/2);


a2=((-P1*L1+P2*L3)/(6*L2))*(x2^3-L2^2*x2);
b2=((P1*L1)/2)*(x2^2-L2*x2);

y2=(a2+b2)/(E*I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x3=L3;

a3=P2*(-x3^3+3*L3*x3^2);
b3=L2*(2*P2*L3+P1*L1)*x3;

y3=(a3+b3)/(6*E*I);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


out1=sprintf('\n  y1=%8.4g   y2=%8.4g   y3=%8.4g \n',y1,y2,y3);
disp(out1);


num=1000;

L=L1+L2+L3;

dx=L/num;

y=zeros(num+1,1);
M=zeros(num+1,1);
V=zeros(num+1,1);

for i=1:(num+1)
    
    x=dx*(i-1);
    xx(i)=x;
    
    if(x<L1)
%        y(i)= P1*(x-L1)^3 - L2*(P2*L3+2*P1*L1)*(x-L1);
 
%        y(i)=P1*((x-L1)^3 + 3*L1*(x-L1)^2) - L2*(2*P1*L1+P2*L3)*(x-L1);

        
        a=-3*P1*L1^2 -2*P1*L1*L2 -P2*L2*L3;

        y(i)=P1*(x^3-L1^3) + a*(x-L1);
        

        M(i)= P1*x;
        V(i)= P1; 
    end  
    if(x>=L1 && x<(L1+L2))
        x=x-L1;
        y(i)= (-P1*L1+P2*L3)*(x^3-L2^2*x)/L2 + 3*P1*L1*(x^2-L2*x);
        M(i)= P1*L1 + ( -P1*L1 + P2*L3 )*x/L2;  
        V(i)= ( -P1*L1 + P2*L3  )/L2;   
    end
    if(x >=(L1+L2))
        x=x-(L1+L2);
        y(i)= P2*(-x^3+3*L3*x^2) + L2*(2*P2*L3+P1*L1)*x;
        M(i)= P2*(L3-x);  
        V(i)=-P2;       
    end    
    

    
end

y=y/(6*E*I);

xx=fix_size(xx);
y=fix_size(y);

figure(1);
plot(xx,y);
grid on;
xlabel('x (in)');
ylabel('y (in)');
title('Displacement');

figure(2);
plot(xx,M);
grid on;
xlabel('x (in)');
ylabel('M (in-lbf)');
title('Bending Moment');


figure(3);
plot(xx,V);
grid on;
xlabel('x (in)');
ylabel('V (lbf)');
title('Shear Force');












    