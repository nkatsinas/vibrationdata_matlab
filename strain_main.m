disp(' ');
disp(' * * * * *');
disp(' ');
disp('   P      M   ');


[M7_Mr,M7_Pr,M7_Mmax,M7_Pmax]=strain_transformation(M7_6353_lpff,M7_6355_lpff);
[M8_Mr,M8_Pr,M8_Mmax,M8_Pmax]=strain_transformation(M8_6353_lpff,M8_6355_lpff);
[M9_Mr,M9_Pr,M9_Mmax,M9_Pmax]=strain_transformation(M9_6353_lpff,M9_6355_lpff);



[P7_Mr,P7_Pr,P7_Mmax,P7_Pmax]=strain_transformation(P7_6353_lpff,P7_6355_lpff);
[P8_Mr,P8_Pr,P8_Mmax,P8_Pmax]=strain_transformation(P8_6353_lpff,P8_6355_lpff);
[P9_Mr,P9_Pr,P9_Mmax,P9_Pmax]=strain_transformation(P9_6353_lpff,P9_6355_nr_lpff);


Pset=[  M7_Pmax  M8_Pmax  M9_Pmax  P7_Pmax  P8_Pmax  P9_Pmax ];
Mset=[  M7_Mmax  M8_Mmax  M9_Mmax  P7_Mmax  P8_Mmax  P9_Mmax ];

out1=sprintf('  Pset:  mean=%8.4g  std=%8.4g  ',mean(Pset),std(Pset));
disp(out1);

out1=sprintf('  Mset:  mean=%8.4g  std=%8.4g  ',mean(Mset),std(Mset));
disp(out1);

K=4.965;

PP=mean(Pset) + K*std(Pset);
MM=mean(Mset) + K*std(Mset);


out1=sprintf('  P99.7/90:    %8.4g     %8.4g  ',PP,MM);
disp(out1);