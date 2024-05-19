%
%  plot_loglog_function_md_three_h2xxx.m  ver 1.5   by Tom Irvine
%
function[fig_num,h2]=plot_loglog_function_md_three_h2xxx(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md)
%

leg1=strrep(leg1,'_',' ');
leg2=strrep(leg2,'_',' ');
leg3=strrep(leg3,'_',' ');

fa=ppp1(:,1);
fb=ppp2(:,1);
fc=ppp3(:,1);

f=fb;

a=ppp1(:,2);
b=ppp2(:,2);
c=ppp3(:,2);
%
h2=figure(fig_num);
fig_num=fig_num+1;
%
plot(fa,a,'b',fb,b,'r',fc,c,'k');
%
legend(leg1,leg2,leg3);

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

max_amp=max([ max(a) max(b) max(c) ]);
min_amp=min([ min(a) min(b) min(c) ]);

[ymax,ymin]=ymax_ymin_md(max_amp,min_amp,md);

%%%

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
try
    axis([fmin,fmax,ymin,ymax]);
catch
end    