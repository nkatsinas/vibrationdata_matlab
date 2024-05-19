

%   state_space_plots_two.m  ver 1.0  by Tom Irvine


function[fig_num]=state_space_plots_two(fig_num,md,iu,Hd_11_abs,Hd_12_abs,Hd_22_abs,...
                                                      Hv_11_abs,Hv_12_abs,Hv_22_abs,...
                                                      Ha_11_abs,Ha_12_abs,Ha_22_abs)                                             

fmin=Hd_11_abs(1,1);    
fmax=max(Hd_11_abs(:,1));                                                      
                                                  
x_label='Frequency (Hz)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    y_label='Disp/Force (in/lbf)';
else
    y_label='Disp/Force (m/N)';    
end

t_string='Receptance FRF';

ppp1=Hd_11_abs;
ppp2=Hd_12_abs;
ppp3=Hd_22_abs;

leg1='H11';
leg2='H12';
leg3='H22';

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    y_label='Vel/Force (in/sec/lbf)';
else
    y_label='Vel/Force (m/sec/N)';    
end

t_string='Mobility FRF';

ppp1=Hv_11_abs;
ppp2=Hv_12_abs;
ppp3=Hv_22_abs;

leg1='H11';
leg2='H12';
leg3='H22';

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    y_label='Accel/Force (G/lbf)';
else
    y_label='Accel/Force (G/N)';    
end

t_string='Accelerance FRF';

ppp1=Ha_11_abs;
ppp2=Ha_12_abs;
ppp3=Ha_22_abs;

leg1='H11';
leg2='H12';
leg3='H22';

[fig_num,h2]=plot_loglog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
