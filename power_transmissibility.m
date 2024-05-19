disp(' ')
disp(' PSD.m ')
disp(' ver 2.3  January 25, 2011 ')
disp(' by Tom Irvine  Email: tomirvine@aol.com ')
disp(' ')
disp(' This program calculates the power spectral density ')
disp(' of a time history that is pre-loaded into Matlab. ')
disp(' ')
disp(' The time history must be in a two-column matrix format: ')
disp(' Time(sec)  & amplitude ')
disp(' ')
%
clear n;
clear Y;
clear amp;
clear tim;
clear N;
clear df;
clear dt;
clear Mag;
clear mag_seg;
clear full;
clear freq;
clear ss;
clear seg;
clear i_seg;
%
disp(' Select file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
disp('   3=Excel file ');
file_choice = input('');
%
if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%g %g',[2 inf]);
        THM=THM';
end
if(file_choice==2)
        THM = input(' Enter the matrix name:  ');
end
if(file_choice==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        THM = xlsread(xfile);
%         
end
%
amp=double(THM(:,2));
tim=double(THM(:,1));
n = length(amp);
%
mu=mean(amp);
sd=std(amp);
mx=max(amp);
mi=min(amp);
rms=sqrt(sd^2+mu^2);
%
disp(' ')
disp(' Input Time History Statistics ')
disp(' ')
tmx=max(tim);
tmi=min(tim);
% 
out3 = sprintf(' start  = %g sec    end = %g sec            ',tmi,tmx);
disp(out3)
%
out0 = sprintf(' number of points = %d ',n);
out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
disp(out0)
disp(out1)
%
dt=(tmx-tmi)/(n-1);
sr=1./dt;
df=1./(tmx-tmi);
disp(' ')
disp(' Time Step ');
dtmin=min(diff(tim));
dtmax=max(diff(tim));
%
out4 = sprintf(' dtmin  = %8.4g sec  ',dtmin);
out5 = sprintf(' dt     = %8.4g sec  ',dt);
out6 = sprintf(' dtmax  = %8.4g sec  ',dtmax);
disp(out4)
disp(out5)
disp(out6)
%
disp(' ')
disp(' Sample Rate ');
out4 = sprintf(' srmin  = %8.4g samples/sec  ',1/dtmax);
out5 = sprintf(' sr     = %8.4g samples/sec  ',1/dt);
out6 = sprintf(' srmax  = %8.4g samples/sec  \n',1/dtmin);
disp(out4)
disp(out5)
disp(out6)
%
ncontinue=1;
%
if(((dtmax-dtmin)/dt)>0.01)
    disp(' ')
    disp(' Warning:  time step is not constant.  Continue calculation? 1=yes 2=no ')
    ncontinue=input(' ')
end
if(ncontinue==1)
%
disp(' ')
disp(' mean removal? ');
mr_choice=input(' 1=yes   2=no  ' );
disp(' ')
%
disp(' ')
disp(' Select Window ')
h_choice = input(' 1=Rectangular 2=Hanning  ');
%
%%%%%%%%%%%%%%%  advise
%
NC=0;
for(i=1:1000)
%    
    nmp = 2^(i-1);
%   
    if(nmp <= n )
        ss(i) = 2^(i-1);
        seg(i) =n/ss(i);
        i_seg(i) = fix(seg(i));
        NC=NC+1;
    else
        break;
    end
end
%
disp(' ');
out4 = sprintf(' Number of   Samples per   Time per        df               ');
out5 = sprintf(' Segments     Segment      Segment(sec)   (Hz)      dof     ');
%
disp(out4)
disp(out5)
%        
for(i=1:NC)
    j=NC+1-i;
    if j>0
        if( i_seg(j)>0 )
%           str = int2str(i_seg(j));
            tseg=dt*ss(j);
            ddf=1./tseg;
            out4 = sprintf(' %8d \t %8d \t %10.3g  %10.3g \t %d',i_seg(j),ss(j),tseg,ddf,2*i_seg(j));
            disp(out4)
        end
    end
    if(i==12)
        break;
    end
end
%
disp(' ')
NW = input(' Choose the Number of Segments:  ');
disp(' ')
%
mmm = 2^fix(log(n/NW)/log(2));
%
df=1./(mmm*dt);
%
%%%  begin overlap
%
mH=((mmm/2)-1);
for ijk=1:mH
    full(ijk)=0;
    mag_seg(ijk)=0; 
end
nov=0;
for ijk=1:(2*NW-1)
%
    for kv=1:mmm
      amp_seg(kv)=amp(kv + nov);  
    end
    nov=nov+fix(mmm/2);
%
    [mag_seg]=FFT_core(amp_seg,mmm,mH,mr_choice,h_choice);
%    
    for nk=1:mH
       full(nk)=full(nk)+mag_seg(nk);
    end
end
%
den=df*(2*NW-1);
ms=0.;
for nk=1:mH
    full(nk)=full(nk)/den;
    freq(nk)=(nk-1)*df;
    ms=ms+full(nk);
end
%
rms=sqrt(ms*df);
%
disp(' ');
out4 = sprintf(' Overall RMS = %10.3g ',rms);
out5 = sprintf(' Three Sigma = %10.3g ',3*rms);
disp(out4)
disp(out5)
disp(' ');
%
fmax=0;
zmax=0;
for(i=1:length(full))
        if(full(i)>zmax)
            zmax=full(i);
            fmax=freq(i);
        end
end
%
out5 = sprintf(' Peak occurs at %10.5g Hz \n',fmax);
disp(out5)
%
disp(' Write the PSD data to a file? ')
choice = input(' 1=yes 2=no ');
%
if(choice == 1)
   disp(' ');   
   disp(' Enter the output filename ');
   filename1 = input(' ','s');
   fid1 = fopen(filename1,'w');  
   for(k=1:mH)
      fprintf(fid1,'%11.4e \t %11.4e \n',freq(k), full(k));    
   end
   fclose(fid1);
end    
%
disp(' ');
disp(' Plot the PSD? ')
choice = input(' 1=yes 2=no ');
%
if(choice == 1)
    figure(1);     
    plot(freq,full)
    xlabel(' Frequency (Hz)');
    ylabel(' Accel (G^2/Hz)'); 
    at = sprintf(' Power Spectral Density  Overall Level = %6.3g GRMS ',rms);   
    title(at);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log'); 
    grid;
%
    psd_max=max(full);
    psd_min=min(full); 
%    
    if(psd_max < 10000)
        ymax=10000;
    end
    if(psd_max < 1000)
        ymax=1000;
    end
    if(psd_max < 100)
        ymax=100;
    end
    if(psd_max < 10)
        ymax=10;
    end
    if(psd_max < 1)
        ymax=1;
    end
    if(psd_max < 0.1)
        ymax=0.1;
    end
    if(psd_max < 0.01)
        ymax=0.01;
    end
    if(psd_max < 0.001)
        ymax=0.001;
    end
    if(psd_max < 0.0001)
        ymax=0.0001;
    end
    if(psd_max < 0.00001)
        ymax=0.00001;
    end
%
    ymin=ymax/100;    
    if(psd_min < psd_max/1000)
       ymin=ymax/1000;    
    end 
    if(psd_min < psd_max/1000)
       ymin=ymax/1000;    
    end    
    fmax=max(freq);
    set(gca, 'XTickMode', 'manual');
%
    pfmax=10000;
    set(gca,'xtick',[10 100 1000 10000]); 
%
    pfmax=fmax;
    if(fmax<10000)
        pfmax=10000;
        set(gca,'xtick',[10 100 1000 10000]); 
    end
    if(fmax<5000)
        pfmax=5000;
        set(gca,'xtick',[10 100 1000 5000]);   
    end
    if(fmax<2000)
        pfmax=2000;
        set(gca,'xtick',[10 100 1000 2000]);      
    end
    if(fmax<1000)
        pfmax=1000;
        set(gca,'xtick',[10 100 1000]);      
    end
    fmin=df;
    axis([fmin,pfmax,ymin,ymax]);  
%
    disp(' ');
    disp(' Plot the PSD with a specification superimposed? ')
    choice = input(' 1=yes 2=no ');
%
    if(choice == 1)
%
        disp('');
        disp(' Select file input method ');
        disp('   1=external ASCII file ');
        disp('   2=file preloaded into Matlab ');
        file_choice = input('');
%
        if(file_choice==1)
%%
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);  
%%
%    disp(' Enter the input filename ');
%    filename = input(' ','s');
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%g %g',[2 inf]);
        THM=THM';
    else
        THM = input('  Enter the matrix name:  ');
    end
%
    THM(:,2);
    THM(:,1);
    disp(' ')
 %           
    figure(2);   
    plot(freq,full,THM(:,1),THM(:,2),'r');
    legend ('Synthesis','Specification');
    axis([fmin,pfmax,ymin,ymax]);    
    xlabel(' Frequency (Hz)');
    ylabel(' Accel (G^2/Hz)'); 
    at = sprintf(' Power Spectral Density  Overall Level = %6.3g GRMS ',rms);   
    title(at);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log'); 
    grid;
end
end
%
%  Rename matlab matrix with descriptive name
%
    clear power_spectral_density;
    power_spectral_density=[freq;full]'; 
    out5 = sprintf('\n\n The PSD matrix is renamed as "power_spectral_density" ');
    disp(out5);   
%    
end