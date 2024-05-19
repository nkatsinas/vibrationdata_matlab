disp(' ');
disp(' PSD_plot.m    version 1.4   October 15, 2007 ');
disp(' ');
disp(' by Tom Irvine ');
disp(' ');
disp(' This function plots a PSD in log-log format with a full grid. ');
disp(' ');
%
clear m;
%
disp(' ')
disp(' Select data input method: ')
disp('  1=Open external file    ');
disp('  2=Preloaded input file  ');  
disp('  3=Keyboard entry        ');
m = input('');
disp(' ')
clear grms;
clear n;
clear f;
clear a;
clear s;
clear THF;
clear ytickn;
%
if(m~=1 & m~=2)
    m=3;
end
%
if(m==1)
    [filename, pathname] = uigetfile('*.*');
    filename = fullfile(pathname, filename); 
    fid = fopen(filename,'r');
    THF = fscanf(fid,'%g %g',[2 inf]);
    THF=THF';   
    f=THF(:,1);
    a=THF(:,2);
    n=length(f);    
end
if(m==2)
    disp(' The input file must be pre-loaded into Matlab.')
    disp(' ')
    disp(' The input file must have two columns: frequency(Hz) & accel(G^2/Hz).')
    disp(' ')
    THF = input(' Enter the input PSD filename:  ');
    f=THF(:,1);
    a=THF(:,2);
    n=length(f);
end
if(m==3)
    n= input(' Enter the number of input points: ');
    disp(' ')
    disp(' The frequency unit is (Hz).  The amplitude unit is (G^2/Hz) ')
    disp(' ')
    for(i=1:n)
        out1=sprintf(' Enter frequency %d:  ',i);
        f(i)=input(out1);
        out2=sprintf(' Enter amplitude %d:  ',i);
        a(i)=input(out2);  
        disp(' ')
    end
end
disp(' ')
%
[s,grms]=calculate_PSD_slopes(f,a);
out5 = sprintf('\n Overall Acceleration = %10.3g GRMS',grms);
disp(out5);
%
plot(f,a)
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','off');
%
fmin=min(f);
fmax=max(f);
%
for(i=1:20)
    for(j=1:9)
        level = j*10^(i-10);
        fmax=level;
        if(level>=max(f))
            break;
        end
    end
    if(level>=max(f))
        break;
    end
end
%
for(i=1:20)
    for(j=1:9)
        level = j*10^(i-10);
        fmin=level;
        if(min(f)<=level)
            break;
        end
    end
    if(min(f)<=level)
            break;
    end  
end
%
if(fmin<10)
    fmin=10;
end
%
ymax=max(a);
ymin=min(a);
%
for(i=1:20)
    level = 10^(i-10);
    if(min(a) > level)
        ymin=level;
    end
end
%
for(i=1:20)
    level = 10^(10-i);
    if(max(a) < level)
        ymax=level;
    end
end
%
axis([fmin,fmax,ymin,(ymax*1.01)]);
%
ylabel('Accel (G^2/Hz)');   
xlabel('Frequency (Hz)');
out=sprintf(' Power Spectral Density %7.3g GRMS ',grms);
title(out);
%
set(gca,'XGrid','on','GridLineStyle',':');
set(gca,'YGrid','on','GridLineStyle',':');
%
if(fmin==20.)
    set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
    set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
else
    set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
    set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
end
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
set(gca,'ytick',ytickn);
%
nd=fix(log10(ymax/ymin));
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear f2;
clear a2;
clear s2;
clear grms2;
clear THF;
%
disp(' ');
disp(' Add another curve? ');
iac = input(' 1=yes  2=no ');
%
if(iac==1)
    disp(' ')
    disp(' Select data input method: ')
    disp('  1=Open external file    ');
    disp('  2=Preloaded input file  ');  
    disp('  3=Keyboard entry        ');
    m = input('');
    disp(' ')
%
    if(m~=1 & m~=2)
        m=3;
    end
%
    if(m==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename); 
        fid = fopen(filename,'r');
        THF = fscanf(fid,'%g %g',[2 inf]);
        THF=THF';   
        f2=THF(:,1);
        a2=THF(:,2);
        n2=length(f2);    
    end
    if(m==2)
        disp(' The input file must be pre-loaded into Matlab.')
        disp(' ')
        disp(' The input file must have two columns: frequency(Hz) & accel(G^2/Hz).')
        disp(' ')
        THF = input(' Enter the input PSD filename:  ');
        f2=THF(:,1);
        a2=THF(:,2);
        n2=length(f2);
    end
    if(m==3)
        n2= input(' Enter the number of input points: ');
        disp(' ')
        disp(' The frequency unit is (Hz).  The amplitude unit is (G^2/Hz) ')
        disp(' ')
        for(i=1:n2)
            out1=sprintf(' Enter frequency %d:  ',i);
            f2(i)=input(out1);
            out2=sprintf(' Enter amplitude %d:  ',i);
            a2(i)=input(out2);  
            disp(' ')
        end
    end
%
    [s2,grms2]=calculate_PSD_slopes(f2,a2);
    plot(f,a,f2,a2,'r')
    out =sprintf(' %7.3g GRMS ',grms);
    out2=sprintf(' %7.3g GRMS ',grms2);
    legend (out,out2); 
%        
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','off','YminorTick','off');
%
    ylabel('Accel (G^2/Hz)');   
    xlabel('Frequency (Hz)');
    out=sprintf(' Power Spectral Density ');
    title(out);
%
    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');
%
    fmin=min(f);
    if(fmin>min(f2))
        fmin=min(f2);
    end
%
    fmax=max(f);
    if(fmax<max(f2))
        fmax=max(f2);
    end
%
    ymin=min(a);
    if(ymin>min(a2))
        ymin=min(a2);
    end
%
    ymax=max(a);
    if(ymax<max(a2))
        ymax=max(a2);
    end
%
    ymax=ymax*2;
%
%    out1=sprintf(' ymin=%8.4g  ymax=%8.4g  ',ymin,ymax);
%    disp(out1);
%
    for(i=1:20)
        level = 10^(i-10);
        if(ymin < level)
            ymin=level/10; 
            break;
        end
    end
%
    for(i=1:20)
        level = 10^(i-10);
        if(ymax < level)
            ymax=level*10;  
            break;
        end
    end
%
    nd=fix(log10(ymax/ymin));
%    out1=sprintf(' nd=%8.4g  ymin=%8.4g  ymax=%8.4g  ',nd,ymin,ymax);
%    disp(out1);
%
    if(fmin==20.)
        set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
    else
        set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
        set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
    end
%
axis([fmin,fmax,ymin,(ymax*1.01)]);
%
clear ytickn;
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
end