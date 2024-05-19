%
%  plot_fds_two_alt_h2.m  ver 1.2  by Tom Irvine
%
function[fig_num,h2]=...
         plot_fds_two_alt_h2(fig_num,x_label,y_label,ppp,qqq,leg_a,leg_b,tstring,fmin,fmax)
%
f=ppp(:,1);
a=ppp(:,2);
%
h2=figure(fig_num);
fig_num=fig_num+1;
%
plot(ppp(:,1),log10(ppp(:,2)),qqq(:,1),log10(qqq(:,2)));
%
legend(leg_a,leg_b);
%
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin','XminorTick','off','YminorTick','off');
%


if(fmin<1)
        fmin=1;
end

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);
end   

%
xlim([fmin,fmax]);



xx=ppp(:,2);
ff=qqq(:,2);

[~,x1]=min(abs(ppp(:,1)-fmin));
[~,x2]=min(abs(ppp(:,1)-fmax));

[~,f1]=min(abs(qqq(:,1)-fmin));
[~,f2]=min(abs(qqq(:,1)-fmax));

ymax=max([ max(log10(xx(x1:x2))) max(log10(ff(f1:f2)))  ]);
ymin=min([ min(log10(xx(x1:x2))) min(log10(ff(f1:f2)))  ]);
[ytt,yTT]=ytick_linear_min_max_alt(1.1*ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);

title(tstring);

ylabel(y_label);   
xlabel(x_label);

%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%


%