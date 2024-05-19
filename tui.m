
num=4000;

s=zeros(num,1);
t=s;



for i=1:num
    t(i)=i;
    s(i)=mean(100.*rand(1e+8,1));
    fprintf(' %7.4f \n',s(i));
    figure(1);
    plot(t(1:i),s(1:i));
    grid on;
    ylim([49.9 50.1]);
    xlim([1 num]);
end    