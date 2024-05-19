%
%  subplots_four_linlin_titles.m  ver 1.2  by Tom Irvine
%

function[fig_num]=subplots_four_linlin_titles(fig_num,xlabelx,...
                              ylabel1,ylabel2,ylabel3,ylabel4,...
                              data1,data2,data3,data4,...
                              t_string1,t_string2,t_string3,t_string4)

try
    close fig_num;
catch
end
try
    close fig_num hidden;
catch    
end

hp=figure(fig_num);


subplot(3,1,1);
plot(data1(:,1),data1(:,2));
ylabel(ylabel1);
title(t_string1);
qqq=get(gca,'ylim');
qmax=max(abs(qqq));
ylim([-qmax,qmax]);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
subplot(3,1,2);
plot(data2(:,1),data2(:,2));
xlabel(xlabelx);
ylabel(ylabel2);
title(t_string2);
qqq=get(gca,'ylim');
qmax=max(abs(qqq));
yabs=qmax;
[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

%
subplot(3,1,3);
plot(data3(:,1),data3(:,2));
xlabel(xlabelx);
ylabel(ylabel3);
title(t_string3);
qqq=get(gca,'ylim');
qmax=max(abs(qqq));
yabs=qmax;
[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end


set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
subplot(4,1,4);
plot(data4(:,1),data4(:,2));
xlabel(xlabelx);
ylabel(ylabel4);
title(t_string4);
qqq=get(gca,'ylim');
qmax=max(abs(qqq));
yabs=qmax;
[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end


set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','lin','XminorTick','off','YminorTick','off');                 
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

set(hp, 'Position', [0 0 750 850]);

fig_num=fig_num+1;