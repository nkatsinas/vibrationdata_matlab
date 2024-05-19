%
%  plot_loglin_function_three_NW_h2.m  ver 1.3  by Tom Irvine
%
function[fig_num,h2]=plot_loglin_function_three_NW_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax)
%
fa=ppp1(:,1);
fb=ppp2(:,1);
fc=ppp3(:,1);

f=fb;

a=ppp1(:,2);
b=ppp2(:,2);
c=ppp3(:,2);
%
h2=figure(fig_num);
fig_num=fig_num+1;
%
plot(fa,a,fb,b,fc,c)
%
legend(leg1,leg2,leg3,'Location','northwest');

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);

%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
%
xlim([fmin,fmax]);