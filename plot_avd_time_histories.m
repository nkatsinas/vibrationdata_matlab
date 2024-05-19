%
%  plot_avd_time_histories.m  ver 1.0  September 17, 2012
%
function[fig_num]=...
  plot_avd_time_histories(acceleration,velocity,displacement,iunit,fig_num)
%
          figure(fig_num);
          fig_num=fig_num+1;
           plot(acceleration(:,1),acceleration(:,2));
           grid on;
           title('Acceleration');
           xlabel('Time (sec)');
           if(iunit==3)
              ylabel('Accel (m/sec^2)');
           else
              ylabel('Accel (G)');               
           end
                             h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',11)
        h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',11)
         h = get(gca, 'ylabel');
    set(h, 'FontName', 'Arial','FontSize',11)
%          
%
           figure(fig_num);
           fig_num=fig_num+1;        
           plot(velocity(:,1),velocity(:,2));
           xlabel('Time (sec)');
           if(iunit==2 || iunit==3)
              ylabel('Velocity (m/sec)');
           else
              ylabel('Velocity (in/sec)');               
           end
           grid on;
           title('Velocity');
                             h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',11)
        h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',11)
         h = get(gca, 'ylabel');
    set(h, 'FontName', 'Arial','FontSize',11)
%          
%
           figure(fig_num);
           fig_num=fig_num+1;    
           if(iunit==2)
                displacement(:,2)=displacement(:,2)*1000;           
           end    
           plot(displacement(:,1),displacement(:,2));
           xlabel('Time (sec)');
           if(iunit==2 || iunit==3)
              ylabel('Disp (mm)');
           else
              ylabel('Disp (in)');               
           end
           grid on;
           title('Displacement');
                             h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',11)
        h = get(gca, 'xlabel');
    set(h, 'FontName', 'Arial','FontSize',11)
         h = get(gca, 'ylabel');
    set(h, 'FontName', 'Arial','FontSize',11)