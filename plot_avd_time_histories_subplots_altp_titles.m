
% plot_avd_time_histories_subplots_altp_titles.m  ver 1.0  by Tom Irvine

function[fig_num,hp]=plot_avd_time_histories_subplots_altp_titles(fig_num,tt,a,v,d,ay,vy,dy,aat,vvt,ddt)

hp=figure(fig_num);
fig_num=fig_num+1;
subplot(3,1,1);
plot(tt,a);
title(aat);
ylabel(ay);
grid on;

yabs=max(abs(a));
[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end


subplot(3,1,2);
plot(tt,v);
title(vvt);
ylabel(vy);
grid on;
[ymax]=ytick_linear_altp(max(abs(v)));
ylim([-ymax,ymax]);


subplot(3,1,3);
plot(tt,d);
title(ddt);
ylabel(dy);
xlabel('Time(sec)');
grid on;
[ymax]=ytick_linear_altp(max(abs(d)));
ylim([-ymax,ymax]);


set(hp, 'Position', [0 0 750 650]);

