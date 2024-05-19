A=[cumu S];


[b,m1,n1] = unique(A(:,1));

N=length(m1);
B=zeros(N,2);
for i=1:N
    B(i,:)=A(m1(i),:);
end

cumu=B(:,1);
S=B(:,2);

figure(1)
plot(cumu,S,A(:,1),A(:,2))