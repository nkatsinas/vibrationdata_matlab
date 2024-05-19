%
%  plot_fds_two_function.m  ver 1.2  by Tom Irvine
%
%  This script plots a fatigue damage spectrum
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%     fig_num = figure number
%      
%          ppp = fatigue damage spectrum 1 - natural freq (Hz) & damage
%          qqq = fatigue damage spectrum 2 - natural freq (Hz) & damage
%
%   leg_a,leg_b = legends for each of the two FDS fuctions
%
%    t_string = title (should include Q & b values)
%     x_label = x-axis label
%   fmin,fmax = minimum & maximum plot frequencies
%
%     nmetric = 1 for acceleration (G)
%             = 2 for pseudo velocity (in/sec)
%             = 3 for transmitted pressure (psi)
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
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[fig_num,h]=...
         plot_fds_two_function(fig_num,x_label,ppp,qqq,leg_a,leg_b,Q,bex,nmetric,fmin,fmax)
%
h=figure(fig_num);
fig_num=fig_num+1;
%
plot(ppp(:,1),log10(ppp(:,2)),qqq(:,1),log10(qqq(:,2)));
%
legend(leg_a,leg_b);
%
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);
end   

%
xlim([fmin,fmax]);

xx=ppp(:,2);
ff=qqq(:,2);
ymax=max([ max(log10(xx)) max(log10(ff))  ]);
ymin=min([ min(log10(xx)) min(log10(ff))  ]);
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);

iu=1;
[y_label,t_string]=fds_ylabel_apvtp(Q,bex,nmetric,iu);
y_label=strrep(y_label,'(','log10(');

out=sprintf(t_string);
title(out);

ylabel(y_label);   
xlabel(x_label);

%
set(gca,'XGrid','on','GridLineStyle','-');
set(gca,'YGrid','on','GridLineStyle','-');
