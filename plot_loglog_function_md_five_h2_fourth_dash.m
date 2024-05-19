%
%  plot_loglog_function_md_five_h2_fourth_dash.m  ver 1.5  by Tom Irvine
%
function[fig_num,h2]=plot_loglog_function_md_five_h2_four_dash(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp4,ppp5,leg1,leg2,leg3,leg4,leg5,fmin,fmax,md)
%
fa=ppp1(:,1);
fb=ppp2(:,1);
fc=ppp3(:,1);
fd=ppp4(:,1);
fe=ppp5(:,1);

a=ppp1(:,2);
b=ppp2(:,2);
c=ppp3(:,2);
d=ppp4(:,2);
e=ppp5(:,2);

%
h2=figure(fig_num);
fig_num=fig_num+1;
hold on;
%

% plot(fa,a,'b',fb,b,'r',fc,c,'--k',fd,d,'color',[0.0    0.50    0.50]);
% legend(leg1,leg2,leg3,leg4);

h(1)=plot(fa,a,'b');
h(2)=plot(fb,b,'r');
h(3)=plot(fc,c,'color',[0.6 0.3 0]);
h(4)=plot(fd,d,'--k');
h(5)=plot(fe,e,'color',[0.0    0.50    0.50]);

hold off;

legend(h,leg1,leg2,leg3,leg4,leg5);   

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

max_amp=max([ max(a) max(b) max(c) max(d) max(e) ]);
min_amp=min([ min(a) min(b) min(c) min(d) min(e) ]);

[ymax,ymin]=ymax_ymin_md(max_amp,min_amp,md);

%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end

%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
%
axis([fmin,fmax,ymin,ymax]);

