%
%  plot_loglog_function_md_six_h2_six_dash.m  ver 1.5  by Tom Irvine
%
function[fig_num,h2]=plot_loglog_function_md_six_h2_six_dash(fig_num,x_label,...
                  y_label,t_string,ppp1,ppp2,ppp3,ppp4,ppp5,ppp6,leg1,leg2,leg3,leg4,leg5,leg6,fmin,fmax,md)
%
fa=ppp1(:,1);
fb=ppp2(:,1);
fc=ppp3(:,1);
fd=ppp4(:,1);
fe=ppp5(:,1);
ff=ppp6(:,1);

a=ppp1(:,2);
b=ppp2(:,2);
c=ppp3(:,2);
d=ppp4(:,2);
e=ppp5(:,2);
f=ppp6(:,2);

%
h2=figure(fig_num);
fig_num=fig_num+1;
hold on;
%

% plot(fa,a,'b',fb,b,'r',fc,c,'--k',fd,d,'color',[0.0    0.50    0.50]);
% legend(leg1,leg2,leg3,leg4);

cmap(2,:)=[0 0 0.8];        % dark blue
cmap(3,:)=[0.8 0 0];        % red
cmap(4,:)=[0.6 0.3 0];      % brown
cmap(5,:)=[0 0.5 0.5];      % teal
cmap(6,:)=[1 0.5 0];        % orange


h(1)=plot(fa,a,'color',cmap(2,:));
h(2)=plot(fb,b,'color',cmap(3,:));
h(3)=plot(fc,c,'color',cmap(4,:));
h(4)=plot(fd,d,'color',cmap(5,:));
h(5)=plot(fe,e,'color',cmap(6,:));
h(6)=plot(ff,f,'--k');


hold off;

legend(h,leg1,leg2,leg3,leg4,leg5,leg6);   

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

max_amp=max([ max(a) max(b) max(c) max(d) max(e) max(f)]);
min_amp=min([ min(a) min(b) min(c) min(d) min(e) min(f)]);

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

