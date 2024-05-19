%

%  env_fds_batch_plots.m  ver 1.0  by Tom Irvine


function[fig_num,fds1,fds2]=...
    env_fds_batch_plots(iu,grms,T_out,fig_num,damp,bex,bbex,n_ref,xfds,fds_ref,...
                        fn,nmetric,power_spectral_density,fmin,fmax,Q,QQ)


if(iu<=2)
    ylab='Accel (G^2/Hz)';
    t_string=...
    sprintf(' Power Spectral Density  Overall Level=%6.3g GRMS \n Duration=%g sec',grms,T_out);     
else
    ylab='Accel ((m/sec^2)^2/Hz)';    
    t_string=...
    sprintf(' Power Spectral Density  Overall Level=%6.3g (m/sec^2)RMS \n Duration=%g sec',grms,T_out);     
end    
x_label=sprintf(' Frequency (Hz)');
[fig_num]=plot_PSD_function(fig_num,x_label,ylab,t_string,power_spectral_density,fmin,fmax);
%
%
x_label=sprintf(' Natural Frequency (Hz)');
%%%  ylab='Damage Index';
%
disp(' ');
disp(' FDS output arrays: ');
disp('   ');
%


for i=1:length(unique(damp))
    for j=1:length(unique(bex))
        
%
        xx=zeros(n_ref,1);
        ff=zeros(n_ref,1);
%        
        for k=1:n_ref
            xx(k)=xfds(i,j,k);
            ff(k)=fds_ref(i,j,k);
        end
%
        xx=fix_size(xx);
        ff=fix_size(ff);
        fn=fix_size(fn);
%
        fds1=[fn xx];
        fds2=[fn ff];
%
%%%%%%%%%%%
%
        sbex=sprintf('%g',bbex(j));
        sbex=strrep(sbex, '.', 'p');
        output_name=sprintf('psd_fds_Q%g_b%s',QQ(i),sbex);
        output_name2=sprintf('    %s',output_name);
        disp(output_name2);
        assignin('base', output_name, fds1);       
%
%%%%%%%%%%%
%
        leg_a=sprintf('PSD Envelope');
        leg_b=sprintf('Measured Data');
%
        [fig_num]=...
        plot_fds_two_batch(fig_num,x_label,ylab,fds1,fds2,leg_a,leg_b,Q(i),bex(j),iu,nmetric);
%
    end
end    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%



if(length(QQ)==2 && length(bbex)==2)
%
    f=fn;

    if(fmin<1)
        fmin=1;
    end

    [xtt,xTT,iflag]=xtick_label(fmin,fmax);
    
%
    leg_a=sprintf('PSD Envelope');
    leg_b=sprintf('Measured Data');
 
 
    hp=figure(fig_num);
    fig_num=fig_num+1;
    subplot(2,2,1);
%        
    i=1;
    j=1;
        for k=1:n_ref
            xx(k)=xfds(i,j,k);
            ff(k)=fds_ref(i,j,k);
        end
%
    plot(fn,xx,fn,ff)
    M1=[ max(xx) max(ff) ];
    M2=[ min(xx) min(ff) ];
%
    max_psd=max(M1);
    min_psd=min(M2);
%
 
    if(nmetric==1)
        t_string=sprintf('Accel FDS  Q=%g b=%g ',QQ(i),bbex(j));
        if(iu==1)
            y_label=sprintf('Damage (G)^{ %g }',bbex(j));
        else
            y_label=sprintf('Damage (m/sec^2)^{ %g }',bbex(j));        
        end
    end    
    if(nmetric==2)
        t_string=sprintf('PV FDS  Q=%g b=%g ',QQ(i),bbex(j));   
        if(iu==1)
            y_label=sprintf('Damage (ips)^{ %g }',bbex(j));
        else
            y_label=sprintf('Damage (m/sec)^{ %g }',bbex(j));        
        end    
    end    
     if(nmetric==3)
        t_string=sprintf('RD FDS  Q=%g b=%g ',QQ(i),bbex(j));   
        if(iu==1)
            y_label=sprintf('Damage (in)^{ %g }',bbex(j));
        else
            y_label=sprintf('Damage (mm)^{ %g }',bbex(j));        
        end    
    end     
    
    out=sprintf(t_string);
    title(out);
    grid on;
    xlabel(' Natural Frequency (Hz)');
    ylabel(y_label);
%% legend(leg_a,leg_b,1);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','off');
%

    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');
%

    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);
    end   

    xlim([fmin,fmax]);
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    subplot(2,2,2);
%        
    i=1;
    j=2;
        for k=1:n_ref
            xx(k)=xfds(i,j,k);
            ff(k)=fds_ref(i,j,k);
        end
%
    plot(fn,xx,fn,ff)
    M1=[ max(xx) max(ff) ];
    M2=[ min(xx) min(ff) ];
%
    max_psd=max(M1);
    min_psd=min(M2);
