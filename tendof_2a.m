clear a_total_measured;
clear a_total_measured_2a;     
clear aaa;


sz=size(accel_6);

nt=sz(1);


a_total_measured=zeros(6,nt);
aaa=zeros(6,nt);

for i=1:nt

%                               6 x 1       6 x 4    4 x 1                                   

    aaa(:,i)=psi_ib*accel_10(i,8:11)';

    a_total_measured(:,i)= accel_6(i,2:7)' + aaa(:,i);
    
end

a_total_measured_2a=a_total_measured';    
aaa=aaa';


accel_2a_1=[accel_10(:,1) a_total_measured_2a(:,1)];
accel_2a_2=[accel_10(:,1) a_total_measured_2a(:,2)];
accel_2a_3=[accel_10(:,1) a_total_measured_2a(:,3)];
accel_2a_4=[accel_10(:,1) a_total_measured_2a(:,4)];
accel_2a_5=[accel_10(:,1) a_total_measured_2a(:,5)];
accel_2a_6=[accel_10(:,1) a_total_measured_2a(:,6)];

aaa6=[accel_10(:,1) aaa(:,6)];
