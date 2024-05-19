%
%  plot_linlog_function_md_three_h2.m  ver 1.4   by Tom Irvine
%
function[fig_num,h2]=plot_linlog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md)
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
legend(leg1,leg2,leg3);

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

max_amp=max([ max(a) max(b) max(c) ]);
min_amp=min([ min(a) min(b) min(c) ]);

[ymax,ymin]=ymax_ymin_md(max_amp,min_amp,md);

%%%


%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
try
    axis([fmin,fmax,ymin,ymax]);
catch
end    