%
%  plot_loglog_function_h2.m  ver 1.2  by Tom Irvine
%
function[fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax)
%
f=ppp(:,1);
a=ppp(:,2);
%
h2=figure(fig_num);
fig_num=fig_num+1;
%
plot(f,a)
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

[~,ii]=min(abs(f-fmin));
[~,jj]=min(abs(f-fmax));

a=a(ii:jj);

ymax= 10^ceil(log10(max(a)));
%
ymin=ymax;
%
%% out1=sprintf('ymin=%8.4g  fmin=%8.4g  fmax=%8.4g',ymin,fmin,fmax);
%% disp(out1);
%
for i=1:length(a)
    if(ymin>a(i) && f(i)>=fmin && f(i) <=fmax)
        ymin=a(i);
    end
end
%
ymin= 10^floor(log10(ymin));
%
if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end    
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
axis([fmin,fmax,ymin,ymax]);