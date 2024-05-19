%
%  plot_avd_time_histories_subplots_alt.m  ver 1.1  by Tom Irvine
%
function[fig_num]=...
  plot_avd_time_histories_subplots_alt(acceleration,velocity,displacement,iunit,fig_num)
%

          try
              close fig_num
          end
          try
              close fig_num hidden
          end          

          hp=figure(fig_num);
          fig_num=fig_num+1;
          subplot(3,1,1);
          plot(acceleration(:,1),acceleration(:,2));
          grid on;
          title('Acceleration');
          xlabel('Time (sec)');
          ylabel('Accel (G)');               
           
          yabs=max(abs(acceleration(:,2)));
          [ymax]=ytick_linear_scale(yabs);
          ylim([-ymax,ymax]);
           
%
          subplot(3,1,2);       
          plot(velocity(:,1),velocity(:,2));
          xlabel('Time (sec)');
          if(iunit==2 )
              ylabel('Velocity (cm/sec)');
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