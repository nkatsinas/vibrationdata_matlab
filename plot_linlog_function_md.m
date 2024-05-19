%
%  plot_linlog_function_md.m  ver 1.1  by Tom Irvine
%
function[fig_num]=plot_linlog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md)
%
f=ppp(:,1);
a=ppp(:,2);
%
figure(fig_num);
fig_num=fig_num+1;
%
plot(f,a)
%
ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
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


xlim([fmin,fmax]); 

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%