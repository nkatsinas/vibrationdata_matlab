


clear M4_ds_ratio1;
clear M4_ds_ratio2;
clear M5_ds_ratio1;
clear M5_ds_ratio2;
clear M6_ds_ratio1;
clear M6_ds_ratio2;
clear M7_ds_ratio1;
clear M7_ds_ratio2;
clear M8_ds_ratio1;
clear M8_ds_ratio2;
clear M9_ds_ratio1;
clear M9_ds_ratio2;
clear P7_ds_ratio1;
clear P7_ds_ratio2;
clear P8_ds_ratio1;
clear P8_ds_ratio2;

tm4=M4_pm4_Q(:,1);
tm5=M5_pm4_Q(:,1);
tm6=M6_pm4_Q(:,1);
tm7=M7_pm4_Q(:,1);
tm8=M8_pm4_Q(:,1);
tm9=M9_pm4_Q(:,1);
tp7=P7_pm4_Q(:,1);
tp8=P8_pm4_Q(:,1);

M4=[358	403];
M5=[351	396];	
M6=[362	407];	
M7=[348	393];	
M8=[359	404];	
M9=[358	403];	
P7=[360	405];	
P8=[359	404];	

M4(:,2)=M4(:,2)+5;
M5(:,2)=M5(:,2)+5;
M6(:,2)=M6(:,2)+5;
M7(:,2)=M7(:,2)+5;
M8(:,2)=M8(:,2)+5;
M9(:,2)=M9(:,2)+5;
P7(:,2)=P7(:,2)+5;
P8(:,2)=P8(:,2)+5;

[~,im4]=min(abs(M4(1)-tm4)); [~,jm4]=min(abs(M4(2)-tm4));
[~,im5]=min(abs(M5(1)-tm5)); [~,jm5]=min(abs(M5(2)-tm5));
[~,im6]=min(abs(M6(1)-tm6)); [~,jm6]=min(abs(M6(2)-tm6));
[~,im7]=min(abs(M7(1)-tm7)); [~,jm7]=min(abs(M7(2)-tm7));
[~,im8]=min(abs(M8(1)-tm8)); [~,jm8]=min(abs(M8(2)-tm8));
[~,im9]=min(abs(M9(1)-tm9)); [~,jm9]=min(abs(M9(2)-tm9));
[~,ip7]=min(abs(P7(1)-tp7)); [~,jp7]=min(abs(P7(2)-tp7));
[~,ip8]=min(abs(P8(1)-tp8)); [~,jp8]=min(abs(P8(2)-tp8));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k=1;
for i=im4:jm4
    M4_ds_ratio1(k)=M4_pm4_Q(i,2)/(1+ 0.13*M4_pm4_M(i,2)^2);
    M4_ds_ratio2(k)=M4_pm4_Q(i,2)/(1+      M4_pm4_M(i,2)^2); k=k+1;   
end
maxR1(1)=max(M4_ds_ratio1);
maxR2(1)=max(M4_ds_ratio2);
    
k=1;
for i=im5:jm5    
    M5_ds_ratio1(k)=M5_pm4_Q(i,2)/(1+ 0.13*M5_pm4_M(i,2)^2);
    M5_ds_ratio2(k)=M5_pm4_Q(i,2)/(1+      M5_pm4_M(i,2)^2); k=k+1;   
end
maxR1(2)=max(M5_ds_ratio1);
maxR2(2)=max(M5_ds_ratio2);

k=1;
for i=im6:jm6
    M6_ds_ratio1(k)=M6_pm4_Q(i,2)/(1+ 0.13*M6_pm4_M(i,2)^2);
    M6_ds_ratio2(k)=M6_pm4_Q(i,2)/(1+      M6_pm4_M(i,2)^2); k=k+1;   
end
maxR1(3)=max(M6_ds_ratio1);
maxR2(3)=max(M6_ds_ratio2);

