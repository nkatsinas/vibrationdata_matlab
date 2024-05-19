  
%  fds_plot_2x2_alt_leg_h2.m  ver 1.1  by Tom Irvine

function[fig_num,h2]=fds_plot_2x2_alt_leg_h2(fig_num,Q,bex,fn,ff,xx,xfds,fds_ref,nmetric,iu)


fsize=11.5;

%
leg_a=sprintf('Ajusted PSD');
leg_b=sprintf('Input PSD');

n_ref=length(fn);


fmin=min(fn);
fmax=max(fn);

[xtt,xTT,iflag]=xtick_label(fmin,fmax);



h2=figure(fig_num);
fig_num=fig_num+1;
subplot(2,2,1);
%        
i=1;
xx=xfds(:,i);
ff=fds_ref(:,i);
plot(fn,log10(xx),fn,log10(ff))
[y_label,t_string]=fds_ylabel(Q(i),bex(i),nmetric,iu);
y_label=strrep(y_label,'(','log10(');

out=sprintf(t_string);
title(out);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
%% legend(leg_a,leg_b);
legend(leg_a,leg_b);
legend('Orientation','horizontal')

set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
set(gca,'Fontsize',fsize);  
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax])

ymax=max([ max(log10(xx)) max(log10(ff))  ]);
ymin=min([ min(log10(xx)) min(log10(ff))  ]);
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,2);
%        
i=2;
xx=xfds(:,i);
ff=fds_ref(:,i);
plot(fn,log10(xx),fn,log10(ff))
[y_label,t_string]=fds_ylabel(Q(i),bex(i),nmetric,iu);
y_label=strrep(y_label,'(','log10(');
%

out=sprintf(t_string);
title(out);

grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
%% legend(leg_a,leg_b);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
set(gca,'Fontsize',fsize);  
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax]);    

ymax=max([ max(log10(xx)) max(log10(ff))  ]);
ymin=min([ min(log10(xx)) min(log10(ff))  ]);
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,3);
%        
i=3;
xx=xfds(:,i);
ff=fds_ref(:,i);
plot(fn,log10(xx),fn,log10(ff))
[y_label,t_string]=fds_ylabel(Q(i),bex(i),nmetric,iu);
y_label=strrep(y_label,'(','log10(');

out=sprintf(t_string);
title(out);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
%% legend(leg_a,leg_b);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%
%


set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
set(gca,'Fontsize',fsize);  
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  
xlim([fmin,fmax]); 

ymax=max([ max(log10(xx)) max(log10(ff))  ]);
ymin=min([ min(log10(xx)) min(log10(ff))  ]);
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,4);
%        
i=4;
xx=xfds(:,i);
ff=fds_ref(:,i);
plot(fn,log10(xx),fn,log10(ff))
[y_label,t_string]=fds_ylabel(Q(i),bex(i),nmetric,iu);
y_label=strrep(y_label,'(','log10(');
%

out=sprintf(t_string);
title(out);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
%% legend(leg_a,leg_b);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
set(gca,'Fontsize',fsize);  
%
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end  

xlim([fmin,fmax]); 

ymax=max([ max(log10(xx)) max(log10(ff))  ]);
ymin=min([ min(log10(xx)) min(log10(ff))  ]);
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
%




set(h2, 'Position', [0 0 1000 650]);
%    
  