%
%  plot_loglog_multiple_function_none_nlegend2.m  ver 1.2   By Tom Irvine
%
function[fig_num]=plot_loglog_multiple_function_none_nlegend2(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax,nlegend)
%
f=ppp(:,1);

sz=size(ppp);
ncols=sz(2)-1;

%
hp=figure(fig_num);
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
       

cmap(1,:)=[0 0 0];          % black
cmap(2,:)=[0 0 0.8];        % dark blue
cmap(3,:)=[0.8 0 0];        % red
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
    
    if(nlegend<=2)
    
        try
            if(i==1)
                plot(f,ppp(:,(i+1)),'DisplayName',char(leg(i)),'Color',cmap(i,:),'LineWidth',2.0);
            else
                plot(f,ppp(:,(i+1)),'DisplayName',char(leg(i)),'Color',cmap(i,:));                
            end    
        catch
            
            if(i==1)
                plot(f,ppp(:,(i+1)),'DisplayName','Color',cmap(i,:),'LineWidth',2.0);
            else
                plot(f,ppp(:,(i+1)),'DisplayName','Color',cmap(i,:));                
            end                

        end
        
        legend show;
    
    else
        
        try
            plot(f,ppp(:,(i+1)),'Color',cmap(i,:));
        catch
            try
                plot(f,ppp(:,(i+1)),'Color',cmap(i,:));        
            catch
            end
        end        
        
    end
    
end
%



ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

ymax=max(max(ppp(:,2:end)));
ymin=min(min(ppp(:,2:end)));

[ytt,yTT,iflag]=ytick_label(ymin,ymax);


if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end


%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end

hold off;

if(nlegend<=2)
    legend show;
    if(nlegend==2)
        legend('location','eastoutside')
        set(hp, 'Position', [0 0 1300 700]);
        set(gca,'Fontsize',18);
    end    
end 
