%
%  subplots_two_linlin_h2.m  ver 1.0  by Tom Irvine
%

function[fig_num,h2]=subplots_two_linlin(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2,nfont)

h2=figure(fig_num);

subplot(2,1,1);
plot(data1(:,1),data1(:,2));
grid on;
ylabel(ylabel1);
title(t_string1);
qqq=get(gca,'ylim');
qmax=max(abs(qqq));
ylim([-qmax,qmax]);
set(gca,'Fontsize',nfont);


%
subplot(2,1,2);
plot(data2(:,1),data2(:,2));
grid on;
xlabel(xlabel2);
ylabel(ylabel2);
title(t_string2);
qqq=get(gca,'ylim');
qmax=max(abs(qqq));
ylim([-qmax,qmax]);
set(gca,'Fontsize',nfont);

set(h2, 'Position', [0 0 550 450]);


fig_num=fig_num+1;