%
 
    if(nmetric==1)
        t_string=sprintf('Accel FDS  Q=%g b=%g ',QQ(i),bbex(j));
        if(iu==1)
            y_label=sprintf('Damage (G)^{ %g }',bbex(j));
        else
            y_label=sprintf('Damage (m/sec^2)^{ %g }',bbex(j));        
        end
    end    
    if(nmetric==2)
        t_string=sprintf('PV FDS  Q=%g b=%g ',QQ(i),bbex(j));   
        if(iu==1)
            y_label=sprintf('Damage (ips)^{ %g }',bbex(j));
        else
            y_label=sprintf('Damage (m/sec)^{ %g }',bbex(j));        
        end    
    end    
    if(nmetric==3)
        t_string=sprintf('RD FDS  Q=%g b=%g ',QQ(i),bbex(j));   
        if(iu==1)
            y_label=sprintf('Damage (in)^{ %g }',bbex(j));
        else
            y_label=sprintf('Damage (mm)^{ %g }',bbex(j));        
        end    
    end    
    
    out=sprintf(t_string);
    title(out);
 
    grid on;
    xlabel(' Natural Frequency (Hz)');
    ylabel(y_label);
%% legend(leg_a,leg_b,1);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','off');
%


    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');
%


    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end   

    xlim([fmin,fmax]);

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    subplot(2,2,3);
%        
    i=2;
    j=1;
        for k=1:n_ref
            xx(k)=xfds(i,j,k);
            ff(k)=fds_ref(i,j,k);
        end
%
    plot(fn,xx,fn,ff)
    M1=[ max(xx) max(ff) ];
    M2=[ min(xx) min(ff) ];
%
    max_psd=max(M1);
    min_psd=min(M2);
%
 
    if(nmetric==1)
        t_string=sprintf('Accel FDS  Q=%g b=%g ',QQ(i),bbex(j));
        if(iu==1)
            y_label=sprintf('Damage (G)^{ %g }',bbex(j));
        else
            y_label=sprintf('Damage (m/sec^2)^{ %g }',bbex(j));        
        end
    end
    if(nmetric==2)
        t_string=sprintf('PV FDS  Q=%g b=%g ',QQ(i),bbex(j));   
        if(iu==1)
            y_label=sprintf('Damage (ips)^{ %g }',bbex(j));
        else
            y_label=sprintf('Damage (m/sec)^{ %g }',bbex(j));        
        end    
    end    
    if(nmetric==3)
        t_string=sprintf('RD FDS  Q=%g b=%g ',QQ(i),bbex(j));   
        if(iu==1)
            y_label=sprintf('Damage (ips)^{ %g }',bbex(j));
        else
            y_label=sprintf('Damage (m/sec)^{ %g }',bbex(j));        
        end         
    end
    out=sprintf(t_string);
    title(out);
    grid on;
    xlabel(' Natural Frequency (Hz)');
    ylabel(y_label);
%% legend(leg_a,leg_b,1);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','off');
%

%
%


    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');
%

    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end   

    xlim([fmin,fmax]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    subplot(2,2,4);
%        
    i=2;
    j=2;
        for k=1:n_ref
            xx(k)=xfds(i,j,k);
            ff(k)=fds_ref(i,j,k);
        end
%
    plot(fn,xx,fn,ff)
    M1=[ max(xx) max(ff) ];
    M2=[ min(xx) min(ff) ];
%
    max_psd=max(M1);
    min_psd=min(M2);
%
 
    if(nmetric==1)
        t_string=sprintf('Accel FDS  Q=%g b=%g ',QQ(i),bbex(j));
        if(iu==1)
            y_label=sprintf('Damage (G)^{ %g }',bbex(j));
        else
            y_label=sprintf('Damage (m/sec^2)^{ %g }',bbex(j));        
        end
    end
    if(nmetric==2)
        t_string=sprintf('PV FDS  Q=%g b=%g ',QQ(i),bbex(j));   
        if(iu==1)
            y_label=sprintf('Damage (ips)^{ %g }',bbex(j));
        else
            y_label=sprintf('Damage (m/sec)^{ %g }',bbex(j));        
        end    
    end   
    if(nmetric==3)
        t_string=sprintf('RD FDS  Q=%g b=%g ',QQ(i),bbex(j));   
        if(iu==1)
            y_label=sprintf('Damage (in)^{ %g }',bbex(j));
        else
            y_label=sprintf('Damage (mm)^{ %g }',bbex(j));        
        end    
    end      
    
    out=sprintf(t_string);
    title(out);
    grid on;
    xlabel(' Natural Frequency (Hz)');
    ylabel(y_label);
%% legend(leg_a,leg_b,1);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','off');
%

    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');


    if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
    end   

    xlim([fmin,fmax]);
%
    set(hp, 'Position', [0 0 1200 800]);
%    
end    
%