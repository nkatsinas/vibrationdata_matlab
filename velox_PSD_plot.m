%
%  velox_PSD_plot.m  ver 1.1  November 15, 2012
%
function[fig_num]=velox_PSD_plot(fig_num,a,vrms,t_string)
%
figure(fig_num);
fig_num=fig_num+1;
%
plot(a(:,1),a(:,2));
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
grid;
%
xlabel(' Frequency (Hz)');
ylabel(' Velocity ((ft/sec)^2/Hz)'); 
%
at = sprintf('%s  Overall Level = %6.3g ft/sec RMS',t_string,vrms);   
title(at);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log'); 
%
ymax=max(a(:,2));
ymin=min(a(:,2)); 
%
ymax=10^(ceil(+0.1+log10(ymax))); 
ymin=10^(floor(-0.1+log10(ymin)));
% 
fmax=max(a(:,1));
fmin=a(1,1);
%
if(fmin==10 && fmax==2000)
        set(gca, 'XTickMode', 'manual');
        set(gca,'xtick',[10 100 1000 2000]);   
        axis([fmin,fmax,ymin,ymax]); 
end
%
if(fmin==20 && fmax==2000)
        set(gca, 'XTickMode', 'manual');
        set(gca,'xtick',[20 100 1000 2000]); 
        axis([fmin,fmax,ymin,ymax]); 
end 
%