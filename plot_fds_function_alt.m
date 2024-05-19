%
%  plot_fds_function_alt.m  ver 1.3   By Tom Irvine
%
%  This script plots a fatigue damage spectrum
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%     fig_num = figure number
%      
%         ppp = fatigue damage spectrum - natural freq (Hz) & damage
%     x_label = x-axis label
%   fmin,fmax = minimum & maximum plot frequencies
%
%           Q = amplification factor
%         bex = fatigue exponent 
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
%      xtick_label.m
%      ytick_linear_min_max_alt.m
%      fds_ylabel_apvtp.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[fig_num]=plot_fds_function_alt(fig_num,x_label,y_label,t_string,ppp,fmin,fmax)
%
f=ppp(:,1);
a=ppp(:,2);
%
figure(fig_num);
fig_num=fig_num+1;
%
plot(f,log10(a));

y_label=strrep(y_label,'(','log10(');
ylabel(y_label);
xlabel(x_label);

out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle','-');
set(gca,'YGrid','on','GridLineStyle','-');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end


ymin=min(a);
ymax=max(a);

ymax=log10(ymax);
ymin=log10(ymin);


[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
