%
%  plot_linlog_function_md_two_h2.m  ver 1.3  by Tom Irvine
%
function[fig_num,h2]=plot_linlog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md)
%
fa=ppp1(:,1);
fb=ppp2(:,1);


a=ppp1(:,2);
b=ppp2(:,2);

%
h2=figure(fig_num);
fig_num=fig_num+1;
%

if(min(a)>0 && min(b)>0 )

    plot(fa,a,fb,b)
    legend(leg1,leg2);
    
else
    
    if(min(a)>0)
        plot(fa,a)
        legend(leg1);        
    end
    if(min(b)>0)
        plot(fb,b)
        legend(leg2);         
    end    

end    

ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

max_amp=max([ max(a) max(b) ]);
min_amp=min([ min(a) min(b) ]);

[ymax,ymin]=ymax_ymin_md(max_amp,min_amp,md);

%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
%
axis([fmin,fmax,ymin,ymax]);