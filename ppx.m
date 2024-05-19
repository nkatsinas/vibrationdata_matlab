figure(334)

plot(Q1(:,1),Q1(:,2),...
Q2(:,1),Q2(:,2),...
Q3(:,1),Q3(:,2),...
Q4(:,1),Q4(:,2),...
Q5(:,1),Q5(:,2),...
Q6(:,1),Q6(:,2),...
Q7(:,1),Q7(:,2),...
Q8(:,1),Q8(:,2),...
Q_nom(:,1),Q_nom(:,2));

legend('M4','M5','M6','M7','M8','M9','P7','P8','Nominal');

title('NS Dynamic Pressure');
ylabel('Q (psf)');
xlabel('Time (sec)');
xlim([0 140]);
grid on;
set(gca,'Fontsize',14); 

QM4=Q1;
QM5=Q2;
QM6=Q3;
QM7=Q4;
QM8=Q5;
QM9=Q6;
QP7=Q7;
QP8=Q8;