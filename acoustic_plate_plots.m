%
%  acoustic_plate_plots.m ver 1.0  by Tom Irvine
%
function[fig_num]=acoustic_plate_plots(fig_num,x,y,iu,f,HM,HM_stress_xx,HM_stress_yy,HM_stress_xy,HM_stress_vM)
%
md=6;

fmin=f(1);
fmax=f(end);


f=fix_size(f);
HM=fix_size(HM);
HM_stress_vM=fix_size(HM_stress_vM);
HM_stress_xx=fix_size(HM_stress_xx);
HM_stress_yy=fix_size(HM_stress_yy);
HM_stress_xy=fix_size(HM_stress_xy);

x_label='Frequency (Hz)';

%%%%%%

if(iu==1)
    t_string=sprintf('Displacement Frequency Response Function at x=%g y=%g inch ',x,y);
    y_label='[Displacement/Pressure] (in/psi)';
else
    t_string=sprintf('Displacement Frequency Response Function at x=%g y=%g meters ',x,y);
    y_label='[Displacement/Pressure] (m/Pa)';    
end

ppp=[f HM];
   
[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


%
%%%

ppp1=[f HM_stress_xx];
ppp2=[f HM_stress_yy];
leg1='Hxx';
leg2='Hyy';

    if(iu==1)
        t_string=sprintf('Stress Frequency Response Function at x=%g y=%g inch ',x,y);        
        y_label='[Stress/Pressure] (psi/psi)';
    else
        t_string=sprintf('Stress Frequency Response Function at x=%g y=%g meters ',x,y);        
        y_label='[Stress/Pressure] (Pa/Pa)';        
    end

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

%%%
    
    ppp=[f HM_stress_xy];
    if(iu==1)
        t_string=sprintf('Hxy Frequency Response Function at x=%g y=%g inch',x,y);        
        y_label='[Stress/Pressure] (psi/psi)';
    else
        t_string=sprintf('Hxy Frequency Response Function at x=%g y=%g meters',x,y);           
        y_label='[Stress/Pressure] (Pa/Pa)';        
    end    
    
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
    
%%%

    ppp=[f HM_stress_vM];
    if(iu==1)
        t_string=sprintf('von Mises Stress Frequency Response Function at x=%g y=%g inch',x,y);        
        y_label='[Stress/Pressure] (psi/psi)';
    else
        t_string=sprintf('von Mises Stress Frequency Response Function at x=%g y=%g meters',x,y);           
        y_label='[Stress/Pressure] (Pa/Pa)';        
    end    
    
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

%%%