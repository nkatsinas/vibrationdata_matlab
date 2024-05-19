%
%  plot_loglog_multiple_function_none_fds.m  ver 1.3   By Tom Irvine
%
function[fig_num]=plot_loglog_multiple_function_none_fds(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax)
%
f=ppp(:,1);

sz=size(ppp);
ncols=sz(2)-1;

%
figure(fig_num);
fig_num=fig_num+1;
%

hold on;
%
% cmap = jet(ncols);

%  www.rapidtables.com/web/color/RGB_Color.html

cmap=zeros(30,3);

for i=1:30
    cmap(i,:)=[ rand() rand()  rand() ];
end
       

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
    
for i=1:ncols
    
    try
        plot(f,log10(ppp(:,(i+1))),'DisplayName',char(leg(i)),'Color',cmap(i,:));
    catch
        try
            plot(f,log10(ppp(:,(i+1))),'DisplayName',leg{i},'Color',cmap(i,:));        
        catch
        end
    end
    
end
%

legend show;

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

ymax=max(max(ppp(:,2:end)));
ymin=min(min(ppp(:,2:end)));

ymax=log10(ymax);
ymin=log10(ymin);


[ytt,yTT]=ytick_linear_min_max_alt(ymax,ymin);
set(gca,'ytick',ytt);
set(gca,'YTickLabel',yTT);
ylim([min(ytt),max(ytt)]);


%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end




hold off;