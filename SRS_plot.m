%
%  This script needs some further work to make all of its options fully functional.
%
disp(' ');
disp(' SRS_plot.m    version 1.3   March 17, 2009 ');
disp(' ');
disp(' by Tom Irvine ');
disp(' ');
disp(' This function plots one or more SRS functions in log-log format with a full grid. ');
disp(' ');
%
clear THF;
clear minf;
clear maxf;
clear ffmin;
clear ffmax;
clear f;
clear a;
clear an;
clear ap;
clear b;
clear ntype;
clear mm;
%
f=zeros(10,200);
ap=zeros(10,200); 
an=zeros(10,200);
%
disp(' Enter number of SRS functions ');
nc=input(' ');
%
if(nc>10)
    nc=10;
end
%
for (ij=1:nc)
%
    out5 = sprintf('\n ** SRS function %d ** \n',ij);
    disp(out5);
%
    clear THF;
%
    disp(' Enter type:  1=absolute    2=positive & negative ');
    ntype(ij)=input(' ');
%
    if(ntype(ij)~=1 & ntype(ij)~=2)
        ntype(ij)=1;
    end
%
    disp(' ')
    disp(' Select data input method: ')
    disp('  1=Open external file    ');
    disp('  2=Preloaded input file  ');  
    disp('  3=Keyboard entry        ');
%
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
%    
%%        if(ntype(ij)==1)
%%            THF = fscanf(fid,'%g %g',[2 inf]);
%%        else
%%            THF = fscanf(fid,'%g %g %g',[3 inf]);     
%%        end
%
        THF=load(filename);
%
    end       
%
    if(m==2)
        disp(' The input file must be pre-loaded into Matlab.')
        disp(' ')
        if(ntype(ij)==1)  
            disp(' The input file must have two columns:   natural frequency(Hz) & accel(G).')
        else
            disp(' The input file must have three columns: natural frequency(Hz) & pos accel(G) & neg accel(G).')
        end
        disp(' ')
        THF = input(' Enter the input SRS filename:  ');
%
    end
    if(m==3)
        n(ij)= input(' Enter the number of input points: ');
        disp(' ')
        disp(' The frequency unit is (Hz).  The amplitude unit is (G) ')
        disp(' ')
        for(i=1:n)
            out1=sprintf(' Enter frequency %d:  ',i);
            THF(i,1)=input(out1);
            out2=sprintf(' Enter amplitude %d:  ',i);
            THF(i,2)=input(out2);  
            disp(' ')
        end
    end
    if(m~=3)
%
        sz=size(THF);
        if(sz(2)==2)
            ntype(ij)=1;
        else
            ntype(ij)=2;
        end
%
    end
%
    sz=size(THF);
%
    mm=sz(1);
    if(mm>2000)
        mm=2000;
    end
    for(i=1:mm)
        f(ij,i)=THF(i,1);
        ap(ij,i)=THF(i,2);
        if(ntype(ij)==2)
            an(ij,i)=THF(i,3);
        end
    end
end    
%
minf=10000.;
maxf=1/minf;
srs_max=0;
srs_min=10000;
%
for(ij=1:nc) 
%
    if(f(ij,1)<minf)
        minf=f(ij,1);
    end  
    if(max(f(ij,:))>maxf)
        maxf=max(f(ij,:));
    end
%
    if(max(ap(ij,:))>srs_max)
        srs_max=max(ap(ij,:));
    end
    if(max(an(ij,:))>srs_max)
        srs_max=max(an(ij,:));
    end
%
end
%
for(ij=1:nc)
%
    mm(ij)=1;
    for(k=1:200)
        if(f(ij,k)==max(f(ij,:)))
            mm(ij)=k;
        end
    end
%
    for(k=1:mm(ij))
        if(min(ap(ij,k))<srs_min)
            srs_min=min(ap(ij,k));
        end  
    end
end    
%
disp(' ')
Q=input(' Enter Q  ');    
%
%  Plot SRS
%
disp(' ')
disp(' Plotting output..... ')
%
figure(1);
%
for(ij=1:nc)
    clear pf;
    clear pp;
    clear pn;
%
    for(j=1:mm(ij))
        pf(j)=f(ij,j);
        pp(j)=ap(ij,j);
        pn(j)=an(ij,j);   
    end
%
    if(ntype(ij)==1)        
        plot(pf,pp);
    else
        plot(pf,pp,pf,pn); 
        legend ('positive','negative');       
    end
    hold on;
end
%
ylabel('Peak Accel (G)');
%
xlabel('Natural Frequency (Hz)');
out5 = sprintf(' Shock Response Spectrum Q=%g ',Q);
title(out5);
grid;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
ffmin=minf;
ffmax=maxf;
%
for(i=1:10)
    if(minf<10^(5-i))
        ffmin=10^(4-i);
    end
end
%
for(i=0:10)
    fff=10^i;
    if(maxf>fff)
        ffmax=10*fff;
    end
    if(maxf==fff)
        ffmax=fff;
    end   
end
%
if(srs_min<1.0e-3)
    srs_min=1.0e-03;
end
if(srs_max<1.0e-2)
    srs_max=1.0e-02;
end
%
ymax= 10^(round(log10(srs_max)+0.8));
ymin= 10^(round(log10(srs_min)-0.6));
%
axis([ffmin,ffmax,ymin,ymax]);
grid on;
%
%  Encapsulated Postscript option
%
%      print -deps xyz.eps
%