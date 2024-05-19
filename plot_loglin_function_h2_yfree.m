%
%  plot_loglin_function_h2_yfree.m  ver 1.4  by Tom Irvine
%
function[fig_num,h2]=...
    plot_loglin_function_h2_yfree(fig_num,x_label,y_label,t_string,ppp,fmin,fmax)
%

if isempty(ppp)
    warndlg(' empty array in function: plot_loglin_function_h2_yfree');
    return;
end

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
out=sprintf(t_string);
title(out);
a;
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
set(gca,'XGrid','on','GridLineStyle','-');
set(gca,'YGrid','on','GridLineStyle','-');
disp(' ');
%

xlim([fmin,fmax]);
