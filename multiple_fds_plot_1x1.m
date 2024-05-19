  
%  multiple_fds_plot_1x1.m  ver 1.0  by Tom Irvine

function[fig_num]=multiple_fds_plot_1x1(fig_num,Q,bex,fn,fds,leg)

%
fmin=min(fn);
fmax=max(fn);

[xtt,xTT,iflag]=xtick_label(fmin,fmax);


hp=figure(fig_num);
fig_num=fig_num+1;
%        
ff=fds(:,1);

y_label=sprintf('Damage log10(G^%g)',bex);
t_string=sprintf('FDS %s Q=%g b=%g',leg,Q,bex);
plot(fn,log10(ff));
title(t_string);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);

set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
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
xlim([fmin,fmax])


ymax=max(log10(ff));
ymin=min(log10(ff));
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);
%
