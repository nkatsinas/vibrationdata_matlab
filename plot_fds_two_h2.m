%
%  plot_fds_two_h2.m  ver 1.3  by Tom Irvine
%
function[fig_num,h2]=...
         plot_fds_two_h2(fig_num,x_label,y_label,ppp,qqq,leg_a,leg_b,Q,bex,iu,nmetric)
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
fmax=max(f);
fmin=min(f);


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
ymax=max([ max(log10(xx)) max(log10(ff))  ]);
ymin=min([ min(log10(xx)) min(log10(ff))  ]);
[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);

%

[y_label,t_string]=fds_ylabel_apvtp(Q,bex,nmetric,iu);
y_label=strrep(y_label,'(','log10(');


out=sprintf(t_string);
title(out);

ylabel(y_label);   
xlabel(x_label);

%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%


%