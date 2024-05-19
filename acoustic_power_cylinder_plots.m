%
%  acoustic_power_cylinder_plots.m  ver 1.0  by Tom Irvine
%
function[fig_num]=acoustic_power_cylinder_plots(fig_num,power,mdens,rad_eff,dlf,iu)
 
x_label='Center Frequency (Hz)';
md=4;


ppp1=power;
fmin=min(ppp1(:,1));
fmax=max(ppp1(:,1));
t_string='Acoustic Power Spectrum';
 
if(iu==1)
    y_label='Power (in-lbf/sec)';    
else
    y_label='Power (W)';     
end
 
 
[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,ppp1,fmin,fmax,md);
           
           
ppp1=mdens;
fmin=min(ppp1(:,1));
fmax=max(ppp1(:,1));
t_string='Cylindrical Shell Modal Density';
y_label='n (modes/Hz)'; 
 
 
[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,ppp1,fmin,fmax,md);           
 
           
ppp1=rad_eff;
fmin=min(ppp1(:,1));
fmax=max(ppp1(:,1));
y_label='Rad Eff';
t_string='Cylindrical Radiation Efficiency';
 
 
[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,...
               y_label,t_string,ppp1,fmin,fmax,md);
            