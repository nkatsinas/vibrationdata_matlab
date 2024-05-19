%  plot_fds_1x2_title_function.m  ver 1.2  by Tom Irvine

function[fig_num]=plot_fds_1x2_title_function(fig_num,x_label,fds,fmin,fmax,nmetric,Q,bex,FS)

iu=1;

fn=fds(:,1);

NQ=length(Q);
Nb=length(bex);


[xtt,xTT,iflag]=xtick_label(fmin,fmax);

hp=figure(fig_num);
fig_num=fig_num+1;
subplot(1,2,1);
%        
damage=fds(:,2);

plot(fn,log10(damage));

grid on;
xlabel(x_label);

[y_label,t_string]=fds_ylabel_apvtp(Q(1),bex(1),nmetric,iu);
t_string=strrep(t_string,'Fatigue Damage Spectra','FDS');
t_string=strrep(t_string,'Acceleration','Accel');
t_string=sprintf('%s  %s',t_string,FS);
y_label=strrep(y_label,'(','log10(');
ylabel(y_label);
title(t_string);

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');

set(gca,'XGrid','on','GridLineStyle','-');
set(gca,'YGrid','on','GridLineStyle','-');
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

plot(fn,log10(damage));

grid on;
xlabel(x_label);

[y_label,t_string]=fds_ylabel_apvtp(Q(m),bex(n),nmetric,iu);
t_string=strrep(t_string,'Fatigue Damage Spectra','FDS');
t_string=strrep(t_string,'Acceleration','Accel');
t_string=sprintf('%s  %s',t_string,FS);
y_label=strrep(y_label,'(','log10(');
ylabel(y_label);
title(t_string);

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');

set(gca,'XGrid','on','GridLineStyle','-');
set(gca,'YGrid','on','GridLineStyle','-');
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
set(hp, 'Position', [0 0 1000 450]);
%        