%
%  plot_loglog_function_md_two_h2_second_dash.m  ver 1.5  by Tom Irvine
%
function[fig_num,h2]=plot_loglog_function_md_four_h2_third_dash(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md)
%
fa=ppp1(:,1);
fb=ppp2(:,1);


a=ppp1(:,2);
b=ppp2(:,2);


%
h2=figure(fig_num);
fig_num=fig_num+1;
hold on;
%

% plot(fa,a,'b',fb,b,'r',fc,c,'--k',fd,d,'color',[0.0    0.50    0.50]);
% legend(leg1,leg2,leg3,leg4);

h(1)=plot(fa,a,'b');
h(2)=plot(fb,b,'--k');


hold off;

legend(h,leg1,leg2,'location','northwest');   

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

max_amp=max([ max(a) max(b) ]);
min_amp=min([ min(a) min(b)  ]);

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

