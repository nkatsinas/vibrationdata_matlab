aaa(:,7)=[];
aaa(:,6)=[];
aaa(:,5)=[];
aaa(:,4)=[];
aaa(:,2)=[];

f=aaa(:,1);

cc=[f aaa(:,1)];

sz=size(aaa);

num=sz(1);

clear f;
clear c;


f=aaa_oop(:,1);
c=aaa_oop(:,2);

size(aaa_oop)
size(f)
size(c)

oop_tch1=zeros(num,2);
oop_tch2=zeros(num,2);
oop_tch3=zeros(num,2);
oop_tch4=zeros(num,2);
oop_tch5=zeros(num,2);
oop_tch6=zeros(num,2);
oop_tch7=zeros(num,2);
oop_tch8=zeros(num,2);
oop_tch9=zeros(num,2);
oop_tch10=zeros(num,2);
oop_tch11=zeros(num,2);
oop_tch12=zeros(num,2);


for i=1:num
    try
        oop_tch12(i,:)=[f(i) aaa_oop(i,14)/c(i)];
        oop_tch11(i,:)=[f(i) aaa_oop(i,13)/c(i)];
        oop_tch10(i,:)=[f(i) aaa_oop(i,12)/c(i)];
        oop_tch9(i,:)=[f(i) aaa_oop(i,11)/c(i)];   
    catch
    end
    
    oop_tch8(i,:)=[f(i) aaa_oop(i,10)/c(i)];
    oop_tch7(i,:)=[f(i) aaa_oop(i,9)/c(i)];
    oop_tch6(i,:)=[f(i) aaa_oop(i,8)/c(i)];
    oop_tch5(i,:)=[f(i) aaa_oop(i,7)/c(i)];
    oop_tch4(i,:)=[f(i) aaa_oop(i,6)/c(i)];
    oop_tch3(i,:)=[f(i) aaa_oop(i,5)/c(i)];
    oop_tch2(i,:)=[f(i) aaa_oop(i,4)/c(i)];
    oop_tch1(i,:)=[f(i) aaa_oop(i,3)/c(i)];     
end    
