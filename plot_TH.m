%
%  plot_TH.m  ver 1.0  October 13, 2012
%
function[fig_num]=plot_TH(fig_num,x_label,y_label,t_string,a)
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(a(:,1),a(:,2));
    grid on; 
%
    title(t_string);  
    ylabel(y_label);
    xlabel(x_label);