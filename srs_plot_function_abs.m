%
%   srs_plot_function_abs.m  ver 1.2  by Tom Irvine
%
function[fig_num]=srs_plot_function_abs(fig_num,fn,a,t_string,y_lab,fmin,fmax)
%
figure(fig_num);
fig_num=fig_num+1;
plot(fn,a);
title(t_string);
xlabel('Natural Frequency (Hz)');
ylabel(y_lab);
%
ymax= 10^ceil(log10(max(a)*1.2));
ymin= 10^floor(log10(min(a)*0.999));

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
xlim([fmin fmax]);
ylim([ymin ymax]);
%
grid on;

