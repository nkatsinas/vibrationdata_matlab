%
%  plot_loglog_function_md_six_h2.m  ver 1.2  by Tom Irvine
%
function[fig_num,h2]=plot_loglog_function_md_six_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,ppp4,ppp5,ppp6,...
                leg1,leg2,leg3,leg4,leg5,leg6,fmin,fmax,md)
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
%
plot(fa,a,fb,b,fc,c,fd,d,fe,e,ff,f);
%
legend(leg1,leg2,leg3,leg4,leg5,leg6);

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



[amin,amax]=max_min_between_limits(fa,a,fmin,fmax);
[bmin,bmax]=max_min_between_limits(fb,b,fmin,fmax);
[cmin,cmax]=max_min_between_limits(fc,c,fmin,fmax);
[dmin,dmax]=max_min_between_limits(fd,d,fmin,fmax);

max_amp=max([amax bmax cmax dmax]);
min_amp=max([amin bmin cmin dmin]);


%%%

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

axis([fmin,fmax,ymin,ymax]);

%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end
%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
%
