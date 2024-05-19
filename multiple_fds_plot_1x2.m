%  multiple_fds_plot_1x2.m  ver 1.2  by Tom Irvine

function[fig_num]=multiple_fds_plot_1x2(fig_num,fds,fmin,fmax,Q,bex)

    
fn=fds(:,1);

NQ=length(Q);
Nb=length(bex);



[xtt,xTT,iflag]=xtick_label(fmin,fmax);



hp=figure(fig_num);
fig_num=fig_num+1;
subplot(1,2,1);
%        
damage=fds(:,2);
y_label=sprintf('Damage log10(G^%g)',bex(1));
t_string=sprintf('FDS Acceleration Q=%g b=%g',Q(1),bex(1));
plot(fn,log10(damage));
title(t_string);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);

set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','odamage','YminorTick','odamage');
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


ymax=max(log10(damage));
ymin=min(log10(damage));
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);



%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(1,2,2);
%        
damage=fds(:,3);

if(NQ<Nb)
    m=1;
    n=2;
else
    m=2;
    n=1;    
end

y_label=sprintf('Damage log10(G^%g)',bex(n));
t_string=sprintf('FDS Acceleration  Q=%g b=%g',Q(m),bex(n));
plot(fn,log10(damage));
title(t_string);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','odamage','YminorTick','odamage');
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
 

ymax=max(log10(damage));
ymin=min(log10(damage));
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);

%

%
set(hp, 'Position', [0 0 950 350]);
%        