%
%  plot_loglog_function_md_two_h2.m  ver 1.3  by Tom Irvine
%
function[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md)
%

leg1=strrep(leg1,'_',' ');
leg2=strrep(leg2,'_',' ');

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
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%

[xtt,xTT,iflag]=xtick_label(fmin,fmax);


if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);    
end


[~,index_fa_min] = min(abs(fa-fmin));
[~,index_fb_min] = min(abs(fb-fmin));
[~,index_fa_max] = min(abs(fa-fmax));
[~,index_fb_max] = min(abs(fb-fmax));

try
    AAA=[ a(index_fa_min:index_fa_max); b(index_fb_min:index_fb_max)];
catch
    AAA=[a; b];    
end

    
min_amp=min(min(AAA));
max_amp=max(max(AAA));

[ymax,ymin]=ymax_ymin_md(max_amp,min_amp,md);

%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
%


axis([fmin,fmax,ymin,ymax]);
