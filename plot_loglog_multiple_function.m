%
%  plot_loglog_multiple_function.m  ver 1.2   By Tom Irvine
%
function[fig_num]=plot_loglog_multiple_function(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax)
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
for i=1:ncols
    
    try
        plot(f,ppp(:,(i+1)),'DisplayName',char(leg(i)));
    catch
        try
            plot(f,ppp(:,(i+1)),'DisplayName',leg{i});            
        catch
        end
    end
    
end

hold off;
%

legend show;

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


%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end

