%
%  plot_one_onethird_bar_ng.m  ver 1.1  by Tom Irvine
%

function[fig_num]=plot_one_onethird_bar_ng2(fig_num,xlab,ylab,data,t_string,ng)

n=length(data(:,1));

for i=2:n
    data(i,1)=data(i-1,1)*2^(1/3);
end


figure(fig_num);

bar(log10(data(:,1)),data(:,2));


fmin=0.95*data(1,1);
fmax=1.05*max(data(:,1));

[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    
    for i=1:length(xtt)
        xtt(i)=log10(xtt(i));
    end
    
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
    xlim([fmin,fmax]);    
end  

dB=data(:,2);

% [ymin,ymax]=dB_ylimits(dB);

ya =  ylim;

yymax=max(ya);


if(dB>0.96*yymax)
    ylim([0,2*yymax]); 
end

xlabel(xlab);
ylabel(ylab);
title(t_string);



    if(ng==1)
        grid on;
        set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin','YScale','lin');
    end    
    if(ng==2)
        grid on;
        set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','lin','YScale','lin');
    end
    if(ng==3)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale','lin','YScale','lin');
    end

fig_num=fig_num+1;