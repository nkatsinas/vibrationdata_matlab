%
%  plot_PSD.m  ver 1.3  December 15, 2012
%
function[fig_num]=plot_PSD(fig_num,x_label,y_label,t_string,ppp)
%
f=ppp(:,1);
a=ppp(:,2);
%
figure(fig_num);
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
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
fmin=input(' Enter starting plot frequency (Hz) ');
fmax=input(' Enter   ending plot frequency (Hz) ');
%
ymax= 10^ceil(log10(max(a)));
%
ymin=ymax;
%
for i=1:length(a)
    if(ymin>a(i) && f(i)>=fmin && f(i) <=fmax)
        ymin=a(i);
    end
end
%
ymin= 10^floor(log10(ymin));
%
L=10^4;
%
if(ymin<ymax/L)
    ymin=ymax/L;
end
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
%clear ytickn;
%
ya=ymin;
k=1;
for(i=1:10)
    for(j=1:9)
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