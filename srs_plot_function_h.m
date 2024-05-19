%
%   srs_plot_function_h.m  ver 1.3  by Tom Irvine
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%     fig_num = figure number
%          fn = natural frequency (Hz)
%       a_pos = positive SRS
%       a_neg = negative SRS
%      
%    t_string = title (should include Q value)
%       y_lab = y-axis label
%   fmin,fmax = minimum & maximum plot frequencies
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variables
%
%      fig_num = figure number plus 1
%            h = figure handle
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions
%
%      xtick_label
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[fig_num,h]=...
       srs_plot_function_h(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax)
%
h=figure(fig_num);
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
    fmax=max(xtt);
end
%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%

yymax=max([ max(a_pos) max(a_neg) ]);

yymin=1.0e+20;

for i=1:length(fn)
    if(a_pos(i)<yymin && a_pos(i)>1.0e-10)
        yymin=a_pos(i);
    end
    if(a_neg(i)<yymin && a_neg(i)>1.0e-10)
        yymin=a_neg(i);
    end
end

    
ymin=10^(floor(log10(yymin)));
ymax=10^(ceil(log10(yymax)));

if( (yymax/ymax) >0.4)
    ymax=ymax*10;
end

xlim([fmin fmax]);
ylim([ymin ymax]);
%
grid on;
