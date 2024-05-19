%
%  plot_loglog_function_h2_rad_eff.m  ver 1.2  by Tom Irvine
%
function[fig_num,h2]=plot_loglog_function_h2_rad_eff(fig_num,x_label,t_string,ppp,fmin,fmax)
%
y_label='Rad Eff';

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

[~,i1] = min(abs(f-fmin));    
[~,i2] = min(abs(f-fmax));        
%

aa=a(i1:i2);

ymax=max(aa);
ymin=min(aa);
  

if(ymax<2)
    ymax=2;
end

if(ymin<0.01)
    ymin=0.01;
end


%
[ytt,yTT,iflag]=ytick_label(ymin,ymax);


if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ymin=min(ytt);
    ymax=max(ytt);
end

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