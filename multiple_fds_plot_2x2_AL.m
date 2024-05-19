%  multiple_fds_plot_2x2_AL.m  ver 1.2  by Tom Irvine

function[fig_num]=multiple_fds_plot_2x2_AL(fig_num,Q,bex,fn,damage,leg)

%
fmin=min(fn);
fmax=max(fn);

[xtt,xTT,iflag]=xtick_label(fmin,fmax);



hp=figure(fig_num);
fig_num=fig_num+1;
subplot(2,2,1);
%        
ff=damage(:,1);
m=1;
n=1;
y_label=sprintf('Damage log10(G^%g)',bex(n));
t_string=sprintf('FDS Accel %s Q=%g b=%g',leg,Q(m),bex(n));
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
 
subplot(2,2,2);
%        
ff=damage(:,2);
m=1;
n=2;
y_label=sprintf('Damage log10(G^%g)',bex(n));
t_string=sprintf('FDS Accel %s Q=%g b=%g',leg,Q(m),bex(n));
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,3);
%        
ff=damage(:,3);
m=2;
n=1;
y_label=sprintf('Damage log10(G^%g)',bex(n));
t_string=sprintf('FDS Accel %s Q=%g b=%g',leg,Q(m),bex(n));
plot(fn,log10(ff));
title(t_string)
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%
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



%%% out1=sprintf(' jflag=%d  ymin=%8.4g  ymax=%8.4g ',jflag,ymin,ymax);
%%% disp(out1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,4);
%        
ff=damage(:,4);
m=2;
n=2;
y_label=sprintf('Damage log10(G^%g)',bex(n));
t_string=sprintf('FDS Accel %s Q=%g b=%g',leg,Q(m),bex(n));
plot(fn,log10(ff));
title(t_string)

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
set(hp, 'Position', [0 0 950 650]);
%    
  


