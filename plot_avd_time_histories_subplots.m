%
%  plot_avd_time_histories_subplots.m  ver 1.2  by Tom Irvine
%
function[fig_num]=...
  plot_avd_time_histories_subplots(acceleration,velocity,displacement,iunit,fig_num)
%

          hp=figure(fig_num);
          fig_num=fig_num+1;
          subplot(3,1,1);
           plot(acceleration(:,1),acceleration(:,2));
           grid on;
           title('Acceleration');
           if(iunit==3)
              ylabel('Accel (m/sec^2)');
           else
              ylabel('Accel (G)');               
           end
           
           yabs=max(abs(acceleration(:,2)));
           [ymax]=ytick_linear_scale(yabs);
           ylim([-ymax,ymax]);
           
%
           subplot(3,1,2);       
           plot(velocity(:,1),velocity(:,2));
           if(iunit==2 || iunit==3)
              ylabel('Velocity (m/sec)');
           else
              ylabel('Velocity (in/sec)');               
           end
           grid on;
           title('Velocity');
           
           yabs=max(abs(velocity(:,2)));
           [ymax]=ytick_linear_scale(yabs);
           ylim([-ymax,ymax]);
           
           
                           
%
           subplot(3,1,3);               
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
                    
           yabs=max(abs(displacement(:,2)));
           [ymax]=ytick_linear_scale(yabs);
           ylim([-ymax,ymax]);
           
set(hp, 'Position', [50 50 650 650]);