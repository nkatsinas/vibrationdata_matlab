function[qq]=SVD_filter_trial(THM,N)

tic

q=THM(:,2);
num=length(q);


if(num>N)
    THM=THM(1:N,:);
    q=THM(:,2);   
end


H = hankel(q);
[u,s,v] = svd(H);


num=length(q);

th=0.044*s(1,1);

ijk=0;

for i=2:num
    if(s(i,i)<th)
        s(i,i)=0;
        ijk=ijk+1;
    end
end

fprintf(' SVD included %d \n',num-ijk);

B=u*s*v';

qq=zeros(num,1);

qq(i)=B(1,i);

for i=2:num
    k=0;
    for j=1:i-1
        qq(i)=qq(i)+B(j,i-j);
        k=k+1;
    end
    qq(i)=qq(i)/k;
end

figure(98)
plot(THM(:,1),q)
figure(99)
plot(THM(:,1),qq)

qq=[THM(:,1),qq];

toc