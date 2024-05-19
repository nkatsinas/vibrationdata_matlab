%
%  plot_avd_time_histories_h.m  ver 1.0  March 13, 2015
%
function[fig_num,ha,hv,hd]=...
  plot_avd_time_histories(acceleration,velocity,displacement,iunit,fig_num)
%
          ha=figure(fig_num);
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
  
%
           hv=figure(fig_num);
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


%
           hd=figure(fig_num);
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

    
    
    
    
disp(' ');
disp(' Plot files:');
disp(' ');

pname='acceleration';
out1=sprintf('   %s.png',pname);
disp(out1);
set(gca,'Fontsize',12);
print(ha,pname,'-dpng','-r300');
    
pname='velocity';
out1=sprintf('   %s.png',pname);
disp(out1);
set(gca,'Fontsize',12);
print(hv,pname,'-dpng','-r300');
    
pname='displacement';
out1=sprintf('   %s.png',pname);
disp(out1);
set(gca,'Fontsize',12);
print(hd,pname,'-dpng','-r300');  
    