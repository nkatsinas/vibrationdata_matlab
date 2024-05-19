
x=a300(:,2);

d4=zeros(300,1);
d8=zeros(300,1);

progressbar;
for i=1:300
    progressbar(i/300);
    j=round(20000*i/300);
    c=rainflow(x(1:j));
    cycles=c(:,1);
    amp=c(:,2)/2;
    d4(i)=sum( cycles.*amp.^4 );
    d8(i)=sum( cycles.*amp.^8 );
end    
progressbar(1);



figure(9);
plot(d4);
grid on;

figure(10);
plot(d8);
grid on;