k=1;
for i=im7:jm7
    M7_ds_ratio1(k)=M7_pm4_Q(i,2)/(1+ 0.13*M7_pm4_M(i,2)^2);
    M7_ds_ratio2(k)=M7_pm4_Q(i,2)/(1+      M7_pm4_M(i,2)^2); k=k+1;   
end
maxR1(4)=max(M7_ds_ratio1);
maxR2(4)=max(M7_ds_ratio2);

k=1;
for i=im8:jm8
    M8_ds_ratio1(k)=M8_pm4_Q(i,2)/(1+ 0.13*M8_pm4_M(i,2)^2);
    M8_ds_ratio2(k)=M8_pm4_Q(i,2)/(1+      M8_pm4_M(i,2)^2); k=k+1;   
end
maxR1(5)=max(M8_ds_ratio1);
maxR2(5)=max(M8_ds_ratio2);
    
k=1;
for i=im9:jm9
    M9_ds_ratio1(k)=M9_pm4_Q(i,2)/(1+ 0.13*M9_pm4_M(i,2)^2);
    M9_ds_ratio2(k)=M9_pm4_Q(i,2)/(1+      M9_pm4_M(i,2)^2); k=k+1;   
end
maxR1(6)=max(M9_ds_ratio1);
maxR2(6)=max(M9_ds_ratio2);

k=1;
for i=ip7:jp7
    P7_ds_ratio1(k)=P7_pm4_Q(i,2)/(1+ 0.13*P7_pm4_M(i,2)^2);
    P7_ds_ratio2(k)=P7_pm4_Q(i,2)/(1+      P7_pm4_M(i,2)^2); k=k+1;   
end
maxR1(7)=max(P7_ds_ratio1);
maxR2(7)=max(P7_ds_ratio2);

k=1;
for i=ip8:jp8
    P8_ds_ratio1(k)=P8_pm4_Q(i,2)/(1+ 0.13*P8_pm4_M(i,2)^2);
    P8_ds_ratio2(k)=P8_pm4_Q(i,2)/(1+      P8_pm4_M(i,2)^2); k=k+1;   
end
maxR1(8)=max(P8_ds_ratio1);
maxR2(8)=max(P8_ds_ratio2);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

flight{1}='M4';  maxQ(1)=max(M4_pm4_Q(im4:jm4,2));
flight{2}='M5';  maxQ(2)=max(M5_pm4_Q(im5:jm5,2));  
flight{3}='M6';  maxQ(3)=max(M6_pm4_Q(im6:jm6,2));
flight{4}='M7';  maxQ(4)=max(M7_pm4_Q(im7:jm7,2));
flight{5}='M8';  maxQ(5)=max(M8_pm4_Q(im8:jm8,2));
flight{6}='M9';  maxQ(6)=max(M9_pm4_Q(im9:jm9,2));
flight{7}='P7';  maxQ(7)=max(P7_pm4_Q(ip7:jp7,2));
flight{8}='P8';  maxQ(8)=max(P8_pm4_Q(ip8:jp8,2));


for i=1:8
    out1=sprintf(' %s \t %8.4g  \t %8.3g  \t %8.3g ',flight{i},maxQ(i),maxR1(i),maxR2(i));
    disp(out1);
end


out1=sprintf('mean \t %8.4g  \t %8.3g  \t %8.3g  ',mean(maxQ),mean(maxR1),mean(maxR2));
disp(out1);

%%

