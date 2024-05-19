%
%  enter_spl.m  ver 1.1  by Tom Irvine
%
function[THM,oadb,delta,fig_num]=enter_spl(fig_num)
%
disp(' The input file must have two columns: freq(Hz) and level(dB) ');
disp(' ');
disp(' It must be in one-third octave format.');
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
        FS = input(' Enter the matrix name:  ','s');
        THM=evalin('caller',FS);
end
if(file_choice==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        THM = xlsread(xfile);
%         
end
%
db=THM(:,2);
%
[oadb]=oaspl_function(db);
%
delta=(2.^(1./6.)) - 1./(2.^(1./6.));
%
out1=sprintf('\n  Overall Level = %8.4g dB',oadb);
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
