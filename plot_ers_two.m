%
%  plot_fds_two.m  ver 1.1  September 16, 2014
%
function[fig_num]=...
         plot_fds_two(fig_num,x_label,y_label,ppp,qqq,leg_a,leg_b,Q,iu,nmetric)
%
f=ppp(:,1);
a=ppp(:,2);
%
figure(fig_num);
fig_num=fig_num+1;
%
plot(ppp(:,1),ppp(:,2),qqq(:,1),qqq(:,2));
%
legend(leg_a,leg_b);
%
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','off');
%
fmax= 10^ceil(log10(max(f)));
fmin=10^floor(log10(min(f)));
%
%
if(fmin<1)
    fmin=1;
end
%
M1=[ max(ppp(:,2)) max(qqq(:,2)) ];
M2=[ min(ppp(:,2)) min(qqq(:,2)) ];
%
max_psd=max(M1);
min_psd=min(M2);
%

if(nmetric==1)
    t_string=sprintf('Acceleration Fatigue Damage Spectra  Q=%g b=%g ',Q,bex);
    if(iu==1)
        y_label=sprintf('Damage (G)^{ %g }',bex);
    else
        y_label=sprintf('Damage (m/sec^2)^{ %g }',bex);        
    end
else
    t_string=sprintf('Pseudo Velocity Fatigue Damage Spectra  Q=%g b=%g ',Q,bex);   
    if(iu==1)
        y_label=sprintf('Damage (ips)^{ %g }',bex);
    else
        y_label=sprintf('Damage (m/sec)^{ %g }',bex);        
    end    
end    
out=sprintf(t_string);
title(out);

ylabel(y_label);   
xlabel(x_label);

%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
if( abs(min(f)-20) < 1 )
    fmin=20;
end
if( abs(min(f)-10) < 1 )
    fmin=10;
end
if( abs(max(f)-2000) < 20 )
    fmax=2000;
end
%
if(round(fmin)==20 && round(fmax)==2000)
    set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
    set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
end
if(round(fmin)==10 && round(fmax)==2000)
    set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
    set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
end
%
xlim([fmin,fmax]);
%