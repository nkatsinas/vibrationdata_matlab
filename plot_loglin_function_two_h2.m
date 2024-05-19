%
%  plot_loglin_function_two_h2.m  ver 1.4  by Tom Irvine
%
function[fig_num,h2]=plot_loglin_function_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax)
%
fa=ppp1(:,1);
fb=ppp2(:,1);



a=ppp1(:,2);
b=ppp2(:,2);
%
h2=figure(fig_num);
fig_num=fig_num+1;
%
plot(fa,a,fb,b)
%
legend(leg1,leg2);

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


%%%

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);   
    xlim([fmin,fmax]);
end


%
set(gca,'MinorGridLineStyle','-','GridLineStyle','-','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','on');
%
%
grid on;