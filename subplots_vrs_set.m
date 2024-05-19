%
%  subplots_vrs_set.m  ver 1.2  by Tom Irvine
%

function[fig_num]=subplots_vrs_set(fig_num,fn,data1,data2,data3,Q,fmin,fmax,iu)

leg1='peak';
leg2='3-sigma';
leg3='1-sigma';

if(iu<=2)
    ylabel1='Accel (G)';
else
    ylabel1='Accel (m/sec^2)';    
end

if(iu==1)
    ylabel2='PV (in/sec)';
    ylabel3='Rel Disp (in)';
else
    ylabel2='PV (m/sec)';
    ylabel3='Rel Disp (mm)';
end    

t_string1=sprintf('Acceleration VRS Q=%g ',Q);
t_string2=sprintf('Pseudo Velocity VRS Q=%g ',Q);
t_string3=sprintf('Relative Displacement VRS Q=%g ',Q);

[xtt,xTT,iflag]=xtick_label(fmin,fmax);


hp=figure(fig_num);

subplot(1,3,1);

plot(fn,data1(:,1),fn,data1(:,2),fn,data1(:,3));
legend(leg1,leg2,leg3);
grid on;
xlabel('Natural Frequency (Hz)');
ylabel(ylabel1);
title(t_string1);
% ylim([ymin,ymax]);

ymin=min(data1(:,3));
ymax=max(data1(:,1));
[ytt,yTT,jflag]=ytick_label(ymin,ymax);

if(jflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end
   
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
subplot(1,3,2);
plot(fn,data2(:,1),fn,data2(:,2),fn,data2(:,3));
legend(leg1,leg2,leg3);
grid on;
xlabel('Natural Frequency (Hz)');
ylabel(ylabel2);
title(t_string2);
% ylim([ymin,ymax]);

ymin=min(data2(:,3));
ymax=max(data2(:,1));
[ytt,yTT,jflag]=ytick_label(ymin,ymax);


if(jflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end


set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
subplot(1,3,3);
plot(fn,data3(:,1),fn,data3(:,2),fn,data3(:,3));
legend(leg1,leg2,leg3);
grid on;
xlabel('Natural Frequency (Hz)');
ylabel(ylabel3);
title(t_string3);
% ylim([ymin,ymax]);

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
ymin=min(data3(:,3));
ymax=max(data3(:,1));
[ytt,yTT,jflag]=ytick_label(ymin,ymax);


if(jflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    xlim([min(xtt),max(xtt)]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=fig_num+1;
set(hp, 'Position', [50 50 1400 400]);