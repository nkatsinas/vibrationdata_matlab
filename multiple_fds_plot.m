    

%  multiple_fds_plot.m  ver 1.0  by Tom Irvine


function[fig_num]=multiple_fds_plot(fig_num,Q,bex,fn,fds_th,AL,nc)
    
    AL = strrep(AL,'_',' ');
    AL = strrep(AL,'-',' ');
    
    if(nc==1)
        [fig_num]=multiple_fds_plot_1x1(fig_num,Q,bex,fn,fds_th,AL);
    end
    if(nc==4)
        [fig_num]=multiple_fds_plot_2x2_AL(fig_num,Q,bex,fn,fds_th,AL);
    end           