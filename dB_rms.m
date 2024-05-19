disp(' ')
disp('  dB_RMS.m  version 1.2, July 2, 2007 ')
disp('  by Tom Irvine ')
disp('  Email:  tomirvine@aol.com ')
%
disp(' This program calculates the overall dB value for a one-third octave SPL')
disp(' ')
disp(' The input file must have two columns: freq(Hz) and level(dB) ')
%
clear db;
clear rms;
clear sum;
clear ms;
clear oadb;
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
rms=0.;
ms=0.;
sum=0.;
%

%
out1=sprintf('\n  Overall Level = %8.4g dB \n',oadb);
disp(out1)
plot(THM(:,1),THM(:,2));
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
grid on;
out1=sprintf(' One-Third Octave Sound Pressure Level  OASPL = %8.4g dB ',oadb);
title(out1)
xlabel(' Center Frequency (Hz) ');
ylabel(' SPL (dB) ');