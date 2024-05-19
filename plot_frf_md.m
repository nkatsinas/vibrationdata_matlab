%
%  plot_frf_md.m  ver 1.2  by Tom Irvine
%
function[fig_num]=plot_frf_md(fig_num,freq,H,fmin,fmax,t_string,y_label,md)

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

sz=max(size(freq));

f1=fmin;
f2=fmax;

n=sz(1);
ff=freq;
frf_m=abs(H);
frf_p=angle(H)*180/pi;

%
hp=figure(fig_num);
fig_num=fig_num+1;
%
subplot(3,1,1);
plot(ff,frf_p);
title(t_string);
grid on;
ylabel('Phase (deg)');
ylim([-180,180]);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end
xlim([fmin fmax]);

set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-180,-90,0,90,180]);
%
if(max(frf_p)<=0.)
%
ylim([-180,0]);
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end
xlim([fmin fmax]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-180,-90,0]);
end  
%
if(min(frf_p)>=-90. && max(frf_p)<90.)
%
ylim([-90,90]);
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end
xlim([fmin fmax]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-90,0,90]);
end 
%
if(min(frf_p)>=0.)
%
ylim([0,180]);
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end
xlim([fmin fmax]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[0,90,180]);
end 
%
subplot(3,1,[2 3]);
plot(ff,frf_m);
xlim([f1 f2]); 
grid on;
xlabel('Frequency (Hz)');
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','log');
     
[~,ii]=min(abs(ff-fmin));
[~,jj]=min(abs(ff-fmax));
     
a=frf_m(ii:jj);

ymax= 10^ceil(log10(max(a)));
ymin= 10^floor(log10(min(a)));

if(ymin<ymax/10^md)
    ymin=ymax/10^md;
end

if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end    

ylim([ymin,ymax]);
if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end
xlim([fmin fmax]);

set(hp, 'Position', [0 0 600 550]);