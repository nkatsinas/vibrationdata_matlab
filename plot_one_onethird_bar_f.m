%
%  plot_one_onethird_bar_f.m  ver 1.1  by Tom Irvine
%

function[fig_num]=plot_one_onethird_bar_f(fig_num,xlab,ylab,data,t_string,fmin,fmax)


figure(fig_num);

L=length(data(:,1));

for i=1:L

    ff=data(i,1);
    x=[ff ff];
    y=[1 data(i,2)];

    if(data(i,2)>=1)
        line(x,y,'LineWidth',3);
    end
end


[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt); 
end   

xlim([fmin fmax]);

yy=10^ceil(log10(max(data(:,2))));

 ylim([1 yy])

grid on;



xlabel(xlab);
ylabel(ylab);
title(t_string);
 set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');



fig_num=fig_num+1;