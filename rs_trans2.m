
clear power_trans;

n=length(t1(:,1));

power_trans=zeros(n,2);

power_trans(:,1)=t1(:,1);

for i=1:n
    
    power_trans(i,2)=t1(i,2)/control(i,2);
    
end


[~,ii]=min(abs(power_trans(:,1)-20));
[~,jj]=min(abs(power_trans(:,1)-2000));

power_trans=power_trans(ii:jj,:);

power_trans(1,1)=20;
power_trans(end,1)=2000;