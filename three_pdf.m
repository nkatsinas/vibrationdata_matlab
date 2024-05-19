
clear n1;
clear n2;
clear eh;
clear g;
clear r;

N=50000;
sigma=1;
mu=0;

num=1000;

n1=zeros(num,1);
n2=zeros(num,1);
eh=zeros(num,1);
g=zeros(num,1);
r=zeros(num,1);

a=1/sqrt( 2*sigma^2*pi  );

for i=1:num

    n1(i)=(i-1)/(0.1*num)-5;
    x=n1(i);
    
    b=1/sqrt(pi*2*sigma^2);
    
    g(i)=b*exp( -(x-mu)^2 / (2*sigma^2) );
    
end

for i=1:num

    n2(i)=(i-1)/(0.1*num);
    x=n2(i);
    
    a=-x^2/2;
    
    eh(i)=x*N*exp(-N*exp(a))*exp(a);
    
    r(i)=(x/sigma^2)*exp( -x^2 / (2*sigma^2) );
    
end

figure(1);
plot(n1,g,'b',n2,r,'r',n2,eh,'k');
legend('Instantaneous','Absolute Local Peaks','Extreme Value');
grid on;
title('Probability Density Function, mean=0, std dev =1');
ylabel('Probability Density');
xlabel('Response Amplitude');
xtt=[-5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10];
set(gca,'xtick',xtt);
xlim([ -4,8  ]);



