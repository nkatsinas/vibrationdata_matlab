%
%   tl_plot_title.m  ver 1.0  by Tom Irvine
%
function[fig_num]=tl_plot_title(fig_num,f,dB,stitle,fmin,fmax)
%
figure(fig_num);
%
plot(f,dB);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
grid on;  
title(stitle)
xlabel(' Center Frequency (Hz) ');
ylabel(' TL (dB) ');


yy=get(gca,'ylim');

ymin=min(yy);
ymax=max(yy);

%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end


%
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
axis([fmin,fmax,ymin,ymax]);

fig_num=fig_num+1;
