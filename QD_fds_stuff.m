% sine_150_fds=[sine_180_fds(:,1) sine_180_fds(:,2)*15/18];
% sine_120_fds=[sine_180_fds(:,1) sine_180_fds(:,2)*12/18]; 


s=1;
df=1;



f=sine_150_fds(:,1);
a=sine_150_fds(:,2);

[f1,a1] = interpolate_log(f,a,s,df);



f=sine_361Hz_fds(:,1);
a=sine_361Hz_fds(:,2);

[f2,a2] = interpolate_log(f,a,s,df);



length(f1)
length(f2)

Cres12_sine_total_fds=[f1 (a1+a2)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


f=sine_120_fds(:,1);
a=sine_120_fds(:,2);

[f1,a1] = interpolate_log(f,a,s,df);



f=sine_1105Hz_fds(:,1);
a=sine_1105Hz_fds(:,2);

[f2,a2] = interpolate_log(f,a,s,df);


f=sine_1367Hz_fds(:,1);
a=sine_1367Hz_fds(:,2);

[f3,a3] = interpolate_log(f,a,s,df);




length(f1)
length(f2)

ti16_sine_total_fds=[f1 (a1+a2+a3)];
