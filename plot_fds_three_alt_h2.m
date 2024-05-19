%
%  plot_fds_three_alt_h2.m  ver 1.2  by Tom Irvine
%
function[fig_num,h2]=...
         plot_fds_three_alt_h2(fig_num,x_label,y_label,ppp1,ppp2,ppp3,leg_a,leg_b,leg_c,tstring,fmin,fmax)
%
%
h2=figure(fig_num);
fig_num=fig_num+1;
%
plot(ppp1(:,1),log10(ppp1(:,2)),ppp2(:,1),log10(ppp2(:,2)),ppp3(:,1),log10(ppp3(:,2)));
%
legend(leg_a,leg_b,leg_c);
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



xx1=ppp1(:,2);
xx2=ppp2(:,2);
xx3=ppp3(:,2);

[~,i1]=min(abs(ppp1(:,1)-fmin));
[~,i2]=min(abs(ppp2(:,1)-fmin));
[~,i3]=min(abs(ppp3(:,1)-fmin));

[~,j1]=max(abs(ppp1(:,1)-fmin));
[~,j2]=max(abs(ppp2(:,1)-fmax));
[~,j3]=max(abs(ppp3(:,1)-fmax));

ymax=max([ max(log10(xx1(i1:j1))) max(log10(xx2(i2:j2))) max(log10(xx3(i3:j3))) ]);
ymin=min([ min(log10(xx1(i1:j1))) min(log10(xx2(i2:j2))) min(log10(xx3(i3:j3))) ]);

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