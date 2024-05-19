
% subplots_two_and_two_h2.m  ver 1.0  by Tom Irvine

function[fig_num,h2]=subplots_two_and_two_h2(fig_num,...
                px_label,py_label,pt_string,ppp1,ppp2,pleg1,pleg2,...
                qx_label,qy_label,qt_string,qqq1,qqq2,qleg1,qleg2,...
                fmin,fmax,pmd,qmd)  
            
%%%
%%%

pleg1=strrep(pleg1,'_',' ');
pleg2=strrep(pleg2,'_',' ');

fa=ppp1(:,1);
fb=ppp2(:,1);


a=ppp1(:,2);
b=ppp2(:,2);

%
h2=figure(fig_num);
fig_num=fig_num+1;

subplot(1,2,1);
%

if(min(a)>0 && min(b)>0 )

    
    plot(fa,a,fb,b)
    legend(pleg1,pleg2);
    
else
    
    if(min(a)>0)
        plot(fa,a)
        legend(pleg1);        
    end
    if(min(b)>0)
        plot(fb,b)
        legend(pleg2);         
    end    

end    

ylabel(py_label);   
xlabel(px_label);
out=sprintf(pt_string);
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

[ymax,ymin]=ymax_ymin_md(max_amp,min_amp,pmd);

%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
%

axis([fmin,fmax,ymin,ymax]);

%%%
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(1,2,2);

qleg1=strrep(qleg1,'_',' ');
qleg2=strrep(qleg2,'_',' ');

fa=qqq1(:,1);
fb=qqq2(:,1);


a=qqq1(:,2);
b=qqq2(:,2);


if(min(a)>0 && min(b)>0 )
    
    plot(fa,a,fb,b)
    legend(qleg1,qleg2);
    
else
    
    if(min(a)>0)
        plot(fa,a)
        legend(qleg1);        
    end
    if(min(b)>0)
        plot(fb,b)
        legend(qleg2);         
    end    

end    

ylabel(qy_label);   
xlabel(qx_label);
out=sprintf(qt_string);
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

[ymax,ymin]=ymax_ymin_md(max_amp,min_amp,qmd);

%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
%


axis([fmin,fmax,ymin,ymax]);


set(h2, 'Position', [100 100 1250 500]);
