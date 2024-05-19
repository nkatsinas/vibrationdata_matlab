
clear power_trans;

n=length(comp_psd(:,1));

power_trans=zeros(n,2);

power_trans(:,1)=comp_psd(:,1);

for i=1:n
    
   [~,ii]=min(abs(comp_psd(i,1)-t1(:,1)));
   
    c=t1(ii,2);    
    
    power_trans(i,2)=c/comp_psd(i,2);
    
end


[~,ii]=min(abs(comp_psd(:,1)-20));
[~,jj]=min(abs(comp_psd(:,1)-2000));

power_trans=power_trans(ii:jj,:);

power_trans(1,1)=20;
power_trans(end,1)=2000;