disp(' ')
disp(' spring_mass_preload_base.m ')
disp(' ver 1.0   November 29, 2011 ')
disp(' by Tom Irvine  Email: tomirvine@aol.com ')
disp(' ')
disp(' This program calculates the vibration response of a  ')
disp(' preloaded single-degree-of-freedom system to an. ')
disp(' arbitrary base input pulse.')
%
clear fn;
clear damp;
clear N;
clear t;
clear a;
clear xm;
clear xb;
clear vm;
clear vb;
clear zm;
clear zb;
clear am;
clear length;
%
tpi=2*pi;
%
fig_num=1;
%
disp(' ');
disp(' select units')
iunits=input(' 1=English  2=metric ');
%
disp(' The input time history must have two columns: time(sec) & accel(G)')
disp(' ')
%
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
t=THM(:,1);
a=THM(:,2);
num=length(t);
%
figure(fig_num);
fig_num=fig_num+1;
plot(t,a);
grid on;
xlabel('Time(sec)');
ylabel('Accel(G)');
title('Base Input ');
%
if(iunits==1)
   a=a*386;    
end
%
disp(' ')
%
if(iunits==1)
    disp(' ')
    preload=input(' enter preload (lbf) ');
    disp(' ') 
    m=input(' enter mass (lbm) ');
    m=m/386;
    disp(' ')
    k1=input(' enter stiffness 1 (lbf/in) ');
    k2=input(' enter stiffness 2 (lbf/in) ');
else
    disp(' ')
    preload=input(' enter preload (N) ');
    disp(' ')
    m=input(' mass (kg) ');
    disp(' ')
    k1=input(' stiffness 1 (N/m) ');
    k2=input(' stiffness 2 (N/m) '); 
end
%
disp(' ');
damp=input(' Enter damping ratio for free spring-mass system ');
%
dbump0 = preload/k2;
%
disp(' ');
if(iunits==1)
    out1=sprintf(' Initial deflection of spring 2 = %8.4g in',dbump0);
else
    out1=sprintf(' Initial deflection of spring 2 = %8.4g mm',dbump0*1000);    
end
disp(out1);
disp(' ')
%
%   State Space Solution
%
kt=k1+k2;
%
omega_free=(sqrt(k1/m));
omega_contact=(sqrt(kt/m));
%
fn_free=omega_free/tpi;
fn_contact=omega_contact/tpi;
%
out1=sprintf('    fn_free=%8.4g Hz',fn_free);
out2=sprintf(' fn_contact=%8.4g Hz',fn_contact);
%
disp(out1);
disp(out2);
%
N=length(a);
%
zm=zeros(N,1);
xm=zeros(N,1);
vm=zeros(N,1);
%
zb=zeros(N,1);
xb=zeros(N,1);
vb=zeros(N,1);
%
am=zeros(N,1);
%
for(i=2:N)
%
    if(zm(i-1) < -dbump0)  % Free 
       xp=zm(i-1);
       yp=vm(i-1);
       ta=t(i-1);
       tb=t(i);
       aa=a(i-1);
       ab=a(i);
       [zm(i),vm(i),am(i)]=smpb_rk4(xp,yp,omega_free,damp,ta,tb,aa,ab); 
%
       if( zm(i)> -dbump0)  %  Contact
%
%        find contact time via secant method
%
         t1=t(i-1);
         t2=t(i);
         zm1=zm(i-1);
         zm2=zm(i);
%
         xp=zm(i-1);
         yp=vm(i-1);
         ta=t(i-1);
         aa=a(i-1);
         dur=t(i)-t(i-1);
%
         for(j=1:10)
            slope=(zm(i)-zm(i-1))/(t(i)-t(i-1));
            b=zm(i-1)-slope*t(i-1); 
            t3=(-dbump0-b)/slope; 
%
            tb=t3;
            c2=(t3-ta)/dur;
            c1=1-c2;
            ab=c2*a(i)+c1*(a(i-1));
            [zm3,vm3,am3]=smpb_rk4(xp,yp,omega_free,damp,ta,tb,aa,ab);             
%
            if((zm1*zm3)<0)
                t2=t3;
                zm2=zm3;
            else
                t1=t3;
                zm1=zm3;
            end
         end
%
%%         out1=sprintf(' %8.5g %8.5g %8.5g ',t(i-1),t3,t(i));
%%         disp(out1);
         t(i)=t3;
         a(i)=ab;
         zm(i)=-dbump0;      
%
       end
%
    else   % contact for zm(i)>= -dbump0
%
       xp=zm(i-1);
       yp=vm(i-1);
       ta=t(i-1);
       tb=t(i);
       aa=a(i-1);
       ab=a(i);
       [zm(i),vm(i),am(i)]=smpb_rk4(xp,yp,omega_contact,damp,ta,tb,aa,ab);  
%
       if( zm(i)< -dbump0) % release
%
%        find release time via secant method
%
         t1=t(i-1);
         t2=t(i);
         zm1=zm(i-1);
         zm2=zm(i);
%
         xp=zm(i-1);
         yp=vm(i-1);
         ta=t(i-1);
         aa=a(i-1);
         dur=t(i)-t(i-1);
%
         for(j=1:10)
            slope=(zm(i)-zm(i-1))/(t(i)-t(i-1));
            b=zm(i-1)-slope*t(i-1); 
            t3=(-dbump0-b)/slope; 
%
            tb=t3;
            c2=(t3-ta)/dur;
            c1=1-c2;
            ab=c2*a(i)+c1*(a(i-1));
            [zm3,vm3,am3]=smpb_rk4(xp,yp,omega_contact,damp,ta,tb,aa,ab);             
%
            if((zm1*zm3)<0)
                t2=t3;
                zm2=zm3;
            else
                t1=t3;
                zm1=zm3;
            end
         end
%
%%         out1=sprintf(' %8.5g %8.5g %8.5g ',t(i-1),t3,t(i));
%%         disp(out1);
         t(i)=t3;
         a(i)=ab;
         zm(i)=-dbump0*1.00001;
%
      end
%
    end 
%
    if(zm(i)<-dbump0)
        zb(i)=-dbump0;
    else
        zb(i)=zm(i);
    end
%
end
%
figure(fig_num);
fig_num=fig_num+1;
%
if(iunits==1)
    am=am/386;  
end
plot(t,am);
title('Absolute Acceleration');
xlabel('Time(sec)');
ylabel('Accel(G)');    
legend ('Mass');   
grid on;
%
figure(fig_num);
fig_num=fig_num+1;
plot(t,vm);
title('Relative Velocity');
xlabel('Time(sec)');
if(iunits==1)
    ylabel('Vel(in/sec)');
else
    ylabel('Vel(m/sec)');    
end
legend ('Mass');   
grid on;
%
figure(fig_num);
fig_num=fig_num+1;
if(iunits==2)
    zm=zm*1000;
    zb=zb*1000;
end
plot(t,zm,t,zb);
title('Relative Displacement');
xlabel('Time(sec)');
if(iunits==1)
    ylabel('Disp(in)');
else
    ylabel('Disp(mm)');    
end
legend ('Mass','Bumper');   
grid on;
%
disp(' ');
disp(' ');
disp(' Note: output time step is not constant if contact occurred ');