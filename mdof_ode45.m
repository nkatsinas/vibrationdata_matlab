disp(' ');
disp(' mdof_ode45.m  ver 1.1  December 5, 2011 ');
disp(' by Tom Irvine ');
disp(' ');
disp(' This program calculates the response of an MDOF ');
disp(' system to initial conditions.  It is currently ');
disp(' set-up for a two-degree-of-freedom system, but ');
disp(' can be readily modified for additional degrees. ');
disp(' ');
%
clear w;
clear t;
clear M;
clear C;
clear K;
clear accel;
clear length;
%
disp(' ');
disp(' Enter the units system ');
disp(' 1=English  2=metric ');
iu=input(' ');
%
disp(' Assume symmetric mass and stiffness matrices. ');
%
if(iu==1)
     disp(' Select input mass unit ');
     disp('  1=lbm  2=lbf sec^2/in  ');
     imu=input(' ');

else
    disp(' mass unit = kg ');
end
%
disp(' ');
if(iu==1)
    disp(' damping unit = lbf sec/in ');
else
    disp(' damping unit = N sec/m ');
end
%
disp(' ');
if(iu==1)
    disp(' stiffness unit = lbf/in ');
else
    disp(' stiffness unit = N/m ');
end
%
disp(' ');
disp(' Select file input method ');
disp('   1=file preloaded into Matlab ');
disp('   2=Excel file ');
file_choice = input('');
%
disp(' ');
disp(' Mass Matrix ');
%
if(file_choice==1)
        M = input(' Enter the matrix name:  ');
end
if(file_choice==2)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        M = xlsread(xfile);
%         
end
%
if(iu==1 && imu==1)
  M=M/386;
end
%
disp(' ');
disp(' Damping Matrix ');
%
if(file_choice==1)
        C = input(' Enter the matrix name:  ');
end
if(file_choice==2)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        C = xlsread(xfile);
%         
end
%
disp(' ');
disp(' Stiffness Matrix ');
%
if(file_choice==1)
        K = input(' Enter the matrix name:  ');
end
if(file_choice==2)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        K = xlsread(xfile);
%         
end
% 
disp(' ');
disp(' The initial condition vector format is: ');
disp(' [ disp 1; disp 2; vel 1; vel 2] ');
disp(' ');
disp(' Enter the initial condition vector ');
w=input(' ');
% 
[fn,omegan,ModeShapes,MST]=Generalized_Eigen(K,M,1);
%
Tmin=1/(max(fn));
Tmax=1/(min(fn));
%
dur=20*Tmax;
%
tstart=0;
tend=dur;
%
[t,w] = ode45(@MDOF_simulation,[tstart tend],w,[],[],M,C,K);
%
figure(1);
plot(t,w(:,1),t,w(:,2));
legend ('mass 1','mass 2');   
title('Dispacement');
if(iu==1)
    ylabel('Disp(in)');
else
    ylabel('Disp(m)');    
end
xlabel('Time(sec)');
grid on;
%
figure(2);
plot(t,w(:,3),t,w(:,4));
legend ('mass 1','mass 2');   
title('Velocity');
if(iu==1)
    ylabel('Vel(in/sec)');
else
    ylabel('Vel(m/sec)');    
end
xlabel('Time(sec)');
grid on;
%
N=length(t);
%
accel=zeros(N,2);
for(i=1:N)
    aaa = -M\(C*[w(i,3) w(i,4)]') -M\(K*[w(i,1) w(i,2)]');
    accel(i,1)=aaa(1);
    accel(i,2)=aaa(2);   
end
%
if(iu==1)
    accel=accel/386;
end
%
figure(3);
plot(t,accel(:,1),t,accel(:,2));
legend ('mass 1','mass 2');   
title('Acceleration');
if(iu==1)
    ylabel('Accel(G)');
else
    ylabel('Accel(m/sec^2)');    
end
xlabel('Time(sec)');
grid on;
%