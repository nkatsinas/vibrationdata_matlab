%
%  plot_linlin_function_md_bar.m  ver 1.1  by Tom Irvine
%
function[fig_num]=...
    plot_linlin_function_md_bar(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md)
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


bar(xx,a,'BarWidth',0.5);
%
ylabel(y_label);   
xlabel(x_label);
out=sprintf(t_string);
title(out);

%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

ymax=max(a);
ymin=min(a);

for i=1:100
    y=i*5;
    if(ymax<y)
        ymax=y;
        break;
    end
end

for i=1:100
    y=250-(i*5);
    if(ymin>y)
        ymin=y;
        break;
    end
end


xlim([0,L+1]);   
ylim([ymin,ymax]);

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