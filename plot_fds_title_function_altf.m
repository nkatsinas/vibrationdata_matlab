%
%  plot_fds_title_function_altf.m  ver 1.2   By Tom Irvine
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
%     nmetric = 1 for acceleration (G)
%             = 2 for pseudo velocity 
%             = 3 for relative displacement
%             = 4 for transmitted pressure 
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
function[fig_num,hp]=plot_fds_title_function_altf(fig_num,x_label,ppp,fmin,fmax,nmetric,Q,bex,FS,iu)
%
f=ppp(:,1);
a=ppp(:,2);
%
hp=figure(fig_num);
fig_num=fig_num+1;
%
plot(f,log10(a));

%
[y_label,t_string]=fds_ylabel_apvtp(Q,bex,nmetric,iu);
t_string=strrep(t_string,'Fatigue Damage Spectra','FDS');
t_string=strrep(t_string,'Acceleration','Accel');
t_string=sprintf('%s  %s',t_string,FS);
y_label=strrep(y_label,'(','log10(');
ylabel(y_label);

t_string=strrep(t_string,'Spectra','Spectrum');

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
