%
%  plot_time_history.m  ver 1.0  October 12, 2012
%
function[fig_num]=plot_time_history(fig_num,y_label,t_string,a,n)
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(a(:,1),a(:,2));
    grid on; 
    if(n==1)
        out5 = sprintf('%s   std dev=%8.3g',t_string,std(a(:,2)));
    else
        out5 = sprintf('%s',t_string);
    end
    title(out5);  
    ylabel(y_label);
    xlabel(' Time (sec)');