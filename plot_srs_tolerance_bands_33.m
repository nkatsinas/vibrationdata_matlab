
srs_syn=axsrs1;
srs_spec=[10 10; 2000 2000; 10000 2000];


figure(1);
plot(srs_syn(:,1),srs_syn(:,2),'b',...
     srs_syn(:,1),srs_syn(:,3),'r',...
    srs_spec(:,1),srs_spec(:,2),'k',...
    srs_spec(:,1),0.707*srs_spec(:,2),'k',...
    srs_spec(:,1),1.414*srs_spec(:,2),'k');
%
ylabel('Peak Accel (G)');
xlabel('Natural Frequency (Hz)');
Q=10;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');  
out5 = sprintf(' Shock Response Spectrum Q=%g ',Q);
title(out5);   
legend ('positive','negative','spec & 3 dB tol');   
grid on;
xlim([10 10000]);