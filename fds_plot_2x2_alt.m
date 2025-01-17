  
%  fds_plot_2x2_alt.m  ver 1.0  by Tom Irvine

function[fig_num]=fds_plot_2x2_alt(fig_num,Q,bex,fn,ff,xx,xfds,fds_ref,nmetric,iu)

%
leg_a=sprintf('PSD Envelope');
leg_b=sprintf('Measured Data');

n_ref=length(fn);


fmin=min(fn);
fmax=max(fn);

[xtt,xTT,iflag]=xtick_label(fmin,fmax);



hp=figure(fig_num);
fig_num=fig_num+1;
subplot(2,2,1);
%        
i=1;
xx=xfds(:,i);
ff=fds_ref(:,i);
plot(fn,xx,fn,ff)
[y_label,t_string]=fds_ylabel(Q(i),bex(i),nmetric,iu);

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
xlim([fmin,fmax])

%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,2);
%        
i=2;
xx=xfds(:,i);
ff=fds_ref(:,i);
plot(fn,xx,fn,ff)
[y_label,t_string]=fds_ylabel(Q(i),bex(i),nmetric,iu);
%

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
 
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,3);
%        
i=3;
xx=xfds(:,i);
ff=fds_ref(:,i);
plot(fn,xx,fn,ff)
[y_label,t_string]=fds_ylabel(Q(i),bex(i),nmetric,iu);
 

out=sprintf(t_string);
title(out);
grid on;
xlabel(' Natural Frequency (Hz)');
ylabel(y_label);
%% legend(leg_a,leg_b,1);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','off');
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
  
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,4);
%        
i=4;
xx=xfds(:,i);
ff=fds_ref(:,i);
plot(fn,xx,fn,ff)
[y_label,t_string]=fds_ylabel(Q(i),bex(i),nmetric,iu);
%

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

%
set(hp, 'Position', [0 0 950 650]);
%    
  