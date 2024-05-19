%
%  plot_loglin_function_h2_ymax_two.m  ver 1.4  by Tom Irvine
%
function[fig_num,h2]=...
    plot_loglin_function_h2_ymax_coherence_two(fig_num,x_label,t_string,ppp,fmin,fmax,ymin,ymax)
%
f=ppp(:,1);

%
h2=figure(fig_num);
fig_num=fig_num+1;
%
plot(f,ppp(:,2),f,ppp(:,3))
%
ylabel('\gamma^2');   
xlabel(x_label);
out=sprintf(t_string);
title('Coherence');
legend('Response 1','Response 2');
legend show;

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
ylim([ymin,ymax]);

