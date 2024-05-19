%
%  subplots_two_loglog_2x2_h2.m  ver 1.0  by Tom Irvine
%

function[fig_num,h2]=subplots_two_loglog_2x2_h2(fig_num,xlabel2,...
                     ylabel1,ylabel2,data11,data21,data12,data22,...
                     leg11,leg21,leg12,leg22,t_string1,t_string2,nfont)

fmin=min(data11(:,1));
fmax=max(data11(:,1));


h2=figure(fig_num);

subplot(1,2,1);
plot(data11(:,1),data11(:,2),data21(:,1),data21(:,2));
legend(leg11,leg21);
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
plot(data12(:,1),data12(:,2),data22(:,1),data22(:,2));
legend(leg12,leg22);
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