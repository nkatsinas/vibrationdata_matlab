%
%  plot_PSD_two_f.m  ver 1.3
%
function[fig_num]=...
         plot_PSD_two_f(fig_num,x_label,y_label,t_string,ppp,qqq,leg_a,leg_b,fmin,fmax,pname,nps)
%
f=ppp(:,1);
a=ppp(:,2);
%
h=figure(fig_num);

fig_num=fig_num+1;
%
plot(ppp(:,1),ppp(:,2),'r',qqq(:,1),qqq(:,2),'b');
%
legend(leg_a,leg_b);
%
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','off');
%
M1=[max(ppp(:,2)) max(qqq(:,2))];
M2=[min(ppp(:,2)) min(qqq(:,2))];
%
max_psd=max(M1);
min_psd=min(M2);
%
ymax= 10^ceil(log10(max_psd));
ymin=10^floor(log10(min_psd));
%

md=4;

if(ymin<ymax/10^md)
    ymin=ymax/10^md;
end

if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end    

% fprintf('\n ymin=%8.4g  ymax=%8.4g \n',ymin,ymax);

ylim([ymin,ymax]);

[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end

xlim([fmin fmax]);

%
ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%


%


if(nps==1)
    set(gca,'Fontsize',12);
    print(h,pname,'-dpng','-r300');    
    disp(' ');
    disp(' Plot file exported to hard drive as: ');
    out1=sprintf(' %s.png',pname);
    disp(out1);
end    
