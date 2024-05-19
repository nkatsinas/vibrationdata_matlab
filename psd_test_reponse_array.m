w=wb;

w(:,7)=[];
w(:,6)=[];
w(:,5)=[];
w(:,4)=[];
w(:,2)=[];

psd_control=[w(:,1) w(:,2)];

psd1=[ w(:,1) w(:,3) ];
psd2=[ w(:,1) w(:,4) ];
psd3=[ w(:,1) w(:,5) ];
psd4=[ w(:,1) w(:,6) ];
psd5=[ w(:,1) w(:,7) ];
psd6=[ w(:,1) w(:,8) ];
psd7=[ w(:,1) w(:,9) ];
psd8=[ w(:,1) w(:,10) ];
psd9=[ w(:,1) w(:,11) ];
psd10=[ w(:,1) w(:,12) ];
psd11=[ w(:,1) w(:,13) ];
psd12=[ w(:,1) w(:,14) ];

sz=size(w);

n=sz(1);

f=w(:,1);

for i=1:n
    ttrans1(i,:)=[f(i) psd1(i,2)/psd_control(i,2) ];
    ttrans2(i,:)=[f(i) psd2(i,2)/psd_control(i,2) ];    
    ttrans3(i,:)=[f(i) psd3(i,2)/psd_control(i,2) ];
    ttrans4(i,:)=[f(i) psd4(i,2)/psd_control(i,2) ];
    ttrans5(i,:)=[f(i) psd5(i,2)/psd_control(i,2) ];    
    ttrans6(i,:)=[f(i) psd6(i,2)/psd_control(i,2) ];    
    ttrans7(i,:)=[f(i) psd7(i,2)/psd_control(i,2) ];
    ttrans8(i,:)=[f(i) psd8(i,2)/psd_control(i,2) ];    
    ttrans9(i,:)=[f(i) psd9(i,2)/psd_control(i,2) ];    
    ttrans10(i,:)=[f(i) psd10(i,2)/psd_control(i,2) ];
    ttrans11(i,:)=[f(i) psd11(i,2)/psd_control(i,2) ];    
    ttrans12(i,:)=[f(i) psd12(i,2)/psd_control(i,2) ];    
end
