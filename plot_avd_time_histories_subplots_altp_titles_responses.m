
% plot_avd_time_histories_subplots_altp_titles_responses.m  ver 1.0  by Tom Irvine

function[fig_num,hp]=...
    plot_avd_time_histories_subplots_altp_titles_responses(fig_num,tt,a,v,d,ay,vy,dy,aat,vvt,ddt,ar,rdr,art,rdrt,drdry)

hp=figure(fig_num);
fig_num=fig_num+1;
subplot(3,2,1);
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

subplot(3,2,2);
plot(tt,ar);
title(art);
ylabel(ay);
grid on;
yabs=max(abs(ar));
[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(3,2,3);
plot(tt,v);
title(vvt);
ylabel(vy);
grid on;
yabs=max(abs(v));
[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end


subplot(3,2,4);
plot(tt,rdr);
title(rdrt);
ylabel(drdry);
xlabel('Time(sec)');
grid on;
yabs=max(abs(rdr));
[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


subplot(3,2,5);
plot(tt,d);
title(ddt);
ylabel(dy);
xlabel('Time(sec)');
grid on;
yabs=max(abs(d));
[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(hp, 'Position', [0 0 1200 750]);

