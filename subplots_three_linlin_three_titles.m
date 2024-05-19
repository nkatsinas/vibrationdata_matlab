%
%  subplots_three_linlin_three_titles.m  ver 1.2  by Tom Irvine
%

function[fig_num]=...
    subplots_three_linlin_three_titles(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3)


hp=figure(fig_num);

subplot(3,1,1);
plot(data1(:,1),data1(:,2));
grid on;
ylabel(ylabel1);
title(t_string1);
yabs=max(abs(data1(:,2)));
[~,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end
x1 = xlim;


%
subplot(3,1,2);
plot(data2(:,1),data2(:,2));
grid on;
ylabel(ylabel2);
title(t_string2);
xlim([x1(1) x1(2)]);
yabs=max(abs(data2(:,2)));
[~,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end



%
subplot(3,1,3);
plot(data3(:,1),data3(:,2));
grid on;
xlabel(xlabel3);
ylabel(ylabel3);
title(t_string3);
xlim([x1(1) x1(2)]);
yabs=max(abs(data3(:,2)));
[~,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

fig_num=fig_num+1;

set(hp, 'Position', [100 100 1100 700]);