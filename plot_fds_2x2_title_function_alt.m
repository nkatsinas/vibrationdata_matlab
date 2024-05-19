%  plot_fds_2x2_title_function.m  ver 1.2  by Tom Irvine
%
%  This script plots four fatigue damage spectra
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%     fig_num = figure number
%      
%         ppp = fatigue damage spectrum - natural freq (Hz) & damage
%     x_label = x-axis label
%   fmin,fmax = minimum & maximum plot frequencies
%
%     nmetric = 1 for acceleration (G)
%             = 2 for pseudo velocity (in/sec)
%             = 3 for transmitted pressure (psi)
%             = 4 for relative displacement
%
%           Q = amplification factor with two values
%         bex = fatigue exponent with two values 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variables
%
%      fig_num = figure number plus 1
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions
%
%      xtick_label.m
%      ytick_linear_min_max_alt.m
%      fds_ylabel_apvtp.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[fig_num,hp]=plot_fds_2x2_title_function_alt(fig_num,x_label,fds,fmin,fmax,nmetric,Q,bex,FS,iu)

[xtt,xTT,iflag]=xtick_label(fmin,fmax);


hp=figure(fig_num);
fig_num=fig_num+1;
subplot(2,2,1);
%        
fn=fds(:,1);
damage=fds(:,2);

m=1;
n=1;

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

set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

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
 
subplot(2,2,2);
%        

m=1;
n=2;
damage=fds(:,3);

plot(fn,log10(damage));

xlabel(x_label);
[y_label,t_string]=fds_ylabel_apvtp(Q(m),bex(n),nmetric,iu);
t_string=strrep(t_string,'Fatigue Damage Spectra','FDS');
t_string=strrep(t_string,'Acceleration','Accel');
t_string=sprintf('%s  %s',t_string,FS);
y_label=strrep(y_label,'(','log10(');
title(t_string);
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,3);
%        
m=2;
n=1;

damage=fds(:,4);

plot(fn,log10(damage));

xlabel(x_label);
[y_label,t_string]=fds_ylabel_apvtp(Q(m),bex(n),nmetric,iu);
t_string=strrep(t_string,'Fatigue Damage Spectra','FDS');
t_string=strrep(t_string,'Acceleration','Accel');
t_string=sprintf('%s  %s',t_string,FS);
y_label=strrep(y_label,'(','log10(');
title(t_string);
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%
%


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



%%% out1=sprintf(' jflag=%d  ymin=%8.4g  ymax=%8.4g ',jflag,ymin,ymax);
%%% disp(out1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,4);
%        
damage=fds(:,5);
m=2;
n=2;

plot(fn,log10(damage));
xlabel(x_label);
[y_label,t_string]=fds_ylabel_apvtp(Q(m),bex(n),nmetric,iu);
t_string=strrep(t_string,'Fatigue Damage Spectra','FDS');
t_string=strrep(t_string,'Acceleration','Accel');
t_string=sprintf('%s  %s',t_string,FS);
y_label=strrep(y_label,'(','log10(');
title(t_string);
ylabel(y_label);

set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%

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


