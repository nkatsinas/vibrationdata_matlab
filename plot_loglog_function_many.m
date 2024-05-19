
%  plot_loglog_function_many.m  ver 1.0  by Tom Irvine

function[fig_num,h2]=plot_loglog_function_many(fig_num,x_label,...
               y_label,t_string,THM,leg,fmin,fmax,md)
%
sz=size(THM);
num=sz(2)-1;
%
h2=figure(fig_num);
fig_num=fig_num+1;
hold on;
%

for i=1:num
    plot(THM(:,1),THM(:,i+1));
end

hold off;

legend(leg1,leg2,leg3,leg4);   

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

max_amp=max( THM(:,2:num+1) );
min_amp=min( THM(:,2:num+1) );

[ymax,ymin]=ymax_ymin_md(max_amp,min_amp,md);

%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end

%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
%
axis([fmin,fmax,ymin,ymax]);
