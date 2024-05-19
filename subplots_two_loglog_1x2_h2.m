%
%  subplots_two_loglog_1x2_h2.m  ver 1.0  by Tom Irvine
%

function[fig_num,h2]=subplots_two_loglog_1x2_h2(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2,nfont)

fmin=min(data1(:,1));
fmax=max(data1(:,1));


h2=figure(fig_num);

subplot(1,2,1);
plot(data1(:,1),data1(:,2));
grid on;
xlabel(xlabel2);
ylabel(ylabel1);
title(t_string1);
set(gca,'Fontsize',nfont);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
[xtt,xTT,iflag]=xtick_label(fmin,fmax);
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    f1=min(xtt);
    f2=max(xtt);    
end

xlim([f1 f2]);

%
subplot(1,2,2);
plot(data2(:,1),data2(:,2));
grid on;
xlabel(xlabel2);
ylabel(ylabel2);
title(t_string2);
set(gca,'Fontsize',nfont);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
[xtt,xTT,iflag]=xtick_label(fmin,fmax);
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    f1=min(xtt);
    f2=max(xtt);    
end

xlim([f1 f2]);


set(h2, 'Position', [0 0 900 400]);



fig_num=fig_num+1;