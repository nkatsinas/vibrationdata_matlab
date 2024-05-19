
%  sdof_psd_response_base.m  ver 1.1  by Tom Irvine

%    SDOF system psd response for base excitation
%
%    Better than Miles equation
%
%    base_psd = base input psd with two columns:
%       frequency (Hz) & acceleration input (G^2/Hz)
%
%    base_psd is interpolated inside the function to 1/96th octave
%
%       fn = natural frequency (Hz)
%        Q = amplification factor (typically Q=10)
%
%      units
%
%      iu = 1  for G, in/sec, in
%         = 2  for G, m/sec, mm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output Arrays
%
%     accel_response_psd:   freq (Hz) & Accel (G^2/Hz)
%     accel_power_trans:    freq (Hz) & Trans (G^2/G^2)
%     rd_response_psd:      freq (Hz) & Rel Disp (in^2/Hz) or (mm^2/Hz)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External Functions
%
%     xtick_label_f
%     ymax_ymin_md
%     ytick_log
%     calculate_PSD_slopes_f
%     fix_size
%     interpolate_PSD_arbitrary_frequency_f
%     vibrationdata_sdof_ran_engine_function_ard
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[accel_response_psd,accel_power_trans,rd_response_psd]=...
                                   sdof_psd_response_base(fn,Q,base_psd,iu)
    
    damp=1/(2*Q);
    
    fstart=base_psd(1,1);
      fend=base_psd(end,1);
 
    num=96*log(fend/fstart)/log(2);
    new_freq=logspace(log10(fstart),log10(fend),num);
  
    [freq,base_psd_int] = interpolate_PSD_arbitrary_frequency_f(base_psd(:,1),base_psd(:,2),new_freq);

    natural_frequency=fn;
            
    [a_vrs,~,trans,opsd,rd_psd]=...
                   vibrationdata_sdof_ran_engine_function_ard(freq,base_psd_int,damp,natural_frequency);

    if(iu==1)
        rd_psd=rd_psd*386^2;
    else
        rd_psd=rd_psd*(9.81*1000)^2;
    end
   
    fig_num=1;
            
    fi=fix_size(freq);
    opsd=fix_size(opsd);
    trans=fix_size(trans);
            
    rd_psd=fix_size(rd_psd);
    %
    ppp=[fi opsd];
    qqq=base_psd;
    %
    accel_response_psd=[fi opsd];
    accel_power_trans=[fi trans];
    rd_response_psd=[fi rd_psd];
    %  
     
    x_label=sprintf(' Frequency (Hz)');
         
    y_label=sprintf(' Accel (G^2/Hz)');
    leg_a=sprintf('Response %5.3g GRMS',a_vrs);

    [~,rms] = calculate_PSD_slopes_f(base_psd(:,1),base_psd(:,2));
    leg_b=sprintf('Input %5.3g GRMS',rms);   
         
    t_string = sprintf(' Power Spectral Density   fn=%g Hz  Q=%g  ',natural_frequency,Q);   
    %
    [fig_num,~]=plot_PSD_two_sdof_ran_f(fig_num,x_label,y_label,t_string,ppp,qqq,leg_a,leg_b,fstart,fend); 
    %
            
    ppp=[fi trans];  
    x_label=sprintf(' Frequency (Hz)');
    if(iu<=2)
        y_label=sprintf(' Trans (G^2/G^2)'); 
    else
        y_label=sprintf(' Trans ((m/sec^2)^2/(m/sec^2)^2)');     
    end    
    t_string = sprintf(' Power Transmissibility   fn=%g Hz  Q=%g',natural_frequency,Q);   
    [fig_num,~]=plot_PSD_function(fig_num,x_label,y_label,t_string,ppp,fstart,fend);

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        
    [~,rd_rms] = calculate_PSD_slopes_f(rd_response_psd(:,1),rd_response_psd(:,2));

            
    if(iu<=1)
        y_label=sprintf('Rel Disp (inch^2/Hz)'); 
        t_string = sprintf(' Relative Displacement PSD   fn=%g Hz  Q=%g \n Overall Level = %7.3g in RMS',natural_frequency,Q,rd_rms);   
    else
        y_label=sprintf('Rel Disp (mm^2/Hz)');     
        t_string = sprintf(' Relative Displacement PSD   fn=%g Hz  Q=%g \n Overall Level = %7.3g mm RMS',natural_frequency,Q,rd_rms);       
    end
            
    ppp=rd_response_psd;
    md=5;
    [~,~]=plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fstart,fend,md);
