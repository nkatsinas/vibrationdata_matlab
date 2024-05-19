%
%  plot_loglog_function_md_h2_wavespeed.m  ver 1.6   by Tom Irvine
%
function[fig_num,h2]=...
    plot_loglog_function_md_h2_wavespeed(fig_num,x_label,y_label,t_string,ppp1,ppp2,fcr,trans1,fmin,fmax,md)
%
        cmap(1,:)=[0 0.1 0.4];      % dark blue
        cmap(2,:)=[0.8 0 0];        % red
        cmap(3,:)=[0 0 0];          % black
        cmap(4,:)=[0.6 0.3 0];      % brown
        cmap(5,:)=[0 0.5 0.5];      % teal
        cmap(13,:)=[0.05 0.7 1.];   % light blue

f=ppp1(:,1);
a=ppp1(:,2);
%
h2=figure(fig_num);
fig_num=fig_num+1;
%
ppp3=[fcr ppp2(1,2)];

hold on;
plot(trans1(:,1),trans1(:,2),'-.','Color','k','DisplayName','Bending-to-Shear Transition Frequency');
plot(f,a,'Color','b','DisplayName','Structural Wave');
plot(ppp2(:,1),ppp2(:,2),'Color',cmap(5,:),'DisplayName','Airborne Sound');
plot(ppp3(:,1),ppp3(:,2),'o','Color',cmap(5,:),'DisplayName','Critical Frequency');

%
ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

iflag=1;

while(iflag==1)
    
    iflag=0;
    
    for i=1:length(f)
        if(a(i)<1.0e-12)
            
            f(i)=[];
            a(i)=[]; 
            
            iflag=1;
            break; 
        end
    end        
end

amax=max([max(a) max(ppp2(:,2))]);
amin=min([min(a) min(ppp2(:,2))]);

[ymax,ymin]=ymax_ymin_md(amax,amin,md);

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
                     'YScale','log','XminorTick','off','YminorTick','off');
%
xlim([fmin,fmax]);

try
    ylim([ymin,ymax]);
catch
    ymin
    ymax
    warndlg(' ymin, ymax error ');
    return;
end

 legend('location','northwest');

hold off;