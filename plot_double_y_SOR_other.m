
%
%  plot_double_y_SOR_other.m  ver 1.1  by Tom Irvine
%

function[fig_num]=plot_double_y_SOR_other(fig_num,ppp1,ppp2,tstring,fmin,fmax,md)

figure(fig_num);
fig_num=fig_num+1;

hold on;

yyaxis left

plot(ppp1(:,1),ppp1(:,2));
                 
grid on;
set(gca, 'xminorgrid', 'off', 'yminorgrid', 'on')
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
                 
ylabel('Amp (unit^2/Hz)');


ymax= 1+ceil(log10(max(ppp1(:,2))));
ymin= floor(log10(min(ppp1(:,2))));
pm=(ymax-ymin);

yymax= ceil(log10(max(ppp2(:,2))));
yymin= floor(log10(min(ppp2(:,2))));
if(yymin>=1)
    yymin=0;
end
sm=(yymax-yymin);

ymax=10^ymax;
yymax=10^yymax;

md_max=md;

md=ceil(max([pm sm]));

if(md>md_max)
    md=md_max;
end

ymin=ymax/10^md;
yymin=yymax/10^md;

ylim([ymin,ymax]);



yyaxis right

sz=size(ppp2);

for i=1:sz(1)
     aaa=[ ppp2(i,1) ppp2(i,2)/10^md ; ppp2(i,1) ppp2(i,2)];
     plot(aaa(:,1),aaa(:,2),'-r');
end


grid on;
set(gca, 'xminorgrid', 'off', 'yminorgrid', 'on')
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
                 

xlabel('Frequency (Hz)');
ylabel('Amp (unit)');

        xmin=fmin;
        xmax=fmax;
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
 
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
            fmin=min(xtt);
            fmax=max(xtt);
            xlim([fmin,fmax]);    
        end    

ylim([yymin,yymax]);
        
title(tstring);

hold off;        