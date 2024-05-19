%
%  mdof_plot_legend_3iu.m  ver 1.1   Tom Irvine
%
function[]=mdof_plot_legend_3iu(t,x,y,accel,num,iu)
%
    [cmap]=cmap_colors_alt(num);
%
    try
        close 1
    end
    figure(1);
    hold('all');
%

    for i = 1:num
        out1=sprintf('dof %d',i);
        plot(t,x(:,i),'Color', cmap(i,:),'DisplayName',out1);
        legend('-DynamicLegend');
    end
    hold off;
    grid on;
    xlabel('Time(sec)');
    title('Displacement');
    if(iu==1)
        ylabel('Disp(in)');
    else
        ylabel('Disp(m)');    
    end
    plot_legend(num);
    hold off;
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

    try
        close 2
    end
    figure(2);
    hold('all');
%
    for i = 1:num
        out1=sprintf('dof %d',i);
        plot(t,y(:,i),'Color', cmap(i,:),'DisplayName',out1);
        legend('-DynamicLegend');
    end
    hold off;
    grid on;
    xlabel('Time(sec)');
    title('Velocity');
    if(iu==1)
        ylabel('Vel(in/sec)');
    else
        ylabel('Vel(m/sec)');    
    end
    plot_legend(num);
%
    hold off;
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

    try
        close 3
    end
    figure(3);
    N=length(t);
%
    if(iu<=2)
        accel=accel/386;
    end
%
%%
    hold('all');
%
    for i = 1:num
        out1=sprintf('dof %d',i);
        plot(t,accel(:,i),'Color', cmap(i,:),'DisplayName',out1);
        legend('-DynamicLegend');
    end
    hold off;
%%
    xlabel('Time(sec)');
    title('Acceleration');
    if(iu==1)
        ylabel('Accel(G)');
    else
        ylabel('Accel(m/sec^2)');    
    end
    grid on;
    hold off;
%