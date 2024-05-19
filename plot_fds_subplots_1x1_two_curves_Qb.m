
function[fig_num]=plot_fds_subplots_1x1_two_curves_Qb(fig_num,FS11,FS21,xmin,xmax,Q,b)

    fsize=10;

    FS11(:,2)=log10(FS11(:,2));
 
    FS21(:,2)=log10(FS21(:,2));
 
  ny_limits=1;  
  nx_type=2;  
  
  sxlabel='Natural Frequency (Hz)';

t_string_1=sprintf('FDS Q=%g b=%g',Q(1),b(1));

sylabel_1=sprintf('Damage log10(G^%g)',b(1));


legend_1='Ref';
legend_2='Synth';
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hp=figure(fig_num);
fig_num=fig_num+1;


plot(FS11(:,1),FS11(:,2),FS21(:,1),FS21(:,2));
legend(legend_1,legend_2,'location','northwest');
grid on;

xlabel(sxlabel);
ylabel(sylabel_1);
title(t_string_1);
if(ny_limits==2)
     ylim([ymin_1,ymax_1]);
else
    ymax=max([ max(FS11(:,2))  max(FS21(:,2))]);
    ymin=min([ min(FS11(:,2))  min(FS21(:,2))]);

    [ytt,yTT]=ytick_linear_min_max_alt(1.1*ymax,ymin);
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end


set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

grid on;   

pname='a.emf';
print(hp,pname,'-dmeta','-r300'); 

msgbox('Plot file:  a.emf');
