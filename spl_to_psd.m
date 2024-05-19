disp(' ')
disp(' spl_to_psd.m  version 1.3, July 9, 2018 ')
disp(' by Tom Irvine ')
disp(' Email:  tom@irvinemail.org ')
disp(' ')
%
disp(' This program converts a one-third octave SPL to a PSD')
disp(' ')
disp(' The input file must have two columns: freq(Hz) and level(dB) ')
%
clear db;
clear rms;
clear sum;
clear ms;
clear oadb;
clear THM;
clear fc;
clear spl;
clear length;
%
close all
%
fig_num=1;
%
disp(' ')
disp(' Select file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
file_choice = input('');
%
if(file_choice==1)
    [filename, pathname] = uigetfile('*.*');
    filename = fullfile(pathname, filename);
%      
    fid = fopen(filename,'r');
    THM = fscanf(fid,'%g %g',[2 inf]);
    THM=THM';        
%    
else
    THM = input(' Enter the matrix name:  ');
end
%
db=THM(:,2);
%
[oadb]=oaspl_function(db);
%
out1=sprintf('\n  Overall Level = %8.4g dB \n',oadb);
disp(out1)
disp('  ');
disp(' zero dB Reference = 20 micro Pascal ');
disp('  ');
%
figure(fig_num);
fig_num=fig_num+1;
%
plot(THM(:,1),THM(:,2));
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
grid on;
out1=sprintf(' One-Third Octave Sound Pressure Level  OASPL = %8.4g dB ',oadb);
title(out1)
xlabel(' Center Frequency (Hz) ');
ylabel(' SPL (dB) ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Select PSD dimension: ');
disp('  1=psi^2/Hz   2=Pascal^2/Hz   3= micro Pascal^2/Hz  ');
%
ipress=input(' ');
%
if(ipress==1)
    reference = 2.9e-09;
end
if(ipress==2)
    reference = 20.e-06;
end
if(ipress==3) 
    reference = 20.;
end
%
fc=THM(:,1);
spl=THM(:,2);
%
rms=0.;
%   
num=length(fc);
psd=zeros(num,1);
%
%
delta=(2.^(1./6.)) - 1./(2.^(1./6.));
%
for i=1:num    
%	
    if( spl(i) >= 1.0e-50)
%		
        pressure_rms=reference*(10.^(spl(i)/20.) );
%
		df=fc(i)*delta;
%
        if( df > 0. )	
            psd(i)=(pressure_rms^2.)/df;
			rms=rms+psd(i)*df;
        end
    end
end
%
power_spectral_density=[fc psd];
%
rms=sqrt(rms);
%
disp(' ');
disp(' The output array is: power_spectral_density ');
disp(' ');
%
if(ipress==1)
    disp(' Dimensions are: freq(Hz) & PSD(psi^2/Hz) ');
    ylab='Pressure (psi^2/Hz)';
    tstring=sprintf('Power Spectral Density  %8.4g psi rms overall',rms);
end
if(ipress==2)
    disp(' Dimensions are: freq(Hz) & PSD(Pascal^2/Hz) ');
    ylab='Pressure (Pascal^2/Hz)'; 
    tstring=sprintf('Power Spectral Density  %8.4g Pa rms overall',rms);    
end
if(ipress==3)
    disp(' Dimensions are: freq(Hz) & PSD(micro Pascal^2/Hz) ');
    ylab='Pressure (micro Pascal^2/Hz)';     
    tstring=sprintf('Power Spectral Density  %8.4g micro Pa rms overall',rms);    
end
%     
figure(fig_num);
fig_num=fig_num+1;
plot(fc,psd);
xlabel('Frequency (Hz)');
ylabel(ylab);
title(tstring);
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log')