%
%  gust_psd_syn_output_plots.m  ver 1.0  October 12, 2012
%
function[fig_num]=...
gust_psd_syn_output_plots(fig_num,TT,psd_TH,dispx,freq_spec,amp_spec,rms,freq,full)
%
[fig_num]=...
plot_time_history(fig_num,'Vel(ft/sec)','Synthesized Velocity Time History',[TT psd_TH],1);
%
[fig_num]=...
plot_time_history(fig_num,'Disp(ft)','Synthesized Displacement Time History',[TT dispx],1);
%
disp(' ')
disp(' Plot velocity histogram? ')
hchoice = input(' 1=yes 2=no ');
%
if(hchoice == 1)
    [fig_num]=plot_histogram(psd_TH,'Velocity(ft/sec)',fig_num);
end    
%
[fig_num]=gust_PSD_syn_plot(fig_num,freq,full,freq_spec,amp_spec,rms);