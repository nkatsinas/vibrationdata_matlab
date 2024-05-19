
disp(' ');
disp('************************');
disp(' ');

a_1=3;
a_2=3;

cp=626.3 ;
fc=1000;



dB1=138;
Uc=0.5*cp;

mpa=10.1225;
Ap1=66.7592;
L1=2.5298;





[power1a,power_dB1a,~,~]=power_from_TBL_spl_dB(fc,dB1,mpa,Ap1,L1,Uc,cp,a_1,a_2)



dB1=132;
Uc=1.5*cp;

[power1b,power_dB1b,~,~]=power_from_TBL_spl_dB(fc,dB1,mpa,Ap1,L1,Uc,cp,a_1,a_2)


power_dB1b-power_dB1a