%
%   subplot_real_image_two_loglin.m  ver 1.0  by Tom Irvine
%
function[fig_num]=subplot_real_image_two_loglin(fig_num,data1,data2,x_label,y_label,fmin,fmax,leg1,leg2)

subplot(2,1,1);
plot(data1(:,1),real(data1(:,2)),data2(:,1),real(data2(:,2)));
ylabel(y_label);
title('Real');

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':'); 

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);   
end
legend(leg1,leg2);
 
%
subplot(2,1,2);
plot(data1(:,1),imag(data1(:,2)),data2(:,1),imag(data2(:,2)));
ylabel(y_label);
title('Imaginary');

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

xlabel(x_label);
legend(leg1,leg2);
