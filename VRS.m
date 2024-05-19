disp(' ')
disp(' VRS.m   ver 2.0   September 24, 2013')
disp(' by Tom Irvine   Email: tom@vibrationdata.com')
disp(' ')
disp(' This program calculates the vibration response spectrum')
disp(' of an acceleration power spectral density. ')
disp(' ')
disp(' The power spectral density may vary arbitrarily with frequency. ')
disp(' The input file must have two columns: frequency(Hz) & accel(G^2/Hz)')
disp(' ')
%
close all;
%
clear f;
clear a;
clear s;
clear fn;
clear fns;
clear a_vrs;
clear pv_vrs;
clear rd_vrs;
clear three_sigma;
clear n_sigma;
%
fig_num=1;
%
%%%%%%%%
%
%
while(1)
    disp(' Select units ');
    disp('  1=English: accel(G), vel(in/sec),  disp(in)  ');
    disp('  2=metric : accel(G),  vel(cm/sec),  disp(mm)  ');
    iu=input(' ');
    if(iu==1 || iu==2)
        break;
    end
end
%
%
disp(' ')
disp(' Select file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
disp('   3=library PSD ');
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
if(file_choice==1 || file_choice==2)
    f=THM(:,1);
    a=THM(:,2);
end
if(file_choice==3)
    [f,a]=PSD_library();
end
%
disp(' ')
%%%%%%%%
MAX = 5000;
tpi=2.*pi;
%
idamp=input(' Enter damping format:  1= damping ratio   2= Q  ');	
%
disp(' ')
if(idamp==1)
    damp=input(' Enter damping ratio (typically 0.05) ');
else
    Q=input(' Enter the amplification factor (typically Q=10) ');
    damp=1./(2.*Q);
end
%
n=length(f);
%
[s,grms]=calculate_PSD_slopes(f,a);
out5 = sprintf('\n Input PSD Overall Level = %10.3f GRMS\n',grms);
disp(out5);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
plot(f,a);
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
ylabel('Accel (G^2/Hz)');   
xlabel('Frequency (Hz)');
out=sprintf(' Power Spectral Density %7.3g GRMS ',grms);
title(out);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
df=1.;
%
[fi,ai]=interpolate_PSD(f,a,s,df);
%
[fn,a_vrs,rd_vrs]=vrs_engine(fi,ai,damp,df,iu);
%
disp(' ')
Q=1./(2.*damp);
%
disp(' ');
fmin=input(' Enter starting plot frequency (Hz) ');
fmax=input(' Enter   ending plot frequency (Hz) ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
plot(f,a);
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
ylabel('Accel (G^2/Hz)');   
xlabel('Frequency (Hz)');
out=sprintf(' Power Spectral Density %7.3g GRMS ',grms);
title(out);
if(round(fmin)==20 && round(fmax)==2000)
    set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
    set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
end
if(round(fmin)==10 && round(fmax)==2000)
    set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
    set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
end
xlim([fmin fmax]);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(' ');
duration=input(' Enter duration (sec) ');
%
clear length;
NL=length(fn);
%
pv_vrs=zeros(NL,1);
%
sz=size(fn);
if(sz(2)>sz(1))
    fn=fn';
end
%
sz=size(a_vrs);
if(sz(2)>sz(1))
    a_vrs=a_vrs';
end
%
sz=size(rd_vrs);
if(sz(2)>sz(1))
    rd_vrs=rd_vrs';
end
%
clear avrs;
avrs=[fn a_vrs];
clear rdvrs;
rdvrs=[fn rd_vrs];
%
for i=1:NL
    pv_vrs(i)=2*pi*fn(i)*rd_vrs(i);
end
%
if(iu==2)
    pv_vrs=pv_vrs/10.;
end
%
clear pvvrs;
pvvrs=[fn pv_vrs];
%
%  Maximum expect peak from Rayleigh distribution
%
j=1;
for i=1:NL
    if(fn(i)>=min(f) && fn(i)<=max(f))
        c=sqrt(2*log(fn(i)*duration));
        ms=(c+0.5772/c);
        accel_vrs_peak(j,:)=[fn(i)  ms*a_vrs(i)];
           pv_vrs_peak(j,:)=[fn(i) ms*pv_vrs(i)];
           rd_vrs_peak(j,:)=[fn(i) ms*rd_vrs(i)];
           j=j+1;        
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
accel_vrs_1_sigma=[fn a_vrs];
accel_vrs_3_sigma=[fn 3*a_vrs];
 
   pv_vrs_1_sigma=[fn pv_vrs];
   pv_vrs_3_sigma=[fn 3*pv_vrs];
 
   rd_vrs_1_sigma=[fn rd_vrs];
   rd_vrs_3_sigma=[fn 3*rd_vrs];

figure(fig_num);
fig_num=fig_num+1;
plot(accel_vrs_peak(:,1),accel_vrs_peak(:,2),fn,3*a_vrs,fn,a_vrs);
legend('peak','3-sigma','1-sigma');
xlabel('Natural Frequency (Hz)');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
out1 = sprintf(' Acceleration Vibration Response Spectrum Q=%g ',Q);
title(out1);
% 
xlim([fmin fmax]);
%
ylab='Accel (G)';
ylabel(ylab);
%
if(round(fmin)==20 && round(fmax)==2000)
    set(gca,'xtick',[20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
    set(gca,'XTickLabel',{'20';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})
end
if(round(fmin)==10 && round(fmax)==2000)
    set(gca,'xtick',[10 20 30 40 50 60 70 80 90 100 200 300 400 500 600 700 800 900 1000 2000])
    set(gca,'XTickLabel',{'10';'';'';'';'';'';'';'';'';'100';'';'';'';'';'';'';'';'';'1000';'2000';})   
end
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
figure(fig_num);
fig_num=fig_num+1;
plot(pv_vrs_peak(:,1),pv_vrs_peak(:,2),fn,3*pv_vrs,fn,pv_vrs);
legend('peak','3-sigma','1-sigma');
xlabel('Natural Frequency (Hz)');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
out1 = sprintf(' Pseudo Velocity Vibration Response Spectrum Q=%g ',Q);
title(out1);
ymax=10^(ceil(log10(max(pv_vrs_peak(:,2)))));
ymin=ymax/1000;
xlim([fmin fmax]);
ylim([ymin ymax]);
if(iu==1)
    ylab='PV (in/sec)';
else
    ylab='PV (cm/sec)';    
end
ylabel(ylab);
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
figure(fig_num);
fig_num=fig_num+1;
plot(rd_vrs_peak(:,1),rd_vrs_peak(:,2),fn,3*rd_vrs,fn,rd_vrs);
legend('peak','3-sigma','1-sigma');
xlabel('Natural Frequency (Hz)');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
out1 = sprintf(' Relative Displacement Vibration Response Spectrum Q=%g ',Q);
title(out1);
ymax=10^(ceil(log10(max(rd_vrs_peak(:,2)))));
ymin=ymax/1000;
xlim([fmin fmax]);
ylim([ymin ymax]);
if(iu==1)
    ylab='Rel Disp (in)';
else
    ylab='Rel Disp (mm)';    
end
ylabel(ylab);
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ')
disp(' Write acceleration GRMS VRS to text file? ')
choice=input(' 1=yes   2=no  ' );
disp(' ')
%
if choice == 1 
   disp(' Enter output filename ');
   VRS_filename = input(' ','s');
   disp(' ')
   disp(' Output units:  fn(Hz)  &  Accel (GRMS) '); 
   jnum = max(size(fn));
   fid = fopen(VRS_filename,'w');
   for j=1:jnum
        fprintf(fid,'%7.2f %11.4g \n',fn(j),a_vrs(j));
   end
   fclose(fid);
end
%
disp(' ')
disp(' Write acceleration 3-sigma VRS to text file? ')
choice=input(' 1=yes   2=no  ' );
disp(' ')
%
if choice == 1 
   disp(' Enter output filename ');
   VRS_filename = input(' ','s');
   disp(' ')
   disp(' Output units:  fn(Hz)  &  Accel (3-sigma G) '); 
   jnum = max(size(fn));
   fid = fopen(VRS_filename,'w');
   for j=1:jnum
        fprintf(fid,'%7.2f %11.4g \n',accel_vrs_3_sigma(j,1),accel_vrs_3_sigma(j,2));
   end
   fclose(fid);
end
%
disp(' ')
disp(' Write acceleration n-sigma VRS to text file? ')
choice=input(' 1=yes   2=no  ' );
disp(' ')
%
if choice == 1 
   disp(' Enter output filename ');
   VRS_filename = input(' ','s');
   disp(' ')
   disp(' Output units:  fn(Hz)  &  Accel (n-sigma G) '); 
   jnum = max(size( accel_vrs_peak));
   fid = fopen(VRS_filename,'w');
   for j=1:jnum
        fprintf(fid,'%7.2f %11.4g \n', accel_vrs_peak(j,:),accel_vrs_peak(j,:));
   end
   fclose(fid);
end
%
disp(' ');
disp(' Matlab array names: ');
disp('  ');
disp('           avrs - fn(Hz)     Accel VRS(GRMS) ');
disp(' accel_vrs_peak - fn(Hz)     Accel VRS(Gpeak)');
disp('  ');
%
if(iu==1)
    disp('       pvvrs - fn(Hz)  Pseudo Vel VRS(inch/sec RMS) ');
    disp(' pv_vrs_peak - fn(Hz)  Pseudo Vel VRS(inch/sec peak)');    
    disp('  ');    
    disp('       rdvrs - fn(Hz)  Rel Disp VRS(inch RMS) ');
    disp(' rd_vrs_peak - fn(Hz)  Rel Disp VRS(inch peak)');    
else
    disp('       pvvrs - fn(Hz)  Pseudo Vel VRS(cm/sec RMS) ');
    disp(' pv_vrs_peak - fn(Hz)  Pseudo Vel VRS(cm/sec peak)');       
    disp('  ');     
    disp('       rdvrs - fn(Hz)  Rel Disp VRS(mm RMS) ');
    disp(' rd_vrs_peak - fn(Hz)  Rel Disp VRS(inch peak)');       
end