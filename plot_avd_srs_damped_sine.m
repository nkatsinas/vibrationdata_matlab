%
%  plot_avd_srs_damped_sine.m  ver 1.4  October 12, 2018   
%        
%  by Tom Irvine                  
%
function[fig_num]=...
plot_avd_srs_damped_sine(acceleration,velocity,displacement,srs_syn,srs_spec,damp,fig_num,iunit)
%
disp(' ');
%
figure(fig_num)
fig_num=fig_num+1;
plot(acceleration(:,1),acceleration(:,2));
title('Acceleration');
if(iunit<=2)
    ylabel('Accel(G)');
    sa='G';
else
    ylabel('Accel(m/sec^2)');  
    sa='m/sec^2';    
end  
out1=sprintf(' Acceleration:   max=%8.4g %s   min=%8.4g %s  ',max(acceleration(:,2)),sa,min(acceleration(:,2)),sa);
disp(out1);
xlabel('Time(sec)');
grid on;
%
figure(fig_num)
fig_num=fig_num+1;
plot(velocity(:,1),velocity(:,2));
title('Velocity');
if(iunit==1)
        ylabel('Velocity(in/sec)');
        sv='in/sec';
else
        ylabel('Velocity(m/sec)');
        sv='m/sec';
end
                   
out1=sprintf('     Velocity:   max=%8.4g %s   min=%8.4g %s  ',max(velocity(:,2)),sv,min(velocity(:,2)),sv);
disp(out1);
xlabel('Time(sec)');
grid on;
%
figure(fig_num)
fig_num=fig_num+1;
plot(displacement(:,1),displacement(:,2));
title('Displacement');
if(iunit==1)
        ylabel('Disp(inch)');
else
        ylabel('Disp(mm)');
end
xlabel('Time(sec)');
grid on;
%
figure(fig_num)
fig_num=fig_num+1;
plot(srs_syn(:,1),srs_syn(:,2),'b',...
     srs_syn(:,1),srs_syn(:,3),'r',...
    srs_spec(:,1),srs_spec(:,2),'k',...
    srs_spec(:,1),0.707*srs_spec(:,2),'k',...
    srs_spec(:,1),1.414*srs_spec(:,2),'k');
%
ylabel('Peak Accel (G)');
xlabel('Natural Frequency (Hz)');
Q=1/(2*damp);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');  
out5 = sprintf(' Shock Response Spectrum Q=%g ',Q);
title(out5);   
legend ('positive','negative','spec & 3 dB tol');   
grid on;
disp(' ');