M4_Q=[tm4(im4:jm4) M4_pm4_Q(im4:jm4,2)];
M4_ds_ratio1=[tm4(im4:jm4) M4_ds_ratio1' ];
M4_ds_ratio2=[tm4(im4:jm4) M4_ds_ratio2' ];   

M5_Q=[tm5(im5:jm5) M5_pm4_Q(im5:jm5,2)];
M5_ds_ratio1=[tm5(im5:jm5) M5_ds_ratio1' ];
M5_ds_ratio2=[tm5(im5:jm5) M5_ds_ratio2' ];  

M6_Q=[tm6(im6:jm6) M6_pm4_Q(im6:jm6,2)];
M6_ds_ratio1=[tm6(im6:jm6) M6_ds_ratio1' ];
M6_ds_ratio2=[tm6(im6:jm6) M6_ds_ratio2' ];  

M7_Q=[tm7(im7:jm7) M7_pm4_Q(im7:jm7,2)];
M7_ds_ratio1=[tm7(im7:jm7) M7_ds_ratio1' ];
M7_ds_ratio2=[tm7(im7:jm7) M7_ds_ratio2' ];  

M8_Q=[tm8(im8:jm8) M8_pm4_Q(im8:jm8,2)];
M8_ds_ratio1=[tm8(im8:jm8) M8_ds_ratio1' ];
M8_ds_ratio2=[tm8(im8:jm8) M8_ds_ratio2' ];  

M9_Q=[tm9(im9:jm9) M9_pm4_Q(im9:jm9,2)];
M9_ds_ratio1=[tm9(im9:jm9) M9_ds_ratio1' ];
M9_ds_ratio2=[tm9(im9:jm9) M9_ds_ratio2' ];  

P7_Q=[tp7(ip7:jp7) P7_pm4_Q(ip7:jp7,2)];
P7_ds_ratio1=[tm7(ip7:jp7) P7_ds_ratio1' ];
P7_ds_ratio2=[tm7(ip7:jp7) P7_ds_ratio2' ];  

P8_Q=[tp8(ip8:jp8) P8_pm4_Q(ip8:jp8,2)];
P8_ds_ratio1=[tp8(ip8:jp8) P8_ds_ratio1' ];
P8_ds_ratio2=[tp8(ip8:jp8) P8_ds_ratio2' ];  

%%

sz=size(NG_trajectory_Mach);

num=sz(1);

clear NG_Q;
clear NG_R1;
clear NG_R2;

k=1;
for i=2000:num
   
    if( NG_trajectory_Mach(i,2) > 1)
        NG_Q(k)=NG_trajectory_Q(i,2);
        NG_R1(k)=NG_trajectory_Q(i,2)/( 1 + 0.13*NG_trajectory_Mach(i,2)^2  );
        NG_R2(k)=NG_trajectory_Q(i,2)/( 1 +      NG_trajectory_Mach(i,2)^2  );
        k=k+1;
    end
end


out1=sprintf('\n\n NG \t %8.4g  \t %8.4g  \t %8.3g  ',max(NG_Q),max(NG_R1),max(NG_R2));
disp(out1);


%%%%%%%%%%%

[~,j]=min(abs(M4_pm4_M(:,1)-300));
[~,i]=min(abs(M4_pm4_M(j:end,2)-1));
i=i+j;
out1=sprintf('M4  %8.4g %8.4g',M4_pm4_M(i,1),M4_pm4_M(i,2));
disp(out1);


[~,j]=min(abs(M5_pm4_M(:,1)-300));
[~,i]=min(abs(M5_pm4_M(j:end,2)-1));
i=i+j;
out1=sprintf('M5  %8.4g %8.4g',M5_pm4_M(i,1),M5_pm4_M(i,2));
disp(out1);


[~,j]=min(abs(M6_pm4_M(:,1)-300));
[~,i]=min(abs(M6_pm4_M(j:end,2)-1));
i=i+j;
out1=sprintf('M6  %8.4g %8.4g',M6_pm4_M(i,1),M6_pm4_M(i,2));
disp(out1);


[~,j]=min(abs(M7_pm4_M(:,1)-300));
[~,i]=min(abs(M7_pm4_M(j:end,2)-1));
i=i+j;
out1=sprintf('M7  %8.4g %8.4g',M7_pm4_M(i,1),M7_pm4_M(i,2));
disp(out1);


[~,j]=min(abs(M8_pm4_M(:,1)-300));
[~,i]=min(abs(M8_pm4_M(j:end,2)-1));
i=i+j;
out1=sprintf('M8  %8.4g %8.4g',M8_pm4_M(i,1),M8_pm4_M(i,2));
disp(out1);





















