%   two_dof_force_frf.m   ver 1.1  December 6, 2007
%
%   by Tom Irvine   Email: tomirvine@aol.com
%
disp(' ');
disp(' This program finds the eigenvalues and eigenvectors for a ');
disp(' two-degree-of-freedom system.');
disp(' The equation of motion is:   M (d^2x/dt^2) + K x = 0 ');
disp(' ');
disp(' It also finds the frequency response function for an applied force. ');
%
clear k;
clear m;
clear Eigenvalues;
clear ModeShapes;
clear omega;
clear fn;
clear MS;
clear MST;
clear ModalMass;
clear part;
clear QTMQ;
clear r;
clear H1;
clear H2;
%
tpi=2.*pi;
%
n=2;
%
disp(' Select units: 1=English  2=metric ');
iunit=input(' ');
%
disp(' Assume symmetric mass and stiffness matrices. ');
disp(' ');
%
if(iunit==1)
    mass_unit='lbm';
    stiffness_unit='lbf/in';
    force_unit='lbf';
else
    mass_unit='kg';
    stiffness_unit='N/m';
    force_unit='N';
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
out1=sprintf(' Enter m11 (%s)',mass_unit);
disp(out1);
m(1,1)=input(' ');
%
out1=sprintf(' Enter m22 (%s)',mass_unit);
disp(out1);	
m(2,2)=input(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
m(1,2)=0;
m(2,1)=m(1,2);
%
if(iunit==1)
    m=m/386;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
out1=sprintf(' Enter k11 (%s)',stiffness_unit);
disp(out1);
k(1,1)=input(' ');
%
out1=sprintf(' Enter k12 (%s)',stiffness_unit);
disp(out1);
k(1,2)=input(' ');
%	
out1=sprintf(' Enter k22 (%s)',stiffness_unit);
disp(out1);
k(2,2)=input(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
k(2,1)=k(1,2);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out1=sprintf(' Enter f2 (%s)',force_unit);
disp(out1);
f2=input(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Enter modal damping ratio 1 ');
damp1=input(' ');
%
disp(' Enter modal damping ratio 2 ');
damp2=input(' ');
%
disp(' ');
disp(' The mass matrix is');
m
disp(' ');
disp(' The stiffness matrix is');
k
%
%  Calculate eigenvalues and eigenvectors
%
[ModeShapes,Eigenvalues]=eig(k,m);
%
omega = sqrt(Eigenvalues);
fn=omega/tpi;
%
disp(' ');
disp('  Natural Frequencies = ');
out1=sprintf('\n  %8.4g Hz',fn(1,1));
out2=sprintf('  %8.4g Hz',fn(2,2));
disp(out1);
disp(out2);
%
if(imag(fn(1,1))>1.0e-20)
   out1=sprintf('\n ** complex frequency warning ** \n %g+i%g \n',real(fn(1,1)),imag(fn(1,1)) ); 
   disp(out1);
   qq=input(' press any key to continue ');
end
if(imag(fn(2,2))>1.0e-20)
   out1=sprintf('\n ** complex frequency warning ** \n %g+i%g \n',real(fn(2,2)),imag(fn(2,2)) ); 
   disp(out1);
   qq=input(' press any key to continue ');  
end
%
MST=ModeShapes';
temp=zeros(2,2);
temp=m*ModeShapes;
QTMQ=MST*temp;
%   
scale1=1./sqrt(QTMQ(1,1));
scale2=1./sqrt(QTMQ(2,2));
%
ModeShapes(:,1) = ModeShapes(:,1)*scale1;  
ModeShapes(:,2) = ModeShapes(:,2)*scale2; 
%
MS=ModeShapes;
MST=ModeShapes';
%
disp(' ');
disp('  Modes Shapes (column format) =');
disp(' ');
out1=sprintf(' %12.4g    %12.4g ',ModeShapes(1,1),ModeShapes(1,2));
out2=sprintf(' %12.4g    %12.4g ',ModeShapes(2,1),ModeShapes(2,2));
disp(out1);
disp(out2);
%
r(1)=1;
r(2)=1;
%
part = MST*m*r';
%
disp(' ')
disp(' Participation Factors = ');
disp(' ');
out1=sprintf('  %8.4g   ', part(1));
out2=sprintf('  %8.4g   ', part(2));
disp(out1);
disp(out2);
%
ModalMass = (part.*part)/1.;
%
iscale=1;
if(iunit==1)
    iscale=386;
end
%
disp(' ');
disp(' Effective Modal Mass =');
disp(' ');
out1=sprintf('  %8.4g   %s', ModalMass(1)*iscale,mass_unit);
out2=sprintf('  %8.4g   %s', ModalMass(2)*iscale,mass_unit);
disp(out1);
disp(out2);
%
tm=ModalMass(1)+ModalMass(2);
%
out1=sprintf('\n Total Modal Mass = %12.4f %s',tm*iscale,mass_unit);
disp(out1)
%
clear f;
clear H1;
clear H2;
clear D1;
clear D2;
%
n1=MS(2,1);
n2=MS(2,2);
%
omg1=tpi*fn(1,1);
omg12=omg1^2;
%
omg2=tpi*fn(2,2);
omg22=omg2^2;
%
%% fn(1,1);
%% fn(2,2);
%
fstart=fn(1,1)*(1/4);
fend=fn(2,2)*4;
%
for(j=-10:10)
    if(fn(2,2)<10^j)
        fend=10^(j+1);
        break
    end
end
%
for(j=-10:10)
    if(fn(1,1)>10^j)
        fstart=10^(j-1);
    end
end
%
j=1;
clear f;
clear H1;
clear H2;
%
f(1)=fstart;
if(f(1)<1.0e-03)
    f(1)=1.0e-03;
end
while(1)
%        
    omga=tpi*f(j);
    om2=omga^2;
%
    D1=(omg12-om2)+i*(2*damp1*omg1*omga);
    D2=(omg22-om2)+i*(2*damp2*omg2*omga);
%
    N1(j)=om2*n1/D1;
    N2(j)=om2*n2/D2;
%
    aaa= ( MS(1,1)*N1(j) + MS(1,2)*N2(j));
    bbb= ( MS(2,1)*N1(j) + MS(2,2)*N2(j));
%
    H1(j)=f2*abs(aaa);
    H2(j)=f2*abs(bbb);
%
    if( (f(j)*2^(1/24)) >fend)
        break;
    end
    f(j+1)=f(j)*2^(1/24);
    j=j+1;
    if(j>100000)
       break;
    end
%
end
%
if(iunit==1)
    H1=H1/386;
    H2=H2/386;
else
    H1=H1/9.81;
    H2=H2/9.81; 
end
%
plot(f,H1,f,H2,'-.');
legend ('mass 1','mass 2');  
title('Acceleration Magnitude');
ylabel('Accel (G)');
xlabel('Frequency (Hz)');
grid;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
disp(' ');
disp(' Matlab Output Files:');
disp('   accel_1 ');
disp('   accel_2 ');
%
accel_1=[f;H1]';
accel_2=[f;H2]';
%
disp(' ')
disp(' Mass 1:  local peaks ');
%
for(j=2:(length(f)-1))
    if(H1(j)>H1(j-1) & H1(j)>H1(j+1))
        out1=sprintf(' %8.4g Hz %8.4g G ',f(j),H1(j));
        disp(out1);
    end
end
%
disp(' ')
disp(' Mass 2:  local peaks ');
%
for(j=2:(length(f)-1))
    if(H2(j)>H2(j-1) & H2(j)>H2(j+1))
        out1=sprintf(' %8.4g Hz %8.4g G ',f(j),H2(j));
        disp(out1);       
    end
end
%
disp(' ')
disp(' Save files to ASCII text? ');
choice=input(' 1=yes   2=no  ' );
disp(' ')
%
if choice == 1
%%
    [writefname, writepname] = uiputfile('*',' Save Mass 1 Response ');
    writepfname = fullfile(writepname, writefname);
    writedata = [f' H1'];
    fid = fopen(writepfname,'w');
    fprintf(fid,'  %g  %g \n',writedata');
    fclose(fid);
%%
    [writefname, writepname] = uiputfile('*',' Save Mass 2 Response ');
    writepfname = fullfile(writepname, writefname);
    writedata = [f' H2'];
    fid = fopen(writepfname,'w');
    fprintf(fid,'  %g  %g \n',writedata');
    fclose(fid);    
end   