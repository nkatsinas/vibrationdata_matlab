%
%  wavelet_synth_srs_plot_h.m  ver 1.0  March 13, 2015
%
function[Shock_Response_Spectrum,fig_num]=...
          wavelet_synth_srs_plot_h(f,fr,xmax,xmin,aspec,damp,iunit,fig_num)
%
hs=figure(fig_num);
fig_num=fig_num+1;
plot(f,xmax,'blue',f,xmin,'red',fr,aspec,'black');
%
Shock_Response_Spectrum=[f',xmax,xmin];
%
if(iunit==3)
              ylabel('Peak Accel (m/sec^2)');
else
              ylabel('Peak Accel (G)');               
end
xlabel('Natural Frequency (Hz)');
legend ('positive','negative','spec & tol');  
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');  
clear Q;
Q = 1/(2*damp);
out5 = sprintf(' Shock Response Spectrum Q=%g ',Q);
title(out5);   
grid on;
hold on;
plot(fr,aspec/sqrt(2),'black',fr,aspec*sqrt(2),'black');
hold off;
%
%
srs_max=max(aspec*sqrt(2));
srs_min=min(aspec/sqrt(2));
ymax= 10^(round(log10(srs_max)+0.8));
ymin= 10^(round(log10(srs_min)-0.6));
%
fmax=max(fr);
fmin=fmax/10.;
%
fmax= 10^(round(log10(fmax)+0.5));
%
if  fr(1) >= 0.001
                  fmin=0.001;
end
if  fr(1) >= 0.01
                  fmin=0.01;
end
if  fr(1) >= 0.1
                  fmin=0.1;
end
if  fr(1) >= 1
                  fmin=1;
end
if  fr(1) >= 10
                  fmin=10;
end
if  fr(1) >= 100
                  fmin=100;
end
%
if(round(max(fr))==10000)
                  fmax=2000;
end
if(round(max(fr))==1000)
                  fmax=2000;
end             
if(round(max(fr))==2000)
    fmax=2000;
    if(round(min(fr))==10)
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
    end
end
axis([fmin,fmax,ymin,ymax]);

pname='wavelet_srs';
out1=sprintf('   %s.png',pname);
disp(out1);
set(gca,'Fontsize',12);
print(hs,pname,'-dpng','-r300');  
    
%     