%
%   abs_srs_plot_function.m  ver 1.2  by Tom Irvine
%
function[fig_num]=abs_srs_plot_function(fig_num,fn,accel,t_string,y_lab,fmin,fmax)
%
figure(fig_num);
fig_num=fig_num+1;
plot(fn,accel);
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
ymax=10^(ceil(log10(max(1.01*accel))));
ymin=10^(floor(log10(min(accel))));
%
xlim([fmin fmax]);
ylim([ymin ymax]);
%
grid on;
