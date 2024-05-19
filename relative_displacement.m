disp(' ');
disp(' relative_displacement.m   ver 1.2   June 8, 2012');
disp('  ');
disp(' by Tom Irvine   Email: tomirvine@aol.com ');
disp(' ');
%
close all;
%
clear THM1;
clear THM2;
%
clear signal1;
clear signal2;
%
clear tt;
clear relative_disp;
clear n;
%
disp(' The time histories must have the same sample rate, ');
disp(' starting time and number of points. ');
disp(' ');
%
disp(' The time histories must be preloaded into Matlab. ')
disp(' ');
%
disp(' The time histories must be in either of these formats. ');
disp('  1= Disp ');
disp('  2= Time(sec)  Disp ');
%
disp(' ');
%
THM1 = input(' Enter the first  time history filename:  ');
THM2 = input(' Enter the second time history filename:  ');        
%
sz1=size(THM1);
sz2=size(THM2);
%
if(sz1(2)>sz1(1))
    THM1=THM1';
end
%
if(sz2(2)>sz2(1))
    THM2=THM2';
end
%
sz1=size(THM1);
sz2=size(THM2);
%
if(sz1(2)==1)
    signal1=THM1;
else
    signal1=THM1(:,2);
end
%
if(sz2(2)==1)
    signal2=THM2;
else
    signal2=THM2(:,2);
end
%
relative_disp(:,2)=signal2-signal1;
%
if(sz1(2)==1)
    disp(' ');
    disp(' Enter sample rate ');
    sr=input(' ');
    dt=1/sr;
    nn=max(sz1);
    tmin=0;
    tmax=nn*dt; 
    tt=linspace(tmin,tmax,nn);
    relative_disp(:,1)=tt;
%
else
    tt=THM1(:,1);
    relative_disp(:,1)=THM1(:,1);
end
%
amp=relative_disp(:,2);
%
n=max(size(relative_disp));
mu=mean(amp);
sd=std(amp);
mx=max(amp);
mi=min(amp);
rms=sqrt(sd^2+mu^2);
%
disp(' ');
disp(' The output file is:  relative_disp ');
disp(' ');
disp(' Relative Displacement Statistics ');
disp(' ');
%
out0 = sprintf(' number of points = %d ',n);
out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
out2a = sprintf(' max  = %9.4g              ',mx);
out2b = sprintf(' min  = %9.4g            \n',mi);
disp(out0);
disp(out1);
disp(out2a);
disp(out2b);
%
figure(1);
%
plot(tt,signal1,tt,signal2);
title('Input Signals');
%
legend ('signal 1','signal 2');      
grid on;
xlabel('Time (sec) ');
ylabel('Disp (sec) ');
%
figure(2);
plot(relative_disp(:,1),relative_disp(:,2));
title('Relative Displacement');
grid on;
xlabel('Time (sec) ');
ylabel('Disp (sec) ');
%
disp(' ')
disp('Output Relative Response Text File?')
choice=input(' 1=yes  2=no  ' );
disp(' ')
%
if choice == 1 
%
      [writefname, writepname] = uiputfile('*.txt','Save acceleration data as');
	  writepfname = fullfile(writepname, writefname);
	  writedata = [relative_disp(:,1),relative_disp(:,2)];
	  fid = fopen(writepfname,'w');
	  fprintf(fid,'  %12.7e \t %12.7e\n',writedata');
	  fclose(fid);
%    
%   disp(' Enter output filename ');
% TH_filename = input(' ','s');
%
%  fid = fopen(TH_filename,'w');
%   for i=1:nn
%        fprintf(fid,'%12.5f %10.3f \n',tt(i),a_resp(i));
%   end
%   fclose(fid);
end