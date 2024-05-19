%
%  plot_frf_md_two_two_titles.m  ver 1.2  by Tom Irvine
%
function[fig_num]=plot_frf_md_two_two_titles(fig_num,freq,frf,ofrf,fmin,fmax,t_string1,t_string2,y_label,md)

if(isempty(md) || isnan(md))
    md=5;
end

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

sz=max(size(freq));

f1=fmin;
f2=fmax;

n=sz(1);
ff=freq;
frf_m1=abs(frf);
frf_p1=angle(frf)*180/pi;
frf_p=frf_p1;
frf_m=frf_m1;

frf_m2=abs(ofrf);
frf_p2=angle(ofrf)*180/pi;

%
hp=figure(fig_num);
fig_num=fig_num+1;
%
subplot(3,2,1);
plot(ff,frf_p1(:,1),ff,frf_p2(:,1));
title(t_string1);
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
ylim([-180,180]);                

%
subplot(3,2,[3 5]);
plot(ff,frf_m1(:,1),ff,frf_m2(:,1));
legend('Measured','Curve Fit');
legend show;
xlim([f1 f2]); 
grid on;
xlabel('Frequency (Hz)');
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','log');
     
[~,ii]=min(abs(ff-fmin));
[~,jj]=min(abs(ff-fmax));
     
a=frf_m(ii:jj,1);

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
subplot(3,2,2);
plot(ff,frf_p1(:,2),ff,frf_p2(:,2));
title(t_string2);
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
ylim([-180,180]);                

%
subplot(3,2,[4 6]);
plot(ff,frf_m1(:,2),ff,frf_m2(:,2));
legend('Measured','Curve Fit');
legend show;
xlim([f1 f2]); 
grid on;
xlabel('Frequency (Hz)');
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','log');
     
[~,ii]=min(abs(ff-fmin));
[~,jj]=min(abs(ff-fmax));
     
a=frf_m(ii:jj,2);

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(hp, 'Position', [0 0 1200 550]);