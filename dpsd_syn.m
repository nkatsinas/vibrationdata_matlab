disp(' ')
disp(' dpsd_syn.m  version 1.0    January 11, 2011 ')
disp(' By Tom Irvine   Email:  tomirvine@aol.com ')
disp(' ')
%
clear a;
clear b;
clear aa;
clear bb;
clear sum;
clear amp;
clear freq;
clear fft_freq;
clear Y;
clear z;
clear psd_th;
clear slope;
clear spec;
clear THM;
clear TT;
clear zz;
clear length;
clear freq;
clear amp;
clear slope;
clear fss;
clear samp;
clear fslope;
clear original_spec;
%
rand('state',sum(100*clock));
tpi=2.*pi;
%
disp(' This program synthesizes a time history to satisfy a PSD ');
disp(' ')
disp(' The Displacement PSD specification must be in a two-column matrix format: ')
disp(' Freq(Hz) & Disp(m^2/Hz) ')
disp(' ')
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
nsz=max(size(THM));
k=1;
for(i=1:nsz)
    if(THM(i,1)>0)
        amp(k)=THM(i,2);
        freq(k)=THM(i,1);
        k=k+1;
    end
end
%
original_spec=THM;
%
disp(' ')
tmax = input('  Enter the duration (sec) ');
%
clear length;
nss=length(freq);
%
damp=amp;
[dt,freq,amp,slope,arms,drms] = dpsd_syn_data_entry(freq,amp,tmax);
%
disp(' ');
disp('  Input PSD Overall Level ');
out3 = sprintf('\n    Displacement = %5.3g meters RMS',drms);
disp(out3)
out4 = sprintf('\n    Acceleration = %5.3g (m/sec^2) RMS',arms);
disp(out4)
%
mmm=max(size(freq));
%
samp=zeros(1,1+mmm);
fss=zeros(1,1+mmm);  
fslope=zeros(1,mmm);   
samp(1)=amp(1);   
fss(1)=freq(1)*(1/(2^(1/6)));  % 1/3 octave lower limit for band
%
for(j=1:mmm)
       samp(j+1)=amp(j);
       fss(j+1)=freq(j);
end
%
for(j=1:mmm-1)
       fslope(j+1)=slope(j);
end
%
nnn=log(samp(2)/samp(1));
ddd=log(fss(2)/fss(1));
ratio=nnn/ddd;
fslope(1)=ratio;
%
freq=fss;
amp=samp;
slope=fslope;
%   
%  White noise 
%
np=tmax/dt;
out5 = sprintf('\n samples = %g',np);
disp(out5)
%
TT=linspace(0,np*dt,(np+1)); 
a = zeros(1,(np+1));
%     
np2=2*np;
[white_noise] = psd_syn_white(dt,tmax,np2);   
white_noise=white_noise';
%
nu=16;
mmm=2^nu;
for(i=1:nu)  %% 2^16 = 65536
      if( 2^i > np2 )
           mmm=2^i;
           break;
      end
end  
%
out5 = sprintf('\n Calculating FFT ');
disp(out5)
%
N=mmm;
df=1./(N*dt);
out5 = sprintf('\n df = %g Hz',df);
disp(out5)
%
mlast=length(freq);
slope(mlast)=0;
samp(mlast+1)=samp(mlast);
freq(mlast+1)=freq(mlast)*2^(1/48);
%
out5 = sprintf('\n Interpolating specification ');
disp(out5);
m2=fix(mmm/2);
%
fft_freq = linspace(0,(m2-1)*df,m2);
fft_freq = fft_freq';
%
spec=zeros(mmm,1);
js=1;
LS=length(freq);
%
for(i=1:m2)
%       
      for(j=js:(LS-1))
%            
	     if( fft_freq(i) >= freq(j) & fft_freq(i) < freq(j+1) )
%				
              fr = (fft_freq(i)/freq(j) );
	          spec(i)=amp(j)*( fr^slope(j) );        
%
              js=j;
		      break;
         end
%
         if( fft_freq(i) == freq(j+1))
              spec(i)=amp(LS+1);
              break;
         end 
