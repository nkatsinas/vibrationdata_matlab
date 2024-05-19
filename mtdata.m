
fprintf(' %s \n',label1);
fprintf(' %s  \n',label2);
fprintf(' %s  \n',label3);
fprintf(' %s  \n',label4);
fprintf(' %s  \n',label5);
fprintf(' %s  \n',label6);
fprintf(' %s  \n',label7);
fprintf(' %s  \n',label8);
fprintf(' %s  \n',label9);
fprintf(' %s  \n',label10);
fprintf(' %s  \n',label11);
fprintf(' %s  \n',label12);
fprintf(' %s  \n',label13);
fprintf(' %s  \n',label14);
fprintf(' %s  \n',label15);
fprintf(' %s  \n',label16);

ch1=[freq channel(:,1)];
ch2=[freq channel(:,2)];
ch3=[freq channel(:,3)];
ch4=[freq channel(:,4)];
ch5=[freq channel(:,5)];
ch6=[freq channel(:,6)];
ch7=[freq channel(:,7)];
ch8=[freq channel(:,8)];
ch9=[freq channel(:,9)];
ch10=[freq channel(:,10)];
ch11=[freq channel(:,11)];
ch12=[freq channel(:,12)];
ch13=[freq channel(:,13)];
ch14=[freq channel(:,14)];
ch15=[freq channel(:,15)];
ch16=[freq channel(:,16)];


sz=size(channel);

num=sz(1);

tr7=zeros(num,2);
tr8=zeros(num,2);
tr12=zeros(num,2);
tr13=zeros(num,2);
tr14=zeros(num,2);
tr15=zeros(num,2);

for i=1:num
    con=mean([ channel(i,3) channel(i,6) ]);
    tr7(i,:)=[freq(i) channel(i,7)/con];
    tr8(i,:)=[freq(i) channel(i,7)/con];    
    tr12(i,:)=[freq(i) channel(i,12)/con];
    tr13(i,:)=[freq(i) channel(i,13)/con];
    tr14(i,:)=[freq(i) channel(i,14)/con];
    tr15(i,:)=[freq(i) channel(i,15)/con];    
end














