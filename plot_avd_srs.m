%
%  plot_avd_srs.m  ver 1.1  March 14, 2013
%
function[fig_num]=...
plot_avd_srs(acceleration,velocity,displacement,srs_syn,srs_spec,damp,fig_num,iunit)
%
figure(fig_num)
fig_num=fig_num+1;
plot(acceleration(:,1),acceleration(:,2));
title('Acceleration');
ylabel('Accel(G)');
xlabel('Time(sec)');
grid on;
%
figure(fig_num)
fig_num=fig_num+1;
plot(velocity(:,1),velocity(:,2));
title('Velocity');
if(iunit==1)
        ylabel('Velocity(in/sec)');
else
        ylabel('Velocity(m/sec)'); 
end
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