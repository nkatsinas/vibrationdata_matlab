%
%  plot_psd_loglog_function.m  ver 1.1 by Tom Irvine
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
%     ppp = psd input array with two columns:  freq(Hz) & amp(unit^2/Hz)
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
%     h2 = figure handle
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  External functions:
%
%    calculate_PSD_slopes_no.m
%    plot_loglog_function_md.m
%    xtick_label.m
%    ymax_ymin_md.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'

function[fig_num,h2]=plot_psd_loglog_function(fig_num,x_label,y_label,rms_label,t_string,ppp,fmin,fmax,md)
%

[~,rms] = calculate_PSD_slopes_no(ppp(:,1),ppp(:,2));

t_string=sprintf('%s  %7.3g %s ',t_string,rms,rms_label);

[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);







