%  coordinates_ss.m 
%  ver 1.4  December 3, 2012 
%  by Tom Irvine 
%
function [n,mina,maxa] = coordinates_ss(m,THF,mina,maxa,iflag)
%
disp(' ')
%
clear f;
clear a;
clear b;
clear n;
kflag=0;
%
sz=size(THF);
f=THF(:,1);
a=THF(:,2);
if(sz(2)==3)
    b=THF(:,3);
end
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
                kflag=1;
    end
    if(  a(i) <=0 )
                disp(' amplitude error ')
                out=sprintf(' a(%d) = %6.2f ',i,a(i));
                disp(out)
                kflag=1;
    end  
    if(  f(i+1) < f(i) )
                disp(' frequency error ')
                kflag=1;
    end  
    if(  kflag==1)
                break;
    end
%   
end
%
n=0;
%
if(m==1)
    MAX = 5000;
%
    ra=0.;
%
    s=zeros(1,MAX);
%
    for  i=1:nn
        s(i)=log10( a(i+1)/ a(i) )/log10( f(i+1)/f(i) );
%
        if(s(i) < -1.0001 ||  s(i) > -0.9999 )
            ra = ra + ( a(i+1) * f(i+1)- a(i)*f(i))/( s(i)+1.);
        else
            ra = ra + a(i)*f(i)*log( f(i+1)/f(i));
        end
    end
    grms=sqrt(ra);
    out5 = sprintf(' Power Spectral Density    %5.2f GRMS overall',grms);
    disp(out5)
    disp(' ');
end
%
if(m==3)
    disp(' ');
    disp(' Enter Y-axis label ');
    disp(' 1=GRMS  2=three sigma ');
    ijk=input(' ');
end
%
if(m==4)
%
    sum=0.;
%
    M=length(a);
%
    for i=1:M
%
	   rms = (10.^(a(i)/10));
	   sum=sum+rms;
    end
%
    oadb=10.*log10(sum);
%
    out1=sprintf('\n  Overall Level = %8.4g dB \n',oadb);
    disp(out1)
end
%
disp(' Plot the data? ')
choice = input(' 1=yes 2=no ');
%
if(choice == 1)
%
    if(m==2)
        disp(' ')
        Q=input(' Enter Q ');
        disp(' ');
    end
    if(m==3)
        disp(' ')
        Q=input(' Enter Q ');
        disp(' ');
    end   
%
    if(max(a)>maxa)
        maxa=max(a);
    end
    if(min(a)<mina)
        mina=min(a);
    end
    maxf=max(f);
    minf=min(f);
%
    figure(1);
    if(sz(2)==2)
        if(iflag==0)
            plot(f,a);
        else 
            plot(f,a,'r');           
        end
    else   
        plot(f,a,f,b);    
    end
    grid on;
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
    if(max(f)<=10000 && minf >=10)
        maxf=10000;
        set(gca,'xtick',[10 100 1000 10000]); 
    end
    if(max(f)<=5000 && minf >=10)
        maxf=5000;
        set(gca,'xtick',[10 100 1000 5000]);   
    end
    if(max(f)<=2000 && minf >=10)
        maxf=2000;
        set(gca,'xtick',[10 100 1000 2000]);      
    end
    if(max(f)<=1000 && minf >=10)
        maxf=1000;
        set(gca,'xtick',[10 100 1000]);      
    end
    if(max(f)<=500 && minf >=10)
        maxf=1000;
        set(gca,'xtick',[10 100 1000]);      
    end    
%
    if(max(f)<=10000 && minf >=20)
        maxf=10000;
        set(gca,'xtick',[20 100 1000 10000]);      
    end 
%
    if(max(f)<=2000 && minf >=20)
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
        set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');       
    end
    if(m==2)   
        if(sz(2)==3)
            legend ('positive','negative');       
        end
        xlabel(' Natural Frequency (Hz)'); 
        ylabel(' Peak Accel (G)');
        out5 = sprintf(' Acceleration Shock Response Spectrum Q=%g ',Q);    
        set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');         
    end
    if(m==3)     
        if(ijk==1)
            ylabel(' Accel (GRMS)');
        else
            ylabel(' Accel (3-sigma G)');     
        end
        xlabel(' Natural Frequency (Hz)');
        out5 = sprintf(' Vibration Response Spectrum Q=%g ',Q);    
        set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');         
    end   
    if(m==4)
        out5=sprintf(' One-Third Octave Sound Pressure Level  OASPL = %8.4g dB ',oadb);
        xlabel(' Center Frequency (Hz) ');
        ylabel(' SPL (dB) '); 
        set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin'); 
%        
        for j=200:-10:20
            if(maxa<j)
                ymax=j;
            end
        end
        for j=20:10:200
            if(mina>j)
                ymin=j;
            end
        end    
    end
%
    axis([minf,maxf,ymin,ymax]);  
    grid;  
    title(out5);
    zoom on;
end
disp(' ');
grid on;
%
disp(' Write data to ASCII text file? ')
choice = input(' 1=yes 2=no ');
%
if (choice == 1) 
   disp(' Enter output filename ');
   SRS_filename = input(' ','s');
%
   fid = fopen(SRS_filename,'w');
   for j=1:n
        if(sz(2)==2)
            fprintf(fid,'%g %g \n',f(j),a(j));
        else
            fprintf(fid,'%g %g %g \n',f(j),a(j),b(j));
        end
   end
   fclose(fid);
end
%