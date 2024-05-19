disp(' ')
disp(' rod_arbit_f.m   ver 1.1   April 11, 2013')
disp(' by Tom Irvine   Email: tom@vibrationdata.com')
disp(' ')
disp(' This program calculates the response of a fixed_free rod')
disp(' to an arbitrary applied force at the free end. ')
disp(' ')
%
clear omega;
clear omegad;
clear dt;
clear sr;
clear damp;
clear a1;
clear a2;
clear b1;
clear b2;
clear c1;
clear c2;
clear vc1;
clear vc2;
clear sum;
clear f;
clear ff;
clear t;
clear tt;
clear y;
clear yy;
clear THM;
clear x_pos;
clear x_neg;
clear d_pos;
clear d_neg;
clear a_resp;
clear x_resp;
clear forward;
clear back;
clear d_forward;
clear d_back;
clear length;
clear phi;
clear rod_mass;
%
fig_num=1;
%
disp(' Select units:  1=English  2=metric ');
iu=input(' ');
%
if(iu==1)
    disp(' The input time history must have two columns: time(sec) & force(lbf)')
else
    disp(' The input time history must have two columns: time(sec) & force(N)')    
end
disp(' ');
%
disp(' Select force time history input method ');
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
f=THM(:,2);
%
tmx=max(t);
tmi=min(t);
n = length(f);
dt=(tmx-tmi)/(n-1);
sr=1./dt;
%
disp(' ')
disp(' Time Step ');
dtmin=min(diff(t));
dtmax=max(diff(t));
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
out6 = sprintf(' srmax  = %8.4g samples/sec  \n',1/dtmin);
disp(out4)
disp(out5)
disp(out6)
%
ncontinue=1;
if(((dtmax-dtmin)/dt)>0.01)
    disp(' ')
    disp(' Warning:  time step is not constant.  Continue calculation? 1=yes 2=no ')
    ncontinue=input(' ')
