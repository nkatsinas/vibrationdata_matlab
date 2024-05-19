disp(' ')
disp(' coordinates.m   ver 1.4   March 18, 2009')
disp(' by Tom Irvine   Email: tomirvine@aol.com')
disp(' ')
disp(' This progam sets up a coordinate table interactively.')
disp(' for a PSD or SRS.  It also plots these functions.')
disp(' ')
%
clear f;
clear a;
clear m;
clear n;
clear THF;
clear table;
%
disp(' Select function: 1=PSD  2=SRS ');
m=input(' ');
disp(' ');
if(m==2)
   disp(' ')
   Q=input(' Enter Q ');
end
%
disp(' Select data input method ')
disp('  1=data preloaded in matlab ')  
disp('  2=keyboard entry ');
disp('  3=external ASCII file ');
%
method=input('');                 
disp(' ')
%
if(method==1)
    THF = input(' Enter the input filename:  ');
    f=THF(:,1);
    a=THF(:,2);
    n=length(f);
    table=[f ; a]' 
end   
if(method==2)
    n=input(' Input the number of coordinates  ');	
%
    for(i=1:n)
        if(m==1)
            out = sprintf('\n Enter Frequency %ld ',i);
        else
            out = sprintf('\n Enter Natural Frequency %ld ',i);      
        end
        disp(out);
        f(i)=input('');
%
        out = sprintf('\n Enter amplitude %ld ',i);
        disp(out);
        a(i)=input('');  
    end
    table=[f ; a]'  
end
if(method==3)
    clear a;
    clear b;
    disp(' Enter the input filename ');
    filename = input(' ','s');
    fid = fopen(filename,'r');
    THF=load(filename);
    f=THF(:,1);
    a=THF(:,2);
    sz=size(THF);
    if(sz(2)==2)
        table=[f , a]
    else
        b=THF(:,3);
        table=[f , a, b]  
    end 
end 
% 
out11=sprintf('\n\n The data is stored in a matrix called "table" \n');
disp(out11);
%
disp(' Plot the data? ')
choice = input(' 1=yes 2=no ');
%
if(choice == 1)
%
    if(m==1)
        MAX = 5000;
%
        ra=0.;
        grms=0.;
        iflag=0;
%
        s=zeros(1,MAX);
%
        nn=length(f)-1;
%
        for  i=1:nn
            if(f(i) < .0001)
                f(i)=.0001;
            end
%
            if(  f(i) <=0 )
                disp(' frequency error ')
                out=sprintf(' f(%d) = %6.2f ',i,f(i));
                disp(out)
                iflag=1;
            end
            if(  a(i) <=0 )
                disp(' amplitude error ')
                out=sprintf(' a(%d) = %6.2f ',i,a(i));
                disp(out)
                iflag=1;
            end  
            if(  f(i+1) < f(i) )
                disp(' frequency error ')
                iflag=1;
            end  
            if(  iflag==1)
                break;
            end
%    
            s(i)=log10( a(i+1)/ a(i) )/log10( f(i+1)/f(i) );
%   
        end
 %
 %disp(' RMS calculation ');
 %
 if( iflag==0)
    for i=1:nn
        if(s(i) < -1.0001 |  s(i) > -0.9999 )
            ra = ra + ( a(i+1) * f(i+1)- a(i)*f(i))/( s(i)+1.);
        else
            ra = ra + a(i)*f(i)*log( f(i+1)/f(i));
        end
    end
    grms=sqrt(ra);
end
    end
%
    maxa=max(a);
    mina=min(a);
    maxf=max(f);
    minf=min(f);
%
    figure(1);
    sz=size(table);
    if(sz(2)==2)
        plot(f,a);
    else
        plot(f,a,f,b);
    end
%
    if  min(f) >= 0.1
        minf=0.1;
    end
    if  min(f) >= 1
        minf=1;
    end
    if  min(f) >= 10
        minf=10;
    end
      if  min(f) >= 20
        minf=20;
    end
    if  min(f) >= 100
        minf=100;
    end
%
    if(max(f)<=10000 & minf >=10)
        maxf=10000;
        set(gca,'xtick',[10 100 1000 10000]); 
    end
    if(max(f)<=5000 & minf >=10)
        maxf=5000;
        set(gca,'xtick',[10 100 1000 5000]);   
    end
    if(max(f)<=2000 & minf >=10)
        maxf=2000;
        set(gca,'xtick',[10 100 1000 2000]);      
    end
    if(max(f)<=1000 & minf >=10)
        maxf=1000;
        set(gca,'xtick',[10 100 1000]);      
    end
    if(max(f)<=500 & minf >=10)
        maxf=1000;
        set(gca,'xtick',[10 100 1000]);      
    end    
    if(max(f)<=2000 & minf >=20)
        maxf=2000;
        set(gca,'xtick',[20 100 1000 2000]);      
    end
%
    ymax= 10^(round(log10(maxa)+0.8));
    ymin= 10^(round(log10(mina)-0.6));
%
    if(m==1)
        xlabel(' Frequency (Hz)');
        ylabel(' Accel (G^2/Hz)');
        out5 = sprintf(' Power Spectral Density    %5.2f GRMS overall',grms);    
    else
        xlabel(' Natural Frequency (Hz)'); 
        ylabel(' Peak Accel (G)');
        out5 = sprintf(' Acceleration Shock Response Spectrum Q=%g ',Q);  
        if(sz(2)==3)
            legend ('positive','negative');       
        end
    end
%
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');    
%
    axis([minf,maxf,ymin,ymax]);  
    grid;  
    title(out5);
    zoom on;
end
disp(' ');
%
disp(' Write data to ASCII text file? ')
choice = input(' 1=yes 2=no ');
%
if (choice == 1) 
   disp(' Enter output filename ');
   SRS_filename = input(' ','s');
%
   fid = fopen(SRS_filename,'w');
   n=max(size(f));
   for j=1:n
        if(sz(2)==2)
            fprintf(fid,'%g %g \n',f(j),a(j));
        else
            fprintf(fid,'%g %g %g \n',f(j),a(j),b(j));          
        end
   end
   fclose(fid);
end