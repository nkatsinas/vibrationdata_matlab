%
%  plot_loglog_function_md_three_fds_h2.m  ver 1.5   by Tom Irvine
%
function[fig_num,h2]=plot_loglog_function_md_three_fds_h2(fig_num,x_label,...
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
plot(fa,log10(a),'b',fb,log10(b),'r',fc,log10(c),'k');
%
legend(leg1,leg2,leg3);

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

max_amp=max([ max(a) max(b) max(c) ]);
min_amp=min([ min(a) min(b) min(c) ]);

ymax=log10(max_amp);
ymin=log10(min_amp);


[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);


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
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
try
    xlim([fmin,fmax]);
catch
end    