end
if(ncontinue==1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[E,I,rho,c,L,A]=geometry_materials_units(iu);
%
nmodes=1;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
rod_mass=rho*A*L;
QM=2/(rho*A*L);
%
clear fn;
clear omegan;
for(k=1:nmodes)
    i=2*k-1;
    omegan(k)=i*pi*c/(2*L);
end
fn=omegan/(2*pi);
%
disp(' ')
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
%  Initialize coefficients
%
disp(' ')
disp(' Initialize coefficients')
for j=1:nmodes
%    
%%    out1=sprintf('\n  mode=%d \n',j);
%%    disp(out1);
%    
    omegad=omegan(j)*sqrt(1.-(damp^2));
%
    out5 = sprintf(' omegan=%g   omegad=%g ',omegan(j),omegad);
%%    disp(out5);    
%    
    cosd=cos(omegad*dt);
    sind=sin(omegad*dt);
%
    out5 = sprintf(' cosd=%g   sind=%g ',cosd,sind);
%%    disp(out5);    
%
    domegadt=damp*omegan(j)*dt;
    a1(j)=2.*exp(-domegadt)*cosd;
    a2(j)=-exp(-2.*domegadt);
%
    out5 = sprintf(' a1=%g  a2=%g ',a1(j),a2(j));
%%    disp(out5);  
%
    b1(j)=2.*domegadt;
    b2(j)=omegan(j)*dt*exp(-domegadt);    
    b2(j)=b2(j)*( (omegan(j)/omegad)*(1.-2.*(damp^2))*sind -2.*damp*cosd );
 %
    out5 = sprintf(' b1=%g   b2=%g ',b1(j),b2(j));
%%    disp(out5);  
%
    c2(j)=-(dt/omegad)*exp(-domegadt)*sind;
 %
    out5 = sprintf(' c2=%g  ',c2(j));
%%    disp(out5);  
%
    vc1(j)=dt;
    vc2(j)=dt*exp(-domegadt)*((-damp*omegan(j)/omegad)*sind-cosd);
% 
end
%
disp(' ');
disp(' Include residual? ');
disp('  1=yes  2=no ')
ire=input(' ');
%
if(ire==1)
%
%   Add trailing zeros for residual response
%
    disp(' ')
    disp(' Add trailing zeros for residual response')
    tmax=(tmx-tmi) + 2./fn(1);
    limit = round( tmax/dt );
    n=limit;
end
%   
clear ff;
ff=zeros(1,n);
for i=1:length(f)
        ff(i)=f(i);        
end    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Important step
%
   ff=ff*QM;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  SRS engine
%
clear phi_d;
clear phi_v;
%
disp(' ')
disp(' Calculating modal displacement');
for j=1:nmodes
%
    clear ffi;
    ffi=ff*sin(omegan(j)*L/c);
%
    d_forward=[     0,  c2(j),      0 ];
    d_back   =[     1, -a1(j), -a2(j) ];
%    
    d_resp=filter(d_forward,d_back,ffi);
%
    phi_d(:,j)=d_resp;
%
    d_pos(j)= max(d_resp);
    d_neg(j)= min(d_resp);
end
%
disp(' ')
disp(' Calculating modal velocity');
for j=1:nmodes
%
    v_forward=[    vc1(j),  vc2(j),      0 ];
    v_back   =[     1, -a1(j), -a2(j) ];
%    
    v_resp=filter(v_forward,v_back,ff);
%
    phi_v(:,j)=v_resp;    
%
    v_pos(j)= max(v_resp);
    v_neg(j)= min(v_resp);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ')
disp(' Calculating responses in physical coordinates');
%
x=L/2;
xc=x/c;
%
nt=max(size(phi_d));
clear uL;
clear vL;
clear strainZ;
uLz=zeros(nt,1);
vLz=zeros(nt,1);
strainZz=zeros(nt,1);
%
%
for(i=1:nmodes)
    uLz(:,1)=uLz(:,1)+phi_d(:,i)*sin(omegan(i)*xc);
    vLz(:,1)=vLz(:,1)+phi_v(:,i)*sin(omegan(i)*xc);
    strainZz(:,1)=strainZz(:,1)+phi_d(:,i)*(omegan(i)/c);
end
%
x=L;
xc=x/c;
%
nt=max(size(phi_d));
clear uL;
clear vL;
clear strainZ;
uL=zeros(nt,1);
vL=zeros(nt,1);
strainZ=zeros(nt,1);
%
tt=linspace(0,nt*dt,nt); 
%
for(i=1:nmodes)
    uL(:,1)=uL(:,1)+phi_d(:,i)*sin(omegan(i)*xc);
    vL(:,1)=vL(:,1)+phi_v(:,i)*sin(omegan(i)*xc);
    strainZ(:,1)=strainZ(:,1)+phi_d(:,i)*(omegan(i)/c);
end
%
sz=size(tt);
if(sz(2)>sz(1))
    tt=tt';
end
%
sz=size(uL);
if(sz(2)>sz(1))
    uL=uL';
end
%
sz=size(uL);
if(sz(2)>sz(1))
    uL=uL';
end
%
sz=size(strainZ);
if(sz(2)>sz(1))
    strainZ=strainZ';
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Natural Frequency (Hz) ');
for(k=1:nmodes)
    out1=sprintf(' %8.4g ',fn(k));
    disp(out1);
end
disp(' ');
%
figure(fig_num);
fig_num=fig_num+1;
plot(tt,uLz,tt,uL);
grid on;
title('Displacement at x=L');
xlabel('Time(sec)');
legend('x=0','x=L');
%
if(iu==1)
    ylabel('Disp(in)');
    disp(' ');
    disp(' Displacement (inch) at x=L ');    
else
    ylabel('Disp(mm)');    
    disp(' ');
    disp(' Displacement (mm) at x=L ');    
end
%
    mu=mean(uL);
    sd=std(uL);
    mx=max(uL);
    mi=min(uL);
    rms=sqrt(sd^2+mu^2);
%
    out1 = sprintf('   mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
    out2 = sprintf('   max  = %9.4g    min = %9.4g             \n',mx,mi);
    disp(out1);
    disp(out2);
%
%
figure(fig_num);
fig_num=fig_num+1;
plot(tt,vL);
grid on;
title('Velocity at x=L');
xlabel('Time(sec)');
%
if(iu==1)
    ylabel('Vel(in)');
    disp(' ');
    disp(' Velocity (in/sec) at x=L');    
else
    ylabel('Vel(m/sec)');
    disp(' ');
    disp(' Velocity (m/sec) at x=L');    
end
%
    mu=mean(vL);
    sd=std(vL);
    mx=max(vL);
    mi=min(vL);
    rms=sqrt(sd^2+mu^2);
%
    out1 = sprintf('   mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
    out2 = sprintf('   max  = %9.4g    min = %9.4g             \n',mx,mi);
    disp(out1);
    disp(out2);
%
%
figure(fig_num);
fig_num=fig_num+1;
%
strainZ=strainZ*1.0e+06;
%
plot(tt,strainZ);
grid on;
title('Micro Strain at x=0');
xlabel('Time(sec)');
ylabel('Micro Strain');
%   
    mu=mean(strainZ);
    sd=std(strainZ);
    mx=max(strainZ);
    mi=min(strainZ);
    rms=sqrt(sd^2+mu^2);
%
    disp(' ');
    disp(' Micro Strain at x=0 ');
%
    out1 = sprintf('   mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
    out2 = sprintf('   max  = %9.4g    min = %9.4g             \n',mx,mi);
    disp(out1);
    disp(out2);
end