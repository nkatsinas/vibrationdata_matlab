
% subplots_loglin_1x4.m  ver 1.1 by Tom Irvine

function[fig_num]=subplots_loglin_1x4(fig_num,x_label,...
               y_label,t_string1,t_string2,t_string3,t_string4,...
                                                   ppp1,ppp2,ppp3,ppp4,fmin,fmax)




[xtt,xTT,iflag]=xtick_label(fmin,fmax);                                    
                                               
                                               
ymax=max([ max(ppp1(:,2))  max(ppp2(:,2))  max(ppp3(:,2))  max(ppp4(:,2))   ]);                                              
ymin=min([ min(ppp1(:,2))  min(ppp2(:,2))  min(ppp3(:,2))  min(ppp4(:,2))   0  ]);           

                                               
                                               
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);                                              
                                               
                                               
   
hp=figure(fig_num);
fig_num=fig_num+1;

%

subplot(1,4,1);
plot(ppp1(:,1),ppp1(:,2));
ylabel(y_label);
xlabel(x_label);
title(t_string1);
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','on','YGrid','on');
%
set(gca,'XGrid','on','GridLineStyle','-');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin','YMinorTick','on')
grid minor;
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);   
end
xlim([fmin,fmax]);          
    
%

subplot(1,4,2);
plot(ppp2(:,1),ppp2(:,2));
ylabel(y_label);
xlabel(x_label);
title(t_string2);
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','on','YGrid','on');
%
set(gca,'XGrid','on','GridLineStyle','-');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin','YMinorTick','on')
grid minor;
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);   
end
xlim([fmin,fmax]);           
    
%

subplot(1,4,3);
plot(ppp3(:,1),ppp3(:,2));
ylabel(y_label);
xlabel(x_label);
title(t_string3);
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','on','YGrid','on');
%
set(gca,'XGrid','on','GridLineStyle','-');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin','YMinorTick','on')
grid minor;
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);   
end
xlim([fmin,fmax]);
    
           
%

subplot(1,4,4);
plot(ppp4(:,1),ppp4(:,2));
ylabel(y_label);
xlabel(x_label);
title(t_string4);
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','on','YGrid','on');
%
set(gca,'XGrid','on','GridLineStyle','-');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin','YMinorTick','on')
grid minor;

set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);   
end
xlim([fmin,fmax]);           
    
%

set(hp, 'Position', [0 0 1500 400]);
