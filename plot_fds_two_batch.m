%
%  plot_fds_two_batch.m  ver 1.2  by Tom Irvine
%
function[fig_num]=...
         plot_fds_two_batch(fig_num,x_label,y_label,ppp,qqq,leg_a,leg_b,Q,bex,iu,nmetric)
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
fmax=max(f);
fmin=min(f);


if(fmin<1)
        fmin=1;
end

[xtt,xTT,iflag]=xtick_label(fmin,fmax);


%
%

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
end    
if(nmetric==2)
    t_string=sprintf('Pseudo Velocity Fatigue Damage Spectra  Q=%g b=%g ',Q,bex);   
    if(iu==1)
        y_label=sprintf('Damage (ips)^{ %g }',bex);
    else
        y_label=sprintf('Damage (m/sec)^{ %g }',bex);        
    end    
end    
if(nmetric==3)
    t_string=sprintf('Relative Displacement Fatigue Damage Spectra  Q=%g b=%g ',Q,bex);   
    if(iu==1)
        y_label=sprintf('Damage (in)^{ %g }',bex);
    else
        y_label=sprintf('Damage (mm)^{ %g }',bex);        
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

if(iflag==1)
        set(gca,'xtick',xtt);
        set(gca,'XTickLabel',xTT);
        fmin=min(xtt);
        fmax=max(xtt);
end   

%
xlim([fmin,fmax]);
%