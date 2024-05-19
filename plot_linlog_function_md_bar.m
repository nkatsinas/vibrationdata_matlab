%
%  plot_linlog_function_md_bar.m  ver 1.1  by Tom Irvine
%
function[fig_num]=...
    plot_linlog_function_md_bar(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md)
%
f=ppp(:,1);
a=ppp(:,2);
%
L=length(f);

xx=zeros(L,1);

for i=1:L
    xx(i)=i;
end

%
figure(fig_num);
fig_num=fig_num+1;
%
bar(xx,a,'BarWidth',0.5);
%
ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);

set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ymax= 10^ceil(log10(max(a)));
%
ymin= 10^floor(log10(min(a)));

if(ymin<ymax/10^md)
    ymin=ymax/10^md;
end

if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end    

ylim([ymin,ymax]); 
%
xlim([0,L+1]);     

for i=1:L+2
    xtt(i)=(i-1);
end

%%    0  1  2  3  4  5    6  7  8  9
xTT={'';'20';'';'';'40';' ';' ';'80';'';'';...
     '160';'';'';'315';'';'';'630';'';'';'1250';...
     '';'';'2500';'';'';'5000';'';'';'10K';'';...
     '';'20K';''};
 
set(gca,'xtick',xtt);
set(gca,'XTickLabel',xTT); 

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%