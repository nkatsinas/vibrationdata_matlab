%
%  plot_loglin_function_h2.m  ver 1.3  by Tom Irvine
%
function[fig_num,h2]=...
    plot_loglin_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax)
%
f=ppp(:,1);
a=ppp(:,2);
%
h2=figure(fig_num);
fig_num=fig_num+1;
%
plot(f,a)
%
ylabel(y_label);   
xlabel(x_label);
title(t_string);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);   
end


%
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
disp(' ');
%

xlim([fmin,fmax]);

yLimits = get(gca,'YLim');

[yh]=yaxis_limits_linear(yLimits,ppp(:,2)); 
ylim([0,yh]);