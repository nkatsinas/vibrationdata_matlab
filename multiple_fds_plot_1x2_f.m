
%  multiple_fds_plot_1x2_f.m  ver 1.2  by Tom Irvine

function[fig_num]=multiple_fds_plot_1x2_f(fig_num,Q,bex,fn,fds)
    
NQ=length(Q);
Nb=length(bex);

%
fmin=min(fn);
fmax=max(fn);

[xtt,xTT,iflag]=xtick_label_f(fmin,fmax);


hp=figure(fig_num);
fig_num=fig_num+1;
subplot(1,2,1);
%        
ff=fds(:,1);
y_label=sprintf('Damage log10(G^%g)',bex(1));
t_string=sprintf('FDS Acceleration Q=%g b=%g',Q(1),bex(1));
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(1,2,2);
%        
ff=fds(:,2);

if(NQ<Nb)
    m=1;
    n=2;
else
    m=2;
    n=1;    
end

y_label=sprintf('Damage log10(G^%g)',bex(n));
t_string=sprintf('FDS Acceleration  Q=%g b=%g',Q(m),bex(n));
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
xlim([fmin,fmax]);    
 

ymax=max(log10(ff));
ymin=min(log10(ff));
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);

%

%
set(hp, 'Position', [0 0 950 350]);
%        