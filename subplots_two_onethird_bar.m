%
%  subplots_two_onethird_bar.m  ver 1.1  by Tom Irvine
%

function[fig_num]=subplots_two_onethird_bar(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2)


try
    close fig_num;
end
try
    close fig_num hidden;
end




n=length(data1(:,1));

for i=2:n
    data1(i,1)=data1(i-1,1)*2^(1/3);
end

n=length(data2(:,1));

for i=2:n
    data2(i,1)=data2(i-1,1)*2^(1/3);    
end    






figure(fig_num);


subplot(2,1,1);
bar(log10(data1(:,1)),data1(:,2));

fmin=0.95*data1(1,1);
fmax=1.05*max(data1(:,1));

fmax=fmax*2^(1/3);

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




ylabel(ylabel1);
title(t_string1);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
subplot(2,1,2);
bar(log10(data2(:,1)),data2(:,2));

if(iflag==1)
    
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
    xlim([fmin,fmax]);    
end   



xlabel(xlabel2);
ylabel(ylabel2);
title(t_string2);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

fig_num=fig_num+1;