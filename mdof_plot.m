%
%  mdof_plot.m  ver 1.2  January 11, 2013
%
function[]=mdof_plot(t,x,y,accel,num,iu)
%
    [colororder,color_rows]=line_colors();
%
    figure(1);
    hold('all');
%
    j=1;
    for i = 1:num
        if(j>color_rows)
            j=j-color_rows;
        end
        plot(t,x(:,i),'Color', colororder(j,:));
        j=j+1;
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
    figure(2);
    hold('all');
%
    j=1;
    for i = 1:num
        if(j>color_rows)
            j=j-color_rows;
        end
        plot(t,y(:,i),'Color', colororder(j,:));
        j=j+1;
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
    figure(3);
    N=length(t);
%
    if(iu==1)
        accel=accel/386;
    end
%
%%
    hold('all');
%
    j=1;
    for i = 1:num
        if(j>color_rows)
            j=j-color_rows;
        end
        plot(t,accel(:,i),'Color', colororder(j,:));
        j=j+1;
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
    plot_legend(num);
    hold off;
%
fig_num=4;
%
disp(' ');
disp(' Plot relative displacement? ');
disp('  1=yes  2=no ');
ird=input(' ');
%    
while(ird==1)
%
    disp(' ');
    n1=input(' Enter first dof number ');
    n2=input(' Enter second dof number ');
%   
    clear rd;
    rd=x(:,n1)-x(:,n2);
%
    figure(fig_num);
    plot(t,rd);
    xlabel('Time(sec)');
    out1=sprintf('Relative Displacement dof %d-%d',n1,n2);
    title(out1);
    if(iu==1)
        ylabel('Disp(in)');
    else
        ylabel('Disp(m)');    
    end
    grid on;
%    
    fig_num=fig_num+1;   
%
    disp(' ');
    disp(' Plot another relative displacement? ');
    disp('  1=yes  2=no ');
    ird=input(' ');
%     
end
%
hold off;