
%
%   generate_plot_srs.m  ver 1.0 by Tom Irvine   
%
function[]=generate_plot_srs(accel_abs_srs,accel_pn_srs,Q)

    figure(1);
    plot(accel_abs_srs(:,1),accel_abs_srs(:,2));
        
    
    grid on;
    xlabel('Natural Frequency (Hz)');
    ylabel('Peak Accel (G)');
    out1=sprintf('Absolute Shock Response Spectrum  Q=%g',Q);
    title(out1);
    
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
    
    ymax= 10^ceil(log10(max(accel_abs_srs(:,2))*1.2));
    ymin= 10^floor(log10(min(accel_abs_srs(:,2))*0.999));
    
    z=ymax/1.0e+06;
    
    if(ymin<z)
        ymin=z;
    end
    
    ylim([ymin,ymax]);              
    
    
    fstart=accel_abs_srs(1,1);
      fend=accel_abs_srs(end,1);
    
    [xtt,xTT,iflag]=xtick_label_f(fstart,fend);
    
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        xlim([min(xtt),max(xtt)]);
    end

 %%%%%%
 
    figure(2);
    plot(accel_pn_srs(:,1),accel_pn_srs(:,2),accel_pn_srs(:,1),accel_pn_srs(:,3));
    legend('Peak Pos','Peak Neg');    
    grid on;
    xlabel('Natural Frequency (Hz)');
    ylabel('Peak Accel (G)');
    out1=sprintf('Shock Response Spectrum  Q=%g',Q);
    title(out1);
    
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
    
    ylim([ymin,ymax]);   
                 
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        xlim([min(xtt),max(xtt)]);
    end
 