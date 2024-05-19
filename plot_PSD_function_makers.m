%
%  plot_PSD_function_markers.m  ver 2,0 by Tom Irvine
%
function[fig_num,h2]=plot_PSD_function_markers(fig_num,x_label,y_label,t_string,ppp,fmin,fmax)
%
f=ppp(:,1);
a=ppp(:,2);
%
h2=figure(fig_num);
fig_num=fig_num+1;
%
plot(f,a,)
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
ymax=1.0e-90; 
%
ymin=1.0e+90;
%
%% out1=sprintf('ymin=%8.4g  fmin=%8.4g  fmax=%8.4g',ymin,fmin,fmax);
%% disp(out1);
%
for i=1:length(a)
    
    if( f(i)>=fmin && f(i) <=fmax  )
    
        if(ymin>a(i))
            ymin=a(i);
        end
        if(ymax<a(i))
            ymax=a(i);
        end
    
    end
    
end
%
[ymin,ymax]=ytick_log(ymin,ymax);
%
%
L=10^6;
%
if(ymin<ymax/L)
    ymin=ymax/L;
end


[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);          
end

%
%clear ytickn;
%
ya=ymin;
k=1;
for i=1:10
    for j=1:9
        ytickn(k)=j*ya; 
        k=k+1;
    end
    ya=ya*10.;
    ytickn(k)=ya; 
%    
    if(ya>ymax)
        break;
    end
end
%
nd=round(log10(ymax/ymin));
%
set(gca,'ytick',ytickn);
%
string1=num2str(ymin);
string2=num2str(10*ymin);
string3=num2str(100*ymin);
string4=num2str(1000*ymin);
string5=num2str(10000*ymin);
string6=num2str(100000*ymin);
string7=num2str(1000000*ymin);
%
if(nd==1)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2})
end
if(nd==2)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3})
end
if(nd==3)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3;'';'';'';'';'';'';'';'';string4})
end
if(nd==4)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3;'';'';'';'';'';'';'';'';string4;'';'';'';'';'';'';'';'';string5})
end
if(nd==5)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3;'';'';'';'';'';'';'';'';string4;'';'';'';'';'';'';'';'';string5;'';'';'';'';'';'';'';'';string6})
end
if(nd==6)
    set(gca,'YTickLabel',{string1;'';'';'';'';'';'';'';'';string2;'';'';'';'';'';'';'';'';string3;'';'';'';'';'';'';'';'';string4;'';'';'';'';'';'';'';'';string5;'';'';'';'';'';'';'';'';string6;'';'';'';'';'';'';'';'';string7})
end
%
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%
axis([fmin,fmax,ymin,ymax]);