
     
THM=input(' Enter the array name ');

sz=size(THM);
num=sz(1);

BR=zeros(num,1);

lambda=zeros(2,1);

  t=THM(:,1);
 sx=THM(:,2);
 sy=THM(:,3);
txy=THM(:,4);

for j=1:num
    
    A=[ sx(j)  txy(j)    ;  txy(j)  sy(j)   ];

    [evector,D] = eig(A);
        
    for i=1:2
        lambda(i)=D(i,i);
    end
    
    alambda=abs(lambda);
    
    BR(j)=min(alambda)/max(alambda);    
    
    if( lambda(1)*lambda(2) < 0 )
        
        BR(j)=-BR(j);
        
    end    
    
end

figure(723);
plot(t,BR);
grid on;
xlabel('Time (sec)');

BRT=[ t BR ];