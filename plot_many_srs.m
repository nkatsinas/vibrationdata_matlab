%
% function[fig_num]=plot_loglog_multiple_function(fig_num,x_label,y_label,t_string,ppp,leg,fmin,fmax)
%

fig_num=1;
fmin=10;
fmax=10000;
x_label='Natural Frequency (Hz)';
y_label='Peak Accel (G)';
t_string='SRS Q=10  NS CC Separation Shock X-axis';

%
figure(fig_num);
fig_num=fig_num+1;
%

hold on;
%
a=E1_sep3x_cleaned_abs_srs;
plot(a(:,1),a(:,2),'DisplayName','E1_sep3x_cleaned_abs_srs');



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

