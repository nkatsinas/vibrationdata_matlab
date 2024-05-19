%
%  wavelet_synth_srs_plot.m  ver 1.2  by Tom Irvine
%
function[Shock_Response_Spectrum,fig_num]=...
          wavelet_synth_srs_plot(f,fr,xmax,xmin,aspec,damp,iunit,fig_num)
%

figure(fig_num);
fig_num=fig_num+1;

h1=plot(f,xmax,'blue');
hold on;

h2=plot(f,xmin,'red');

h3=plot(fr,aspec,'black');

h4=plot(fr,aspec/sqrt(2),'black',fr,aspec*sqrt(2),'black');

legend([h1 h2 h3],{'positive','negative','spec & tol'});

%
f=fix_size(f);
Shock_Response_Spectrum=[f,xmax,xmin];
%
if(iunit==3)
              ylabel('Peak Accel (m/sec^2)');
else
              ylabel('Peak Accel (G)');               
end
xlabel('Natural Frequency (Hz)');
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');  
clear Q;
Q = 1/(2*damp);
out5 = sprintf(' Shock Response Spectrum Q=%g ',Q);
title(out5);   
grid on;

hold off;
%
%
srs_max=max(aspec*sqrt(2));
srs_min=min(aspec/sqrt(2));
ymax= 10^(round(log10(srs_max)+0.8));
ymin= 10^(round(log10(srs_min)-0.6));
%
fmin=f(1);
fmax=max(f);

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=xtt(1);
    fmax=max(xtt);
end   

axis([fmin,fmax,ymin,ymax]);

h = get(gca, 'title');
set(h, 'FontName', 'Arial','FontSize',11)
h = get(gca, 'xlabel');
set(h, 'FontName', 'Arial','FontSize',11)
h = get(gca, 'ylabel');
set(h, 'FontName', 'Arial','FontSize',11)
%     