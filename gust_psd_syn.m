disp(' ')
disp(' gust_psd_syn.m  version 4.4    November 16, 2012 ')
disp(' By Tom Irvine   Email: tom@vibrationdata.com ')
disp(' ')
%
close all;
%
fig_num=1;
%
clear a;
clear aa;
clear amp;
clear amp_spec;
%
clear b;
clear bb;
%
clear fft_freq;
clear fmax;
clear freq;
clear freq_spec;
clear fss;
%
clear length;
%
clear mag;
clear mmm;
%
clear noct;
clear np;
%
clear original_spec;
%
clear psd_th;
%
clear samp;
clear slope;
clear spec;
clear sum;
%
clear time_history;
clear tw;
clear THM;
clear TT;
%
clear Y;
clear YF;
%
clear z;
clear zz
%
tpi=2*pi;
%
disp(' This program synthesizes a time history to satisfy a Gust Velocity PSD.');
disp(' It also allows for superimposed sine tones. ');
disp(' ');
disp(' The PSD specification must be in a two-column matrix format: ')
disp(' Freq(Hz) & Velocity((ft/sec)^2/Hz) ')
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
if(THM(1,1)<1.0e-09)  % check for zero frequency
    THM(1,1)=10^(floor(-0.1+log10(THM(2,1))));
end
%
if(THM(1,2)<1.0e-30)  % check for zero amplitude
    noct=log(THM(2,1)/THM(1,1))/log(2);
    THM(1,2)=(noct/4)*THM(2,2);         % 6 db/octave 
end
%
nsz=max(size(THM));
freq=zeros(nsz+1,1);
amp=zeros(nsz+1,1);
%
k=1;
for i=1:nsz
    if(THM(i,1)>0)
        amp(k)=THM(i,2);
        freq(k)=THM(i,1);
        k=k+1;
    end
end
freq_spec=freq;
%
original_spec=THM;
%
min_dur=10/freq(1);
%
disp(' ');
tmax = input('  Enter the duration (sec) ');
%
if(tmax<min_dur)
%
    out1=sprintf('\n Warning: Recommended duration > %9.6g sec \n',min_dur);
    disp(out1);
    disp(' If recommended duration is too long, then increase initial ');
    disp(' specification frequency. ');
    disp(' ');
%
    tmax = input('  Enter new duration (sec) ');
%
end
%
disp(' ');
disp(' Enter random integer (seed)');
nq=input(' ');
for i=1:nq
    rand();
end
%
nss=length(freq);
%
freq(nsz+1)=freq(nsz)*2^(1/48);
amp(nsz+1)=amp(nsz);
%
[~,slope,vrms] = psd_syn_data_entry(freq,amp,tmax,nsz);
%
sr=20*max(freq_spec);
dt=1/sr;
spec_vrms=vrms;
%
freq=fix_size(freq);
 amp=fix_size(amp);
%
%  Plot Input PSD
%
[fig_num]=...
velox_PSD_plot(fig_num,original_spec,vrms,'Input Power Spectral Density');
%   
%  Generate White Noise 
%
[np,np2,noct,mmm,m2,N,df,white_noise,tw]=PSD_syn_white_noise(tmax,dt);
%
%  Interpolat PSD spec
%
[fft_freq,spec]=interpolate_PSD_spec(mmm,freq,amp,slope,df,vrms);
%
fmax=max(freq);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
mag=sqrt(spec);
%
nsegments = 1;
%
sq_spec=sqrt(spec);
%
[Y,psd_th,nL]=PSD_syn_FFT_core(nsegments,m2,N,fmax,df,sq_spec,white_noise);
%
[TT,psd_th]=PSD_syn_scale_time_history(psd_th,vrms,nL,dt,tmax);
%
[freq,amp,NW,df,mr_choice,h_choice,den,mH]=...
                       gust_PSD_syn_verify(TT,psd_th,spec_vrms,dt,freq(1));
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
nnt=3;
%
clear freq_spec;
clear amp_spec;
%
freq_spec=original_spec(:,1);
 amp_spec=original_spec(:,2);
%
[amp,dispx,full,tim]=...
    gust_PSD_syn_velox_correction(nnt,amp,dt,spec_vrms,mH,NW,freq_spec,...
                               amp_spec,df,mr_choice,h_choice,den,freq,TT);  
%
[amp,freq,full]=...
     gust_PSD_final_correction(amp,freq,full,freq_spec,amp_spec,den,...
                                                 NW,mH,mr_choice,h_choice);
%
freq=fix_size(freq);
full=fix_size(full);
[zmax,fmax]=find_max([freq full]);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
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
clear TT;
clear psd_TH;
%
TT=tim;
psd_TH=amp;
%
TT=fix_size(TT);
%
psd_TH=fix_size(psd_TH);
 dispx=fix_size(dispx);
%
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
	  writedata = [TT psd_TH ];
	  fid = fopen(writepfname,'w');
	  fprintf(fid,'  %10.6e \t %10.6e \n',writedata');
	  fclose(fid);
%%
end
%
[fig_num]=...
gust_psd_syn_output_plots(fig_num,TT,psd_TH,dispx,freq_spec,amp_spec,rms,freq,full);
%
out5 = sprintf(' Peak occurs at %10.5g Hz \n',fmax);
disp(out5)
%
%
clear time_history;
%
time_history=[TT psd_TH];
%
disp(' Write the PSD data to a file? ')
choice = input(' 1=yes 2=no ');
%
if(choice == 1)
   disp(' ');   
   disp(' Enter the output filename ');
   filename1 = input(' ','s');
   fid1 = fopen(filename1,'w');  
   for k=1:mH
      fprintf(fid1,'%11.4e \t %11.4e \n',freq(k), full(k));    
   end
   fclose(fid1);
end    
%
%  Rename matlab matrix with descriptive name
%
    clear power_spectral_density;
    power_spectral_density=[freq,full]; 
    out5 = sprintf('\n The PSD matrix is renamed as "power_spectral_density" ');
    disp(out5);     
%    
disp(' ')
disp(' The output time history is called "time_history" '); 