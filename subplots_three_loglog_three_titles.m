%
%  subplots_three_loglog_three_titles.m  ver 1.1  by Tom Irvine
%

function[fig_num]=subplots_three_loglog_three_titles(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3,fmin,fmax)


[xtt,xTT,iflag]=xtick_label(fmin,fmax);



ymin1=min(data1(:,2));
ymin2=min(data2(:,2));
ymin3=min(data3(:,2));

yymm=[ymin1 ymin2 ymin3];

newyymm = yymm(yymm > 0);

ymin=min(newyymm);



ymax=max([ max(data1(:,2))  max(data2(:,2)) max(data3(:,2)) ]);


ymin=10^(floor(log10(ymin)));
ymax=10^(ceil(log10(ymax)));


try
    close fig_num;
end
try
    close fig_num hidden;
end

hp=figure(fig_num);

subplot(1,3,1);

plot(data1(:,1),data1(:,2));
grid on;
ylabel(ylabel1);
title(t_string1);
% ylim([ymin,ymax]);

ymin=min(data1(:,2));
ymax=max(data1(:,2));
[ytt,yTT,jflag]=ytick_label(ymin,ymax);

if(jflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end
   

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
subplot(1,3,2);
plot(data2(:,1),data2(:,2));
grid on;
ylabel(ylabel2);
title(t_string2);
% ylim([ymin,ymax]);

ymin=min(data2(:,2));
ymax=max(data2(:,2));
[ytt,yTT,jflag]=ytick_label(ymin,ymax);


if(jflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end


set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
subplot(1,3,3);
plot(data3(:,1),data3(:,2));
grid on;
ylabel(ylabel3);
title(t_string3);
% ylim([ymin,ymax]);

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
ymin=min(data3(:,2));
ymax=max(data3(:,2));
[ytt,yTT,jflag]=ytick_label(ymin,ymax);


if(jflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%



disp(' ');

fig_num=fig_num+1;
set(hp, 'Position', [50 50 1400 400]);




