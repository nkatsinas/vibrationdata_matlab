

[fn10,~,ModeShapes10,MST]=Generalized_Eigen(stiffr,mr,2);


kii=stiffr(1:6,1:6);
kbb=stiffr(7:10,7:10);
kib=stiffr(1:6,7:10);
kbi=kib';



mii=mr(1:6,1:6);
mbb=mr(7:10,7:10);
mib=mr(1:6,7:10);
mbi=mib';



m1=mr(1,1);
m2=mr(2,2);
m3=mr(3,3);
m4=mr(4,4);
m5=mr(5,5);
m6=mr(6,6);
m7=mr(7,7);
m8=mr(8,8);
m9=mr(9,9);
m10=mr(10,10);


psi_ib=-inv(kii)*kib;

Ibb=eye(4,4);

psi=[ psi_ib ; Ibb];


[fn6,~,ModeShapes6,MST]=Generalized_Eigen(k_fixed_free,m_fixed_free,2);

a=rectangular_pulse_generic*0.;

a(:,1)=rectangular_pulse_generic(:,1);
a(:,2)=-rectangular_pulse_generic(:,2)*32.172;

force_rect6=[a(:,1) m1*a(:,2) m2*a(:,2) m3*a(:,2) m4*a(:,2) m5*a(:,2) m6*a(:,2)];

force_rect10=[a(:,1) m1*a(:,2) m2*a(:,2) m3*a(:,2) m4*a(:,2) m5*a(:,2) m6*a(:,2) m7*a(:,2) m8*a(:,2) m9*a(:,2) m10*a(:,2)];


k6=kii;
m6=mii;