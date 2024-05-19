clear a_total_measured;
clear a_total_measured_2a;     
clear aaa;


sz=size(accel_6);

nt=sz(1);


a_total_measured=zeros(6,nt);
aaa=zeros(6,nt);
aff=zeros(6,nt);
f2b=zeros(nt,6);

psi_ib

MM=( mii*psi_ib + mib );

for i=1:nt

%                               6 x 1       6 x 4    4 x 1                                   

    aaa(:,i)=psi_ib*accel_10(i,8:11)';

    a_total_measured(:,i)= accel_6(i,2:7)' + aaa(:,i);
    
    aff(:,i)= accel_10(i,2:7)' - aaa(:,i);
    
    f2b(i,:)=force_rect6(i,2:7)-(MM*accel_10(i,8:11)')';
    
end


ff2b=[ accel_10(:,1) f2b  ];

a_total_measured_2a=a_total_measured';    
aaa=aaa';
aff=aff';

accel_2a_1=[accel_10(:,1) a_total_measured_2a(:,1)];
accel_2a_2=[accel_10(:,1) a_total_measured_2a(:,2)];
accel_2a_3=[accel_10(:,1) a_total_measured_2a(:,3)];
accel_2a_4=[accel_10(:,1) a_total_measured_2a(:,4)];
accel_2a_5=[accel_10(:,1) a_total_measured_2a(:,5)];
accel_2a_6=[accel_10(:,1) a_total_measured_2a(:,6)];

aaa6=[accel_10(:,1) aaa(:,6)];

accel_ff_1=[accel_10(:,1) aff(:,1)];
accel_ff_2=[accel_10(:,1) aff(:,2)];
accel_ff_3=[accel_10(:,1) aff(:,3)];
accel_ff_4=[accel_10(:,1) aff(:,4)];
accel_ff_5=[accel_10(:,1) aff(:,5)];
accel_ff_6=[accel_10(:,1) aff(:,6)];


t=accel_10(:,1);

a2b_1=[t  a2b(:,2)];
a2b_2=[t  a2b(:,3)];
a2b_3=[t  a2b(:,4)];
a2b_4=[t  a2b(:,5)];
a2b_5=[t  a2b(:,6)];
a2b_6=[t  a2b(:,7)];





