%
%   srs_plot_abs_function_h.m  ver 1.3  by Tom Irvine
%
function[fig_num,h]=...
       srs_plot_abs_function_h(fig_num,fn,a,t_string,y_lab,fmin,fmax)
%
h=figure(fig_num);
fig_num=fig_num+1;
plot(fn,a);
title(t_string);
xlabel('Natural Frequency (Hz)');
ylabel(y_lab);
%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmax=max(xtt);
end
%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%

yymax=max(a);
yymin=min(a);
    
ymin=10^(floor(log10(yymin)));
ymax=10^(ceil(log10(yymax)));

if( (yymax/ymax) >0.4)
    ymax=ymax*10;
end

xlim([fmin fmax]);
ylim([ymin ymax]);
%
grid on;
