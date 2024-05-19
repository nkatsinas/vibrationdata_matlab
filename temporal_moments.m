disp('  ');
disp(' temporal_moments.m   ver 1.2  October 11, 2018  ');
disp('  ');
disp(' by Tom Irvine  ');
disp('  ');
disp(' Smallwood temporal moments. ');
%
disp('  ');
disp(' The input file must have two columns: time(sec) & accel(G) ');
disp('  ');
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
    amp=double(THM(:,2));
    tim=double(THM(:,1));
    n = length(amp);
%disp(' mean values ')


    [mu,sd,rms,sk,kt]=kurtosis_stats(amp);
    [tt_max,tt_min,mx,mi]=max_min_times(tim,amp);

%1
    disp(' ')
    disp(' Time Stats ')
    tmx=max(tim);
    tmi=min(tim);
    duration=(tmx-tmi);
% 
    out3 = sprintf('   start  = %g sec    end = %g sec   duration = %g sec  ',tmi,tmx,duration);
    disp(out3)
%
    dt=duration/(n-1);
    out5 = sprintf('\n number of samples = %d  ',n);
    disp(out5)
%
    clear t;
    t=tim;
    disp(' ')
    disp(' Time Step ');
    clear difft;
    difft=diff(t);
    dtmin=min(difft);
    dtmax=max(difft);
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
    out6 = sprintf(' srmax  = %8.4g samples/sec  ',1/dtmin);
    disp(out4)
    disp(out5)
    disp(out6)
    clear t;
%
    disp(' ')
    disp(' Amplitude Stats ')
     out0 = sprintf(' number of points = %d ',n);
    out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
    out2a = sprintf(' max  = %9.4g  at  = %8.4g sec             ',mx,tt_max);
    out2b = sprintf(' min  = %9.4g  at  = %8.4g sec            \n',mi,tt_min);
    disp(out0);
    disp(out1);
    disp(out2a);
    disp(out2b);

%
    disp(' ')
    fig_num=1;
%
    figure(fig_num);
    fig_num=fig_num+1;        
    plot(tim,amp)
    xlabel(' Time (sec)');
    ylabel(' Accel (G)');
    zoom on;
    grid on;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Calculate Temporal Moments ');
disp(' ');
ref=input(' Input reference time shift (sec):  '  );
%
a2=zeros(n,1);
%
for i=1:n
    a2(i)=amp(i)^2;
end
%
m0=0;
m1=0;
m2=0;
m3=0;
m4=0;
%
for i=1:n
        ta=(tim(i)-ref);
        
        a2i=a2(i);
        
        m0=m0+a2i;        
        m1=m1+ta*a2i;
        m2=m2+ta^2*a2i;
        m3=m3+ta^3*a2i; 
        m4=m4+ta^4*a2i;          
end    
%
m0=m0*dt;
m1=m1*dt;
m2=m2*dt;
m3=m3*dt;
m4=m4*dt;
%
E=m0;
D=sqrt( (m2/m0) - (m1/m0)^2 );
%
Ae=sqrt(E/D);
T=m1/m0;

ss=(m3/m0)-3*(m1*m2/m0^2)+2*(m1/m0)^3;
St=(ss)^(1/3);

S=St/D;

kk=(m4/m0)-4*(m1*m3/m0^2)+6*(m1^2*m2/m0^3)-3*(m1/m0)^4;
Kt=(kk)^(1/4);

K=Kt/D;
%
disp(' ');
disp('               Central Moments ');
disp('  ');
%
out1=sprintf('                Energy E  = %8.4g G^2 sec',E);
out2=sprintf(' Root energy amplitude Ae = %8.4g ',Ae);
out3=sprintf('          Central time T  = %8.4g sec',T);
out4=sprintf('          RMS duration D  = %8.4g sec',D);
out5=sprintf('      Central skewness St = %8.4g sec',St);
out6=sprintf('   Normalized skewness S  = %8.4g ',S);
out7=sprintf('      Central kurtosis Kt = %8.4g sec',Kt);
out8=sprintf('   Normalized kurtosis K  = %8.4g ',K);

%
disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);
disp(out7);
disp(out8);



