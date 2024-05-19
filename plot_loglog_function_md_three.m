%
%  plot_loglog_function_md_three.m  ver 1.5  by Tom Irvine
%
function[fig_num]=plot_loglog_function_md_three(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md)
%
fa=ppp1(:,1);
fb=ppp2(:,1);
fc=ppp3(:,1);

a=ppp1(:,2);
b=ppp2(:,2);
c=ppp3(:,2);
%
figure(fig_num);
fig_num=fig_num+1;
%
plot(fa,a,'k');
hold on;
plot(fb,b,'b');
plot(fc,c,'r');
hold off;
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
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


[~,i1] = min(abs(fa-fmin));
[~,i2] = min(abs(fa-fmax));

[~,j1] = min(abs(fb-fmin));
[~,j2] = min(abs(fb-fmax));

[~,k1] = min(abs(fc-fmin));
[~,k2] = min(abs(fc-fmax));

%%

max_amp=max([ max(a(i1:i2)) max(b(j1:j2)) max(c(k1:k2)) ]);
min_amp=min([ min(a(i1:i2)) min(b(j1:j2)) min(c(k1:k2)) ]);

ymax= 10^ceil(log10(max_amp));
%
ymin= 10^floor(log10(min_amp));

if(ymin<ymax/10^md)
    ymin=ymax/10^md;
end

%
if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end   
%
if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end    
%

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
end    

%
%
grid on;
set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','log');  

%
axis([fmin,fmax,ymin,ymax]);