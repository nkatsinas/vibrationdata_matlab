%
%  plot_PSD_two_h2_flimits_md.m  ver 1.2   by Tom Irvine
%
function[fig_num,h2]=...
         plot_PSD_two_h2_flimits_md(fig_num,x_label,y_label,t_string,ppp,qqq,leg_a,leg_b,fmin,fmax,md)
%
h2=figure(fig_num);
fig_num=fig_num+1;
%
plot(ppp(:,1),ppp(:,2),qqq(:,1),qqq(:,2));
%
legend(leg_a,leg_b);
%
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','off');
%
%
if(fmin<1)
    fmin=1;
end
%
M1=[ max(ppp(:,2)) max(qqq(:,2)) ];
M2=[ min(ppp(:,2)) min(qqq(:,2)) ];
%
ymax=max(M1);
ymin=min(M2);
%
 
xlabel(x_label);
ylabel(y_label);
out=sprintf(t_string);
title(out);
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
    xlim([fmin,fmax]);    
end   

ymax=10^(ceil(log10(1.2*ymax)));
ymin=10^(floor(log10(ymin)));

if(ymin<ymax/10^md)
    ymin=ymax/10^md;
end

if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end    

ylim([ymin,ymax]);


%