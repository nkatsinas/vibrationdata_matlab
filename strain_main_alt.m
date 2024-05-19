disp(' ');
disp(' * * * * *');
disp(' ');
disp('   P      M   ');




[M7_Mr1,M7_Pr1,M7_Mmax1,M7_Pmax1,M7_Mr2,M7_Pr2,M7_Mmax2,M7_Pmax2]=strain_transformation_alt(M7_6353_lpff,M7_6355_lpff);
[M8_Mr1,M8_Pr1,M8_Mmax1,M8_Pmax1,M8_Mr2,M8_Pr2,M8_Mmax2,M8_Pmax2]=strain_transformation_alt(M8_6353_lpff,M8_6355_lpff);
[M9_Mr1,M9_Pr1,M9_Mmax1,M9_Pmax1,M9_Mr2,M9_Pr2,M9_Mmax2,M9_Pmax2]=strain_transformation_alt(M9_6353_lpff,M9_6355_lpff);

[P7_Mr1,P7_Pr1,P7_Mmax1,P7_Pmax1,P7_Mr2,P7_Pr2,P7_Mmax2,P7_Pmax2]=strain_transformation_alt(P7_6353_lpff,P7_6355_lpff);
[P8_Mr1,P8_Pr1,P8_Mmax1,P8_Pmax1,P8_Mr2,P8_Pr2,P8_Mmax2,P8_Pmax2]=strain_transformation_alt(P8_6353_lpff,P8_6355_lpff);
[P9_Mr1,P9_Pr1,P9_Mmax1,P9_Pmax1,P9_Mr2,P9_Pr2,P9_Mmax2,P9_Pmax2]=strain_transformation_alt(P9_6353_lpff,P9_6355_nr_lpff);


Pset1=[  M7_Pmax1  M8_Pmax1  M9_Pmax1  P7_Pmax1  P8_Pmax1  P9_Pmax1 ];
Mset1=[  M7_Mmax1  M8_Mmax1  M9_Mmax1  P7_Mmax1  P8_Mmax1  P9_Mmax1 ];

Pset2=[  M7_Pmax2  M8_Pmax2  M9_Pmax2  P7_Pmax2  P8_Pmax2  P9_Pmax2 ];
Mset2=[  M7_Mmax2  M8_Mmax2  M9_Mmax2  P7_Mmax2  P8_Mmax2  P9_Mmax2 ];

disp(' ');
out1=sprintf('  Pset1:  mean=%8.4g  std=%8.4g  ',mean(Pset1),std(Pset1));
disp(out1);
disp(' ');
out1=sprintf('  Mset1:  mean=%8.4g  std=%8.4g  ',mean(Mset1),std(Mset1));
disp(out1);
disp(' ');

out1=sprintf('  Pset2:  mean=%8.4g  std=%8.4g  ',mean(Pset2),std(Pset2));
disp(out1);
disp(' ');
out1=sprintf('  Mset2:  mean=%8.4g  std=%8.4g  ',mean(Mset2),std(Mset2));
disp(out1);
disp(' ');




K=4.965;

PP1=mean(Pset1) + K*std(Pset1);
MM1=mean(Mset1) + K*std(Mset1);

PP2=mean(Pset2) + K*std(Pset2);
MM2=mean(Mset2) + K*std(Mset2);


out1=sprintf('TVC1:  P99.7/90:    %8.4g     %8.4g  ',PP1,MM1);
disp(out1);

out1=sprintf('TVC2:  P99.7/90:    %8.4g     %8.4g  ',PP2,MM2);
disp(out1)

