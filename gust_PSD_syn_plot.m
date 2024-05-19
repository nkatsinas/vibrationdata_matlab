%
%  gust_PSD_syn_plot.m  ver 1.1  November 15, 2012
%
function[fig_num]=...
               gust_PSD_syn_plot(fig_num,freq,full,freq_spec,amp_spec,rms)
%  
    tb=sqrt(sqrt(2));
    disp(' ')
%           
    figure(fig_num);
    fig_num=fig_num+1;
    plot(freq,full,'b',freq_spec,amp_spec,'r',...
            freq_spec,2*amp_spec,'k',freq_spec,amp_spec/2,'k');
    legend ('Synthesis','Specification','+/- 3 dB tol');
%   
    fmin=freq_spec(1);
    fmax=max(freq_spec);
    fmax=10^(ceil(log10(fmax)));
    ymax=max(full);
%  
    xlabel(' Frequency (Hz)');
    ylabel(' Velocity ((ft/sec)^2/Hz)'); 
    at = sprintf(' Power Spectral Density  Overall Level = %6.3g ft/sec RMS ',rms);   
    title(at);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log'); 
    grid;
%
    if(ymax< max(tb*amp_spec) )
        ymax= max(tb*amp_spec);
    end
%
    ymax=10^(ceil(+0.1+log10(ymax)));
    ymin = min(amp_spec/tb);
    ymin=10^(floor(-0.1+log10(ymin))); 
%
    axis([fmin,fmax,ymin,ymax]); 
%
end