%
%  plot_frf_md_H1_H2_two.m  ver 1.2  by Tom Irvine
%
function[fig_num]=plot_frf_md_H1_H2_two(fig_num,freq,H1,H2,fmin,fmax,t_string,y_label,md)

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

sz=max(size(freq));

f1=fmin;
f2=fmax;

n=sz(1);
ff=freq;
frf_m1=abs(H1);
frf_p1=angle(H1)*180/pi;

frf_m2=abs(H2);
frf_p2=angle(H2)*180/pi;

%
hp=figure(fig_num);
fig_num=fig_num+1;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(3,2,1);
plot(ff,frf_p1(:,1),ff,frf_p2(:,1));
t_string1=sprintf('%s',t_string);
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
%
ylim([-180,180]);


subplot(3,2,2);
plot(ff,frf_p1(:,2),ff,frf_p2(:,2));
t_string1=sprintf('%s',t_string);
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
%
ylim([-180,180]);

%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(3,2,[3 5]);
plot(ff,frf_m1(:,1),ff,frf_m2(:,1));
xlim([f1 f2]); 
grid on;
xlabel('Frequency (Hz)');
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','log');
legend('H1','H2');
legend show;


[~,ii]=min(abs(ff-fmin));
[~,jj]=min(abs(ff-fmax));

     
a=frf_m1(ii:jj);
b=frf_m2(ii:jj);

maxa=max(max([a b]));
mina=min(min([a b]));

ymax= 10^ceil(log10(maxa));
ymin= 10^floor(log10(mina));

if(ymin<ymax/10^md)
    ymin=ymax/10^md;
end

if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end    

try
    ylim([ymin,ymax]);
catch
    ymin
    ymax
end

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end
xlim([fmin fmax]);

subplot(3,2,[4 6]);
plot(ff,frf_m1(:,2),ff,frf_m2(:,2));
xlim([f1 f2]); 
grid on;
xlabel('Frequency (Hz)');
ylabel(y_label);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
         'YScale','log');
legend('H1','H2');
legend show;


[~,ii]=min(abs(ff-fmin));
[~,jj]=min(abs(ff-fmax));

     
a=frf_m1(ii:jj);
b=frf_m2(ii:jj);

maxa=max(max([a b]));
mina=min(min([a b]));

ymax= 10^ceil(log10(maxa));
ymin= 10^floor(log10(mina));

if(ymin<ymax/10^md)
    ymin=ymax/10^md;
end

if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end

try
    ylim([ymin,ymax]);
catch
    ymin
    ymax
end

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end
xlim([fmin fmax]);



set(hp, 'Position', [0 0 1100 550]);