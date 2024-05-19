%
%   srs_plot_function.m  ver 1.2  by Tom Irvine
%
function[fig_num]=srs_plot_function(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax)
%
figure(fig_num);
fig_num=fig_num+1;
plot(fn,a_pos,fn,a_neg);
legend('positive','negative');
title(t_string);
xlabel('Natural Frequency (Hz)');
ylabel(y_lab);
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
xlim([fmin fmax]);
%
grid on;

