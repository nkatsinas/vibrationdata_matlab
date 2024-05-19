close all

a=[1 200; 1000 100; 1e+07 1; 1e+09 1 ];
b=[5032.35 44.5774; 5032.35 12.9804  ];
c=[59350.1 12.9804; 5032.35  12.9804   ];
d=[1 1; 1e+09 1];
e=[1 100; 1e+09 100];
f=[1 3162; 1e+09 0.1];
g=[1000 0.1; 1000 100];
h=[1e+07 0.1; 1e+07 1];

hp=figure(1);
hold on;


plot(b(:,1),b(:,2),'k');
plot(c(:,1),c(:,2),'k');
plot(d(:,1),d(:,2),'LineStyle','--','Color',[0.5 0.5 0.5])
plot(e(:,1),e(:,2),'LineStyle','--','Color',[0.5 0.5 0.5])
plot(g(:,1),g(:,2),'LineStyle','--','Color',[0.5 0.5 0.5])
plot(h(:,1),h(:,2),'LineStyle','--','Color',[0.5 0.5 0.5])
plot(a(:,1),a(:,2),'b','linewidth', 1.2);
plot(f(:,1),f(:,2),'LineStyle','--','Color','r','linewidth', 1.2)

xlabel('N_f   Cycles to Failure','FontSize', 12);
ylabel('Stress Amplitude  S_a','FontSize', 12);
title('Idealized S-N Curve, log-log format','FontSize', 12);
grid on;
set(gca, 'xminorgrid', 'off', 'yminorgrid', 'off');
set(gca,'GridLineStyle','-','XScale','log','YScale','log');
ylim([0.4 4000]);
text(2e+07,1.25,'endurance limit','FontSize', 12)
text(2e+04,0.7,'high cycle fatigue','FontSize', 12)
text(10,0.7,'low cycle fatigue','FontSize', 12)
text(1.4e+04,10,'1','FontSize', 12)
text(2e+03,25,'c','FontSize', 12)
text(5,2500,'Basquin Curve','FontSize', 12)

ytt=[1 100 200 3162 ];
yTT={'S_e';'S_1_0_0_0';'S_u_l_t';'S_B'};

set(gca,'ytick',ytt);
set(gca,'yTickLabel',yTT,'FontSize', 12);
set(gca,'XMinorTick','Off')
set(gca,'YMinorTick','Off')
set(gca,'YGrid','off')

hold off;


set(hp, 'Position', [0 0 950 500]);