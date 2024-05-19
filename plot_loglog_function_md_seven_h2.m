%
%  plot_loglog_function_md_seven_h2.m  ver 1.5   by Tom Irvine
%
function[fig_num,h2]=plot_loglog_function_md_seven_h2(fig_num,x_label,...
               y_label,t_string,THM,leg,fmin,fmax,md)
%

cmap(1,:)=[0 0 0.8];        % dark blue
cmap(2,:)=[0.8 0 0];        % red
cmap(3,:)=[0 0 0];          % black
cmap(4,:)=[0.6 0.3 0];      % brown
cmap(5,:)=[0 0.5 0.5];      % teal
cmap(6,:)=[1 0.5 0];        % orange
cmap(7,:)=[0.5 0.5 0];      % olive
cmap(8,:)=[0.13 0.55 0.13]; % forest green  
cmap(9,:)=[0.5 0 0];        % maroon
cmap(10,:)=[0.5 0.5 0.5 ];  % grey
cmap(11,:)=[1. 0.4 0.4];    % pink-orange
cmap(12,:)=[0.5 0.5 1];     % lavender
cmap(13,:)=[0.05 0.7 1.];   % light blue
cmap(14,:)=[0  0.8 0.4 ];   % green
cmap(15,:)=[1 0.84 0];      % gold
cmap(16,:)=[0 0.8 0.8];     % turquoise


f=THM(:,1);

a1=THM(:,2);
a2=THM(:,3);
a3=THM(:,4);
a4=THM(:,5);
a5=THM(:,6);
a6=THM(:,7);
a7=THM(:,8);


%
h2=figure(fig_num);
fig_num=fig_num+1;

hold on;


plot(f,a1,'color',cmap(1,:),'DisplayName',leg{1});
plot(f,a2,'color',cmap(2,:),'DisplayName',leg{2});
plot(f,a3,'color',cmap(3,:),'DisplayName',leg{3});
plot(f,a4,'color',cmap(4,:),'DisplayName',leg{4});
plot(f,a5,'color',cmap(5,:),'DisplayName',leg{5});
plot(f,a6,'color',cmap(6,:),'DisplayName',leg{6});
plot(f,a7,'color',cmap(7,:),'DisplayName',leg{7});


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

max_amp=max([ max(a1) max(a2) max(a3) max(a4) max(a5) max(a6) max(a7)]);
min_amp=min([ min(a1) min(a2) min(a3) min(a4) min(a5) min(a6) min(a7)]);

[ymax,ymin]=ymax_ymin_md(max_amp,min_amp,md);

%%%

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
try
    axis([fmin,fmax,ymin,ymax]);
catch
end 

    legend show;
        legend('location','eastoutside')
        set(h2, 'Position', [0 0 1400 900]);
        set(gca,'Fontsize',20);
hold off;