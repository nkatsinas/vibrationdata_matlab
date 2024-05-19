%
%  subplots_three_linlin_three_titles_scale_same.m  ver 1.1  by Tom Irvine
%

function[fig_num]=subplots_three_linlin_three_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3)


try
    close fig_num;
end
try
    close fig_num hidden;
end

hp=figure(fig_num);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


yabs=max([ max(abs(data1(:,2))) max(abs(data2(:,2))) max(abs(data3(:,2)))]);

[~,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);


subplot(3,1,1);
plot(data1(:,1),data1(:,2));
ylabel(ylabel1);
title(t_string1);
if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

grid on;

%
subplot(3,1,2);
plot(data2(:,1),data2(:,2));
xlabel(xlabel2);
ylabel(ylabel2);
title(t_string2);
if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

grid on;

%
subplot(3,1,3);
plot(data3(:,1),data3(:,2));
xlabel(xlabel2);
ylabel(ylabel3);
title(t_string3);
if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

grid on;

set(hp, 'Position', [100 100 1100 700]);
fig_num=fig_num+1;