
t=M5_AC_6323_th_bpf(:,1);
dt=(t(end)-t(1))/(length(t)-1);

t4=437.5;
t3=350;
t2=159;
t1=-5;
[~,i4]=min(abs(t-t4));
[~,i3]=min(abs(t-t3));
[~,i2]=min(abs(t-t2));
[~,i1]=min(abs(t-t1));

M5_AC_6323_th_bpf_abs=[M5_AC_6323_th_bpf(i1:i2,:); M5_AC_6323_th_bpf(i3:i4,:)];
M5_AC_6324_th_bpf_abs=[M5_AC_6324_th_bpf(i1:i2,:); M5_AC_6324_th_bpf(i3:i4,:)];  

np=length(M5_AC_6323_th_bpf_abs(:,1));
tt=linspace(0,(np-1)*dt,np);

M5_AC_6323_th_bpf_abs(:,1)=tt;
M5_AC_6324_th_bpf_abs(:,1)=tt;

%%%%%%%%

clear M6_AC_6325_th_bpf_abs;
clear M6_AC_6326_th_bpf_abs;


t=M6_AC_6325_th_bpf(:,1);
dt=(t(end)-t(1))/(length(t)-1);

t4=455;
t3=365;
t2=213;
t1=-5;

[~,i4]=min(abs(t-t4));
[~,i3]=min(abs(t-t3));
[~,i2]=min(abs(t-t2));
[~,i1]=min(abs(t-t1));


M6_AC_6325_th_bpf_abs=[M6_AC_6325_th_bpf(i1:i2,:); M6_AC_6325_th_bpf(i3:i4,:)]; 
M6_AC_6326_th_bpf_abs=[M6_AC_6326_th_bpf(i1:i2,:); M6_AC_6326_th_bpf(i3:i4,:)]; 

np=length(M6_AC_6325_th_bpf_abs(:,1));
tt=linspace(0,(np-1)*dt,np);

M6_AC_6325_th_bpf_abs(:,1)=tt;
M6_AC_6326_th_bpf_abs(:,1)=tt;



