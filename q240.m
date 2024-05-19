   
clear P7_ratio1;
clear P7_ratio2;

k=1;
for i=ip7:jp7
    P7_ratio1(k)=P7_pm4_Q(i,2)/(1+ 0.13*P7_pm4_M(i,2)^2);
    P7_ratio2(k)=P7_pm4_Q(i,2)/(1+      P7_pm4_M(i,2)^2); k=k+1;   
end
maxR1(7)=max(P7_ratio1);
maxR2(7)=max(P7_ratio2);


P7_Q=[tm4(im7:jm7) P7_pm4_Q(im7:jm7,2)];
P7_ratio1=[tm4(im7:jm7) P7_ratio1' ];
P7_ratio2=[tm4(im7:jm7) P7_ratio2' ];  



figure(240);

   
    
   yyaxis left
    plot(P7_Q(:,1),P7_Q(:,2),P7_ratio1(:,1),P7_ratio1(:,2),P7_ratio2(:,1),P7_ratio2(:,2));
    title('NS P7 AC-6319 Fwd Fin Box Descent Supersonic');
    ylabel('Q Parameter (psf)');
    
    grid on;

    yyaxis right
    plot(P7_AC_6319_th_bessel_20Hz_RMS(:,1),P7_AC_6319_th_bessel_20Hz_RMS(:,2));
    ylabel('Accel (GRMS)');
    grid on;
    xlabel('Time (sec)');
    legend('Q','Q/(1+0.13*M^2)','Q/(1+M^2)','GRMS');
    xlim([360 420]);
    