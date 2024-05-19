%
%  accel_PSD_syn_plot.m  ver 1.2  November 16, 2012
%
function[fig_num]=...
               accel_PSD_syn_plot(fig_num,freq,full,freq_spec,amp_spec,rms)
%    
    disp(' ')
 %           
    figure(fig_num);
    fig_num=fig_num+1;
    plot(freq,full,'b',freq_spec,amp_spec,'r',...
           freq_spec,sqrt(2)*amp_spec,'k',freq_spec,amp_spec/sqrt(2),'k');
    legend ('Synthesis','Specification','+/- 1.5 dB tol ');
 %   
    fmin=freq_spec(1);
    fmax=max(freq_spec);
    ymax=max(full);
%  
    xlabel(' Frequency (Hz)');
    ylabel(' Accel (G^2/Hz)'); 
    at = sprintf(' Power Spectral Density  Overall Level = %6.3g GRMS ',rms);   
    title(at);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log'); 
    grid;
%
    tb=sqrt(sqrt(2));
    ymax=10^(ceil(+0.1+log10(ymax)));
    ymin = min(amp_spec/tb);
    ymin=10^(floor(-0.1+log10(ymin))); 
%
    if(fmin==20. && fmax==2000.)
            set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
            set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
            axis([fmin,fmax,ymin,ymax]);  
    end
    if(fmin==10. && fmax==2000.)
            set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
            set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
            axis([fmin,fmax,ymin,ymax]); 
    end
%
end