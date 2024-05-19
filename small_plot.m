%
%   This script converts a large time history file into a
%   smaller one by retaining only the max and min points within 
%   successive intervals.  It is useful for plotting.
%
disp(' small_plot.m  ver 1.0   December 20, 2006')
disp(' by Tom Irvine ');
disp(' ')
%
clear THM;
clear t;
clear y;
clear tim;
clear amp;
%
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
else
    THM = input(' Enter the matrix name:  ');
end
%
t=double(THM(:,1));
y=double(THM(:,2));
%
n = length(y);
out5 = sprintf('\n number of samples = %d  ',n);
disp(out5)
%
disp(' ');
disp(' Enter the number of points per interval over which')
disp(' the max and min will be retained (typically from 10 to 100)');
m=input(' ')
%
k=0;
j=1;
first=1;
while(k<n)
    k=k+1;     
    last=first+m-1;
    if(last>n)
        break;
    end    
%    
    [ymax,Imax]=max(y(first:last));
    [ymin,Imin]=min(y(first:last));
    tmax=t(Imax+first-1);   
    tmin=t(Imin+first-1);
%    
    if(tmax>tmin)
        tim(j)=tmin;
        tim(j+1)=tmax;
        amp(j)=ymin;
        amp(j+1)=ymax;     
    else
        tim(j)=tmax;
        tim(j+1)=tmin;
        amp(j)=ymax;
        amp(j+1)=ymin;    
    end
    j=j+2;
    first=last+1;
end
%
tim=fix_size(tim);
amp=fix_size(amp);

figure(762);
plot(tim,amp);
grid on;

clear length
length(amp)

small=[tim amp];

