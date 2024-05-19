%
%  plot_loglog_function_md_bar.m  ver 1.1  by Tom Irvine
%
function[fig_num]=...
    plot_loglog_function_md_bar(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md)
%
f=ppp(:,1);
a=ppp(:,2);
%
figure(fig_num);
fig_num=fig_num+1;
%
bar(f,a,'b')
%
ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ymax= 10^ceil(log10(max(a)));
%
ymin= 10^floor(log10(min(a)));

if(ymin<ymax/10^md)
    ymin=ymax/10^md;
end

if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end    

ylim([ymin,ymax]); 
%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
    xlim([fmin,fmax]);    
end   

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%