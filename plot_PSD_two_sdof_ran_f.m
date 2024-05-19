%
%  plot_PSD_two_sdof_ran_f.m  ver 1.2  June 12, 2015
%
function[fig_num,h]=...
  plot_PSD_two_sdof_ran_f(fig_num,x_label,y_label,t_string,ppp,qqq,leg_a,leg_b,fmin,fmax)
%
h=figure(fig_num);
fig_num=fig_num+1;
%
plot(ppp(:,1),ppp(:,2),qqq(:,1),qqq(:,2));
%
legend(leg_a,leg_b);
%
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','on');
%
ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ymax=0;
ymin=1.0e+90;
%
for i=1:length(ppp(:,1))
    if(ymax<ppp(i,2) && ppp(i,1)>=fmin && ppp(i,1) <=fmax)
        ymax=ppp(i,2);
    end
end
%
for i=1:length(qqq(:,1))
    if(ymax<qqq(i,2) && qqq(i,1)>=fmin && qqq(i,1) <=fmax)
        ymax=qqq(i,2);
    end
end
%
for i=1:length(ppp(:,1))
    if(ymin>ppp(i,2) && ppp(i,1)>=fmin && ppp(i,1) <=fmax)
        ymin=ppp(i,2);
    end
end
%
for i=1:length(qqq(:,1))
    if(ymin>qqq(i,2) && qqq(i,1)>=fmin && qqq(i,1) <=fmax)
        ymin=qqq(i,2);
    end
end
%
ymax= 10^ceil(log10(ymax));
ymin= 10^floor(log10(ymin));
if(ymin<ymax/1.0e+06)
    ymin=ymax/1.0e+06;
end
%
f=qqq(:,1);
%
        [xtt,xTT,iflag]=xtick_label(fmin,fmax);

        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
            fmin=min(xtt);
            fmax=max(xtt);   
        end              
        xlim([fmin,fmax]); 
%
axis([fmin,fmax,ymin,ymax]);
