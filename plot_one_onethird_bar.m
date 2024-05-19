%
%  plot_one_onethird_bar.m  ver 1.1  by Tom Irvine
%

function[fig_num]=plot_one_onethird_bar(fig_num,xlab,ylab,data,t_string)


figure(fig_num);

bar(log10(data(:,1)),data(:,2));

fmin=0.95*data(1,1);
fmax=1.05*max(data(:,1));

[xtt,xTT,iflag]=xtick_label_log(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([xtt(1) log10(1.1*fmax)]);
end   

grid on;

xlabel(xlab);
ylabel(ylab);
title(t_string);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

fig_num=fig_num+1;