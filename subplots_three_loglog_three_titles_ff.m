%
%  subplots_three_loglog_three_titles_ff.m  ver 1.1  by Tom Irvine
%

function[fig_num]=subplots_three_loglog_three_titles_ff(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3,fmin,fmax)



ymin1=min(data1(:,2));
ymin2=min(data2(:,2));
ymin3=min(data3(:,2));




try
    close fig_num;
end
try
    close fig_num hidden;
end

hp=figure(fig_num);

subplot(3,1,1);

plot(data1(:,1),data1(:,2));
grid on;
ylabel(ylabel1);
title(t_string1);
% ylim([ymin,ymax]);

ymin=min(data1(:,2));
ymax=max(data1(:,2));
[ytt,yTT,iflag]=ytick_label(ymin,ymax);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');


if(min(data1(:,2))>0)
    set(gca,'XGrid','on','GridLineStyle',':');

        if(log10(ymax/ymin)<=6)
            set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
            set(gca,'YGrid','on','GridLineStyle',':');         
        else
            set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off'); 
            set(gca,'YGrid','off','GridLineStyle',':');                  
        end
else
     set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'XminorTick','off');    
end    

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end



%%%%%%%%%%%

%
subplot(3,1,2);
plot(data2(:,1),data2(:,2));
grid on;
ylabel(ylabel2);
title(t_string2);
% ylim([ymin,ymax]);

ymin=min(data2(:,2));
ymax=max(data2(:,2));
[ytt,yTT,iflag]=ytick_label(ymin,ymax);


if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');


if(min(data2(:,2))>0)
    set(gca,'XGrid','on','GridLineStyle',':');
    
        if(log10(ymax/ymin)<=6)
            set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
            set(gca,'YGrid','on','GridLineStyle',':');         
        else
            set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off'); 
            set(gca,'YGrid','off','GridLineStyle',':');                  
        end
else
     set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'XminorTick','off');      
end

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end


%%%%%%%%%%%%%%

%
subplot(3,1,3);
plot(data3(:,1),data3(:,2));
grid on;
xlabel(xlabel3);
ylabel(ylabel3);
title(t_string3);
% ylim([ymin,ymax]);

set(gca,'XGrid','on','GridLineStyle',':');

ymin=min(data3(:,2));
ymax=max(data3(:,2));
[ytt,yTT,iflag]=ytick_label(ymin,ymax);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end


if(min(data3(:,2))>0)
    if(log10(ymax/ymin)<=6)
        
        set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
        set(gca,'YGrid','on','GridLineStyle',':');         
    else
      
        set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off'); 
        set(gca,'YGrid','off','GridLineStyle',':');                  
    end
else
     set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'XminorTick','off');       
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end


fig_num=fig_num+1;
set(hp, 'Position', [50 50 650 650]);




