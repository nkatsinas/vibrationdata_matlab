
% plot_avd_time_histories_subplots_altp.m  ver 1.1  by Tom Irvine

function[fig_num,hp]=plot_avd_time_histories_subplots_altp(fig_num,tt,a,v,d,ay,vy,dy)

hp=figure(fig_num);
fig_num=fig_num+1;
subplot(3,1,1);
plot(tt,a);
title('Acceleration');
ylabel(ay);
grid on;
ymax=max(abs(a));
[~,yTT,ytt,iflag]=ytick_linear_double_sided(ymax);
if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end



subplot(3,1,2);
plot(tt,v);
title('Velocity');
ylabel(vy);
grid on;
ymax=max(abs(v));
[~,yTT,ytt,iflag]=ytick_linear_double_sided(ymax);
if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end



subplot(3,1,3);
plot(tt,d);
title('Displacement');
ylabel(dy);
xlabel('Time(sec)');
grid on;
ymax=max(abs(d));
[~,yTT,ytt,iflag]=ytick_linear_double_sided(ymax);
if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end



set(hp, 'Position', [0 0 700 650]);

