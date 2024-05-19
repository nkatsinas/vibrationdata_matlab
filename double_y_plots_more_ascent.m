

figure(21);

   yyaxis left
    plot(M7_ns4_Q(:,1),M7_ns4_Q(:,2),M7_ratio1(:,1),M7_ratio1(:,2),M7_ratio2(:,1),M7_ratio2(:,2));
    ttt='NS M7 AC-6319 Fwd Fin Box Ascent';
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(M7_AC_6319_th_bessel_20Hz_RMS(:,1),M7_AC_6319_th_bessel_20Hz_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([20 120]);
    
    ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    figure(22);

   yyaxis left
    plot(M8_ns4_Q(:,1),M8_ns4_Q(:,2),M8_ratio1(:,1),M8_ratio1(:,2),M8_ratio2(:,1),M8_ratio2(:,2));
    
    ttt='NS M8 AC-6319 Fwd Fin Box Ascent';
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(M8_AC_6319_th_bessel_20Hz_RMS(:,1),M8_AC_6319_th_bessel_20Hz_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([20 120]);
   
        ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  
    figure(23);

   yyaxis left
    plot(M9_ns4_Q(:,1),M9_ns4_Q(:,2),M9_ratio1(:,1),M9_ratio1(:,2),M9_ratio2(:,1),M9_ratio2(:,2));
    ttt='NS M9 AC-6319 Fwd Fin Box Ascent';
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(M9_AC_6319_th_bessel_20Hz_RMS(:,1),M9_AC_6319_th_bessel_20Hz_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([20 120]);
    
        ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    figure(24);

   yyaxis left
    plot(P7_ns4_Q(:,1),P7_ns4_Q(:,2),P7_ratio1(:,1),P7_ratio1(:,2),P7_ratio2(:,1),P7_ratio2(:,2));
    ttt='NS P7 AC-6319 Fwd Fin Box Ascent';
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(P7_AC_6319_th_bessel_20Hz_RMS(:,1),P7_AC_6319_th_bessel_20Hz_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([20 120]);
    
        ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
       figure(25);

   yyaxis left
    plot(P8_ns4_Q(:,1),P8_ns4_Q(:,2),P8_ratio1(:,1),P8_ratio1(:,2),P8_ratio2(:,1),P8_ratio2(:,2));
    ttt='NS P8 AC-6319 Fwd Fin Box Ascent';
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(P8_AC_6319_th_bessel_20Hz_RMS(:,1),P8_AC_6319_th_bessel_20Hz_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([20 120]);
    
        ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
            figure(30);

   yyaxis left
    plot(M4_ns4_Q(:,1),M4_ns4_Q(:,2),M4_ratio1(:,1),M4_ratio1(:,2),M4_ratio2(:,1),M4_ratio2(:,2));
    ttt='NS M4 AC-6310 Fwd Fin Box Ascent';
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(M4_AC_6310_th_bessel_20Hz_RMS(:,1),M4_AC_6310_th_bessel_20Hz_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([20 120]);
    
        ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


            figure(31);

   yyaxis left
    plot(M5_ns4_Q(:,1),M5_ns4_Q(:,2),M5_ratio1(:,1),M5_ratio1(:,2),M5_ratio2(:,1),M5_ratio2(:,2));
    ttt='NS M5 AC-6310 Fwd Fin Box Ascent';
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(M5_AC_6310_th_bessel_20Hz_RMS(:,1),M5_AC_6310_th_bessel_20Hz_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([20 120]);

        ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)
    
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            figure(40);

   yyaxis left
    plot(M5_ns4_Q(:,1),M5_ns4_Q(:,2),M5_ratio1(:,1),M5_ratio1(:,2),M5_ratio2(:,1),M5_ratio2(:,2));
    ttt='NS M5 AC-6322 Fwd Fin Ring Frame Valve Base Ascent';
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(M5_AC_6322_th_bessel_20Hz_RMS(:,1),M5_AC_6322_th_bessel_20Hz_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([20 120]);
    
        ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


            figure(41);

   yyaxis left
    plot(M6_ns4_Q(:,1),M6_ns4_Q(:,2),M6_ratio1(:,1),M6_ratio1(:,2),M6_ratio2(:,1),M6_ratio2(:,2));
    ttt='NS M6 AC-6322 Fwd Fin Ring Frame Valve Base Ascent';
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(M6_AC_6322_th_bessel_20Hz_RMS(:,1),M6_AC_6322_th_bessel_20Hz_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([20 120]);

        ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)
    
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            figure(50);

   yyaxis left
    plot(M4_ns4_Q(:,1),M4_ns4_Q(:,2),M4_ratio1(:,1),M4_ratio1(:,2),M4_ratio2(:,1),M4_ratio2(:,2));
    ttt='NS M4 AC-6320 Fwd Ring Frame OML Ascent';
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(M4_AC_6320_th_bessel_20Hz_RMS(:,1),M4_AC_6320_th_bessel_20Hz_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([20 120]);
    
        ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


            figure(51);

   yyaxis left
    plot(M5_ns4_Q(:,1),M5_ns4_Q(:,2),M5_ratio1(:,1),M5_ratio1(:,2),M5_ratio2(:,1),M5_ratio2(:,2));
    ttt='NS M5 AC-6320 Fwd Ring Frame OML Ascent';
    title(ttt);
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(M5_AC_6320_th_bessel_20Hz_RMS(:,1),M5_AC_6320_th_bessel_20Hz_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([20 120]);

        ttt=strrep(ttt,'-','_');
    ttt=strrep(ttt,' ','_');
    ttt=sprintf('%s.fig',ttt);
    savefig(ttt)