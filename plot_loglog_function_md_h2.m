%
%  plot_loglog_function_md_h2.m  ver 1.6   by Tom Irvine
%
function[fig_num,h2]=...
    plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md)
%
f=ppp(:,1);
a=ppp(:,2);
%
h2=figure(fig_num);
fig_num=fig_num+1;
%
plot(f,a);
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

[ymax,ymin]=ymax_ymin_md(max(a),min(a),md);

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
