%
%  subplots_two_loglin_two_titles_bar.m  ver 1.1  by Tom Irvine
%

function[fig_num]=subplots_two_loglin_two_titles_bar(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2)


try
    close fig_num;
end
try
    close fig_num hidden;
end

figure(fig_num);


subplot(2,1,1);
bar(data1(:,1),data1(:,2));

fmin=data1(1,1);
fmax=max(data1(:,1));


[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
    xlim([fmin,fmax]);    
end   



ylabel(ylabel1);
title(t_string1);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
subplot(2,1,2);
bar(data2(:,1),data2(:,2));


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
    xlim([fmin,fmax]);    
end   


xlabel(xlabel2);
ylabel(ylabel2);
title(t_string2);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

fig_num=fig_num+1;