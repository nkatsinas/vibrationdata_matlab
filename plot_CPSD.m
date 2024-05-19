
%
%  plot_CPSD.m  ver 1.0  by Tom Irvine
%

function[fig_num]=plot_CPSD(fig_num,t_string,ff,CPSD_mag,CPSD_phase,COH,fmin,fmax,yout)

    figure(fig_num);
    fig_num=fig_num+1;
%
    subplot(3,1,1);
    plot(ff,CPSD_phase);
    title(t_string);
    grid on;
    ylabel('Phase (deg)');
    axis([fmin,fmax,-180,180]);
    
    [xtt,xTT,iflag]=xtick_label(fmin,fmax);
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);    
    end  
    xlim([fmin,fmax]);
    
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','ytick',[-180,-90,0,90,180]);
%
    subplot(3,1,[2 3]);
    plot(ff,CPSD_mag);
    grid on;
    xlabel('Frequency(Hz)');
    ylabel(yout);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','log');
%
    [~,ii]=min(abs(ff-fmin));
    [~,jj]=min(abs(ff-fmax));

    ymax=10^(ceil(log10(max(CPSD_mag(ii:jj)))));
    ymin=10^(floor(log10(min(CPSD_mag(ii:jj)))));
%
    if(ymin<ymax/10000)
        ymin=ymax/10000;
    end
%
    axis([fmin,fmax,ymin,ymax]);    

    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);    
    end  
    xlim([fmin,fmax]);    
    
%
    figure(fig_num);
    fig_num=fig_num+1;
    
    plot(ff,COH);
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','lin');
    xlabel('Frequency(Hz)'); 
    ylabel('(\gamma_x_y)^2'); 
    title('Coherence');   
    ymin=0.;
    ymax=1.;
    axis([fmin,fmax,ymin,ymax]);
    
    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);    
    end  
    xlim([fmin,fmax]);    
%