%
      end
end
fmax=max(freq);
%
figure(1);
plot(fft_freq,spec(1:m2));
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log'); 
grid;
title(out4);
xlabel(' Frequency (Hz)');
ylabel(' Accel ((m/sec^2)^2/Hz)'); 
%
mag=sqrt(spec);
%
nsegments = round((np/mmm)+0.5);
%
nnn=0;
%
N=mmm;
%
ns=sqrt(-1);
%
clear theta;
%
sq_spec=sqrt(spec);
%
for(i=1:nsegments)
       Y = fft(white_noise(1+nnn:mmm+nnn),N);
%
       theta=angle(Y(1:mmm));
%       SMAG=abs(Y);
       Y=sq_spec.*cos(theta) + ns*sq_spec.*sin(theta);
%
%      Make symmetric
%
       for(j=1:m2)
          fff=(j-1)*df;
          if(fff<fmax)
          else
              Y(j)=0.;
          end
       end
%
       for(j=1:(m2-1))             
          Y(mmm+1-j)=Y(j)*(1-ns);
       end
%
       psd_th(1+nnn:mmm+nnn) = real(ifft(Y));
%
       nnn=nnn+mmm;
end
%  
nL=length(psd_th);
%   
TT=linspace(0,nL*dt,nL);
%
clear new_TT;
clear new_psd_th;
%
if(max(TT)>tmax)
    nnn=round(tmax/dt);
    new_TT=TT(1:nnn);
    new_psd_th=psd_th(1:nnn);
%
    clear TT;
    clear psd_th;
%
    TT=new_TT;
    psd_th=new_psd_th;
