%
%  plot_loglog_function_leg.m  ver 1.1   By Tom Irvine
%
function[fig_num]=plot_loglog_function_leg(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,leg)
%
f=ppp(:,1);
a=ppp(:,2);
%
figure(fig_num);
fig_num=fig_num+1;
%
plot(f,a)
legend(leg);
%
ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end


ymin=min(a);
ymax=max(a);

[ytt,yTT,iflag]=ytick_label(ymin,ymax);
 

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end
