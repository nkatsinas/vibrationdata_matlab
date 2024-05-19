%
%  plot_psd_two_function.m  ver 1.1   by Tom Irvine
%
%  Plot two PSDs
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input variables:
%
%     fig_num = figure number
%     x_label = PSD x-axis label such as 'Frequency(Hz)'
%     y_label = PSD y-axis label such as 'Accel(G^2/Hz)'
%     rms_label = RMS label such as 'GRMS'
%
%     t_string = title string
%     ppp = first  psd input array with two columns:  freq(Hz) & amp(unit^2/Hz)
%     qqq = second psd input array with two columns:  freq(Hz) & amp(unit^2/Hz)
%
%     leg1 = first legend
%     leg2 = second legend
%
%     fmin,fmax = minimum & maximum frequencies (Hz) for plot
%
%     md = maximum number of decades such as 6
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output variables:
%
%     fig_num = input figure number plus 1 
%     h = figure handle
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  External functions:
%
%    calculate_PSD_slopes.m
%    plot_loglog_function_md_two_h2.m
%    xtick_label.m
%    ymax_ymin_md.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'

function[fig_num,h]=...
         plot_psd_two_function(fig_num,x_label,y_label,rms_label,t_string,ppp,qqq,leg1,leg2,fmin,fmax)

[~,rms1] = calculate_PSD_slopes_no(ppp(:,1),ppp(:,2));
[~,rms2] = calculate_PSD_slopes_no(qqq(:,1),qqq(:,2));

leg1=sprintf('%s  %7.3g %s ',leg1,rms1,rms_label);
leg2=sprintf('%s  %7.3g %s ',leg2,rms2,rms_label);

md=6;

[fig_num,h]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp,qqq,leg1,leg2,fmin,fmax,md);