%
end
%
out5 = sprintf('\n scale time history ');
disp(out5)   
%
%  scale th
%
mu=mean(psd_th);
stddev=std(psd_th);
grmsout = sqrt(mu^2+stddev^2);
%
scale=grms/grmsout;
psd_th=psd_th*scale;
%
%  Output
%
mu=mean(psd_th);
sd=std(psd_th);
mx=max(psd_th);
mi=min(psd_th);
rms=sqrt(sd^2+mu^2);
%
disp(' ')
n=length(psd_th);
out0 = sprintf(' number of points = %d ',n);
out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g \n',mu,sd,rms);
out2 = sprintf(' max  = %9.4g  ',mx);
out3 = sprintf(' min  = %9.4g  \n',mi);
%
disp(out0);
disp(out1);
disp(out2);
disp(out3);
%
disp(' ')
disp(' Select output options ');
disp(' ' );
disp(' Output time history file to ASCII text? ');
choice=input(' 1=yes  2=no  ' );
disp(' ')
%
if choice == 1 
%%
      [writefname, writepname] = uiputfile('*','Save data as');
	  writepfname = fullfile(writepname, writefname);
	  writedata = [TT' psd_th' ];
	  fid = fopen(writepfname,'w');
	  fprintf(fid,'  %g  %g \n',writedata');
	  fclose(fid);
%%
%        disp(' Enter output filename ');
%        g_filename = input(' ','s');
%
%        fid = fopen(g_filename,'w');
%        for j=1:np
%            fprintf(fid,'%12.5e %10.4e \n',TT(j),psd_th(j));
%        end
%        fclose(fid);
end
%
disp(' Plot time history in Matlab? ');
mchoice=input(' 1=yes  2=no  ' );
if mchoice == 1 
    figure(2);
    plot(TT,psd_th);
    grid on;
%    
    out5 = sprintf(' Synthesized Time History   std dev=%8.3g ',std(psd_th));
    title(out5);   
    ylabel(' Accel (G)');
    xlabel(' Time (sec)');
    disp(' ')
    disp(' Plot histogram? ')
    hchoice = input(' 1=yes 2=no ');
%
    if(hchoice == 1)
        while(1)
            clear x;
            nbar=input(' Enter the number of bars ');
            xx=max(abs(psd_th));
            x=linspace(-xx,xx,nbar);       
            figure(3);    
            hist(psd_th,x)
            ylabel(' Counts');
            xlabel(' Accel (G)');  
            title(' Histogram '); 
            disp(' Re-plot with different number of bars? ');
            disp(' 1=yes  2=no ');
            irp=input(' ');
            if(irp==2)
                break;
            end
        end
    end   
end    
%
clear time_history;
time_history=[TT;psd_th]'; 
%
%
disp(' ');
disp(' Calculate the resulting PSD?  1=yes 2=no ');
ipsd=input(' ');
%
if(ipsd==1)
disp(' ')
disp(' PSD.m ')
disp(' ver 2.0  November 3, 2008 ')
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
THM = time_history;
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
NW = input(' Choose the Number of Segments from the first column:  ');
disp(' ')
%
mmm = 2^fix(log(n/NW)/log(2));
%
df=1./(mmm*dt);
%
%%%  begin overlap
%
mH=((mmm/2)-1);
%
full=zeros(mH,1);
mag_seg=zeros(mH,1);
%
nov=0;
%
clear amp_seg
%
for ijk=1:(2*NW-1)
%
    amp_seg=zeros(mmm,1);
%
    amp_seg(1:mmm)=amp((1+ nov):(mmm+ nov));  
%
    nov=nov+fix(mmm/2);
%
    [mag_seg]=FFT_core(amp_seg,mmm,mH,mr_choice,h_choice);
%
    sz=size(mag_seg);
    if(sz(2)>sz(1))
        mag_seg=mag_seg';
    end
%
    full=full+mag_seg(1:mH);
end
%
den=df*(2*NW-1);
ms=0.;
fmax=(mH-1)*df;
freq=linspace(0,fmax,mH);
full=full/den;
clear sum;
ms=sum(full);
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
    figure(4);     
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
    disp(' Plot the PSD with the specification superimposed? ')
%    choice = input(' 1=yes 2=no ');
    choice=1;
%
    THM=original_spec;
%
    disp(' ')
 %           
    figure(5);   
    plot(freq,full,'b',THM(:,1),THM(:,2),'r');
    legend ('Synthesis','Specification');
    if(ymax< max(THM(:,2)) )
        ymax= max(THM(:,2));
    end   
    if(ymax< full )
        ymax= full;
    end     
    if(ymin>  min(THM(:,2)) )
        ymin = min(THM(:,2)) ;
    end  
 %   
    axis([fmin,pfmax,ymin,ymax]);    
    xlabel(' Frequency (Hz)');
    ylabel(' Accel (G^2/Hz)'); 
    at = sprintf(' Power Spectral Density  Overall Level = %6.3g GRMS ',rms);   
    title(at);
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log'); 
    grid;
%
    disp(' ');
    disp(' Add tolerance bands: + and - 1.5 dB? ')
    disp(' 1=yes  2=no ')
    ib=input(' ');
    if(ib==1)
        hold on;
        plot(THM(:,1),sqrt(2)*THM(:,2),'k',THM(:,1),THM(:,2)/sqrt(2),'k');
        if(ymax< max(sqrt(2)*THM(:,2)) )
            ymax= max(sqrt(2)*THM(:,2));
        end
        if(ymin>  min(THM(:,2)/sqrt(2)) )
            ymin = min(THM(:,2)/sqrt(2));
        end
        fmin=min(THM(:,1));
        fmax=max(THM(:,1));
%
        if(fmin==20. & fmax==2000.)
            set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
            set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
        end
        if(fmin==10. & fmax==2000.)
            set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
            set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
        end
%
        axis([fmin,fmax,ymin,ymax]);  
        hold off;
    end
%
end
end
%
%  Rename matlab matrix with descriptive name
%
    clear power_spectral_density;
    sz=size(freq);
    if(sz(2)>sz(1))
        freq=freq';
    end
    sz=size(full);
    if(sz(2)>sz(1))
        full=full';    
    end
    power_spectral_density=[freq,full]; 
    out5 = sprintf('\n The PSD matrix is renamed as "power_spectral_density" ');
    disp(out5);     
%    
end
disp(' ')
disp(' The output time history is called "time_history" '); 
