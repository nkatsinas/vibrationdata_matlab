%
%  plot_PSD_two_sdof_ran.m  ver 1.1  October 17, 2012
%
function[fig_num]=...
  plot_PSD_two_sdof_ran(fig_num,x_label,y_label,t_string,ppp,qqq,leg_a,leg_b)
%
figure(fig_num);
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
disp(' ');
fmin=input(' Enter starting plot frequency (Hz) ');
fmax=input(' Enter   ending plot frequency (Hz) ');
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
if(ymin<ymax/1.0e+05)
    ymin=ymax/1.0e+05;
end
%
f=qqq(:,1);
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
axis([fmin,fmax,ymin,ymax]);
