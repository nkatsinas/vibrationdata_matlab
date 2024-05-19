
disp(' ');
disp('************************');
disp(' ');

a_1=3;
a_2=3;

cp=626.3 ;
fc=1000;


% dB1=141.3;
dB1=138.4;
Uc=255.3;

mpa=10.1225;
Ap1=66.7592;
L1=2.5298;


fc


[power1,power_dB1,~,~]=power_from_TBL_spl_dB(fc,dB1,mpa,Ap1,L1,Uc,cp,a_1,a_2)



% dB1=134.4;
dB1=131.7;
Uc=592.5;

[power1,power_dB1,~,~]=power_from_TBL_spl_dB(fc,dB1,mpa,Ap1,L1,Uc,cp,a_1,a_2)