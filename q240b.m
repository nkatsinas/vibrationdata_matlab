   
clear M4_ratio1;
clear M4_ratio2;
clear M4_Q;

clear M5_ratio1;
clear M5_ratio2;
clear M5_Q;

clear M6_ratio1;
clear M6_ratio2;
clear M6_Q;

clear M7_ratio1;
clear M7_ratio2;
clear M7_Q;

clear M8_ratio1;
clear M8_ratio2;
clear M8_Q;

clear M9_ratio1;
clear M9_ratio2;
clear M9_Q;

clear P7_ratio1;
clear P7_ratio2;
clear P7_Q;

clear P8_ratio1;
clear P8_ratio2;
clear P8_Q;




ascent_tm4=M4_ns4_M(:,1);
ascent_tm5=M5_ns4_M(:,1);
ascent_tm6=M6_ns4_M(:,1);
ascent_tm7=M7_ns4_M(:,1);
ascent_tm8=M8_ns4_M(:,1);
ascent_tm9=M9_ns4_M(:,1);
ascent_tp7=P7_ns4_M(:,1);
ascent_tp8=P8_ns4_M(:,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


sz=size(M4_ns4_Q);
n=sz(1);

k=1;
for i=1:n
    M4_ratio1(k)=M4_ns4_Q(i,2)/(1+ 0.13*M4_ns4_M(i,2)^2);
    M4_ratio2(k)=M4_ns4_Q(i,2)/(1+      M4_ns4_M(i,2)^2); k=k+1;   
end
ns4_maxQ(1)=max(M4_ns4_Q(:,2));
ns4_maxR1(1)=max(M4_ratio1);
ns4_maxR2(1)=max(M4_ratio2);
 
 

M4_ratio1=[ascent_tm4 M4_ratio1' ];
M4_ratio2=[ascent_tm4 M4_ratio2' ];  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(M5_ns4_Q);
n=sz(1);

k=1;
for i=1:n
    M5_ratio1(k)=M5_ns4_Q(i,2)/(1+ 0.13*M5_ns4_M(i,2)^2);
    M5_ratio2(k)=M5_ns4_Q(i,2)/(1+      M5_ns4_M(i,2)^2); k=k+1;   
end

ns4_maxR1(2)=max(M5_ratio1);
ns4_maxR2(2)=max(M5_ratio2);
 

M5_ratio1=[ascent_tm5 M5_ratio1' ];
M5_ratio2=[ascent_tm5 M5_ratio2' ];  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(M6_ns4_Q);
n=sz(1);
 
k=1;
for i=1:n
    M6_ratio1(k)=M6_ns4_Q(i,2)/(1+ 0.13*M6_ns4_M(i,2)^2);
    M6_ratio2(k)=M6_ns4_Q(i,2)/(1+      M6_ns4_M(i,2)^2); k=k+1;   
end
ns4_maxQ(3)=max(M6_ns4_Q(:,2));
ns4_maxR1(3)=max(M6_ratio1);
ns4_maxR2(3)=max(M6_ratio2);
 
 

M6_ratio1=[ascent_tm6 M6_ratio1' ];
M6_ratio2=[ascent_tm6 M6_ratio2' ];  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sz=size(M7_ns4_Q);
n=sz(1);
 
k=1;
for i=1:n
    M7_ratio1(k)=M7_ns4_Q(i,2)/(1+ 0.13*M7_ns4_M(i,2)^2);
    M7_ratio2(k)=M7_ns4_Q(i,2)/(1+      M7_ns4_M(i,2)^2); k=k+1;   
end
ns4_maxQ(4)=max(M7_ns4_Q(:,2));
ns4_maxR1(4)=max(M7_ratio1);
ns4_maxR2(4)=max(M7_ratio2);
 
 

M7_ratio1=[ascent_tm7 M7_ratio1' ];
M7_ratio2=[ascent_tm7 M7_ratio2' ];  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sz=size(M8_ns4_Q);
n=sz(1);
 
k=1;
for i=1:n
    M8_ratio1(k)=M8_ns4_Q(i,2)/(1+ 0.13*M8_ns4_M(i,2)^2);
    M8_ratio2(k)=M8_ns4_Q(i,2)/(1+      M8_ns4_M(i,2)^2); k=k+1;   
end
ns4_maxQ(5)=max(M8_ns4_Q(:,2));
ns4_maxR1(5)=max(M8_ratio1);
ns4_maxR2(5)=max(M8_ratio2);
 
 

M8_ratio1=[ascent_tm8 M8_ratio1' ];
M8_ratio2=[ascent_tm8 M8_ratio2' ];  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sz=size(M9_ns4_Q);
n=sz(1);
 
k=1;
for i=1:n
    M9_ratio1(k)=M9_ns4_Q(i,2)/(1+ 0.13*M9_ns4_M(i,2)^2);
    M9_ratio2(k)=M9_ns4_Q(i,2)/(1+      M9_ns4_M(i,2)^2); k=k+1;   
end
ns4_maxQ(6)=max(M9_ns4_Q(:,2));
ns4_maxR1(6)=max(M9_ratio1);
ns4_maxR2(6)=max(M9_ratio2);
 
 

M9_ratio1=[ascent_tm9 M9_ratio1' ];
M9_ratio2=[ascent_tm9 M9_ratio2' ];  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sz=size(P7_ns4_Q);
n=sz(1);
 
k=1;
for i=1:n
    P7_ratio1(k)=P7_ns4_Q(i,2)/(1+ 0.13*P7_ns4_M(i,2)^2);
    P7_ratio2(k)=P7_ns4_Q(i,2)/(1+      P7_ns4_M(i,2)^2); k=k+1;   
end
ns4_maxQ(7)=max(P7_ns4_Q(:,2));
ns4_maxR1(7)=max(P7_ratio1);
ns4_maxR2(7)=max(P7_ratio2);
 
 

P7_ratio1=[ascent_tp7 P7_ratio1' ];
P7_ratio2=[ascent_tp7 P7_ratio2' ];  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sz=size(P8_ns4_Q);
n=sz(1);
 
k=1;
for i=1:n
    P8_ratio1(k)=P8_ns4_Q(i,2)/(1+ 0.13*P8_ns4_M(i,2)^2);
    P8_ratio2(k)=P8_ns4_Q(i,2)/(1+      P8_ns4_M(i,2)^2); k=k+1;   
end
ns4_maxQ(8)=max(P8_ns4_Q(:,2));
ns4_maxR1(8)=max(P8_ratio1);
ns4_maxR2(8)=max(P8_ratio2);
 
 

P8_ratio1=[ascent_tp8 P8_ratio1' ];
P8_ratio2=[ascent_tp8 P8_ratio2' ];  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

