%
%   trans_dB_plot_fd(.m  ver 1.0  by Tom Irvine
%
function[fig_num]=trans_dB_plot_fd(fig_num,f,dB,t_string)
%
%
figure(fig_num);
%
plot(f,dB);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
grid on;

title(t_string)
xlabel(' Center Frequency * Diameter (Hz-ft) ');
ylabel(' Trans (dB) ');

fmin=min(f);
fmax=max(f);

yy=get(gca,'ylim');

ymin=min(yy);
ymax=max(yy);


%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
end

%
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
xlim([fmin,fmax]);

fig_num=fig_num+1;
