%
%  plot_a_srs_damped_sine.m  ver 1.3  January 13, 2015
%
function[fig_num]=...
plot_a_srs_damped_sine(acceleration,srs_syn,srs_spec,damp,fig_num,iunit)
%
figure(fig_num)
fig_num=fig_num+1;
plot(acceleration(:,1),acceleration(:,2));
title('Acceleration');
if(iunit<=2)
    ylabel('Accel(G)');
else
    ylabel('Accel(m/sec^2)');    
end  
xlabel('Time(sec)');
grid on;
%

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