
function[fig_num]=plot_fds_subplots_2x2_two_curves_Qb(fig_num,FS11,FS12,FS13,FS14,FS21,FS22,FS23,FS24,xmin,xmax,Q,b)

    fsize=10;

    FS11(:,2)=log10(FS11(:,2));
    FS12(:,2)=log10(FS12(:,2));
    FS13(:,2)=log10(FS13(:,2));
    FS14(:,2)=log10(FS14(:,2));    
    
    FS21(:,2)=log10(FS21(:,2));
    FS22(:,2)=log10(FS22(:,2));
    FS23(:,2)=log10(FS23(:,2));
    FS24(:,2)=log10(FS24(:,2)); 

  ny_limits=1;  
  nx_type=2;  
  
  sxlabel='Natural Frequency (Hz)';

t_string_1=sprintf('FDS Q=%g b=%g',Q(1),b(1));
t_string_2=sprintf('FDS Q=%g b=%g',Q(2),b(2));
t_string_3=sprintf('FDS Q=%g b=%g',Q(3),b(3));
t_string_4=sprintf('FDS Q=%g b=%g',Q(4),b(4));

sylabel_1=sprintf('Damage log10(G^%g)',b(1));
sylabel_2=sprintf('Damage log10(G^%g)',b(2));    
sylabel_3=sprintf('Damage log10(G^%g)',b(3));
sylabel_4=sprintf('Damage log10(G^%g)',b(4));

legend_1='Ref';
legend_2='Synth';
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


hp=figure(fig_num);
fig_num=fig_num+1;


subplot(2,2,1);
plot(FS11(:,1),FS11(:,2),FS21(:,1),FS21(:,2));
legend(legend_1,legend_2,'location','northwest');
grid on;
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

%
subplot(2,2,2);
plot(FS12(:,1),FS12(:,2),FS22(:,1),FS22(:,2));
legend(legend_1,legend_2,'location','northwest');
grid on;
title(t_string_2);
ylabel(sylabel_2);

if(ny_limits==2)
     ylim([ymin_2,ymax_2]);
else
    ymax=max([ max(FS12(:,2))  max(FS22(:,2))]);
    ymin=min([ min(FS12(:,2))  min(FS22(:,2))]);

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

subplot(2,2,3);
plot(FS13(:,1),FS13(:,2),FS23(:,1),FS23(:,2));
legend(legend_1,legend_2,'location','northwest');
grid on;
title(t_string_3);
xlabel(sxlabel);
ylabel(sylabel_3);

if(ny_limits==2)
     ylim([ymin_3,ymax_3]);
else
    ymax=max([ max(FS13(:,2))  max(FS23(:,2))]);
    ymin=min([ min(FS13(:,2))  min(FS23(:,2))]);

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

subplot(2,2,4);
plot(FS14(:,1),FS14(:,2),FS24(:,1),FS24(:,2));
legend(legend_1,legend_2,'location','northwest');
grid on;
title(t_string_4);
xlabel(sxlabel);
ylabel(sylabel_4);

if(ny_limits==2)
     ylim([ymin_4,ymax_4]);
else
    ymax=max([ max(FS14(:,2))  max(FS24(:,2))]);
    ymin=min([ min(FS14(:,2))  min(FS24(:,2))]);

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

%
xlabel(sxlabel);

%
grid on;   


 
set(hp, 'Position', [0 0 900 700]);


pname='a.emf';
print(hp,pname,'-dmeta','-r300'); 

msgbox('Plot file:  a.emf');
