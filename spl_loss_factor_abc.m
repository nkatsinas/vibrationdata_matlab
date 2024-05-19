

n=length(NG_PLF_spl(:,1));

spl_lf=zeros(n,3);

for i=1:n
    [~,idx]=min(abs(loss_factor(:,1)-NG_PLF_spl(i,1)));
    spl_lf(i,:)=[NG_PLF_spl(i,:) loss_factor(idx,2)];
end

