disp('   two_dof_frf_coupled.m   ver 1.1  September 8, 2010 ');
disp('   by Tom Irvine   Email: tomirvine@aol.com  ');
disp(' ');
disp(' This program finds the eigenvalues and eigenvectors for a ');
disp(' two-degree-of-freedom system with translation and rotation.');
disp(' The equation of motion is:   M (d^2x/dt^2) + K x = 0 ');
disp(' ');
disp(' It also finds the frequency response function for base excitation. ');
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
    J_unit='lbm in^2';   
    stiffness_unit='lbf/in';
    length_unit='in';
else
    mass_unit='kg';
    J_unit='kg m^2';       
    stiffness_unit='N/m';
    length_unit='m';    
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
out1=sprintf(' Enter m (%s)',mass_unit);
disp(out1);
m(1,1)=input(' ');
%
out1=sprintf(' Enter J (%s)',J_unit);
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
out1=sprintf(' Enter k1 (%s)',stiffness_unit);
disp(out1);
k1=input(' ');
%
out1=sprintf(' Enter k2 (%s)',stiffness_unit);
disp(out1);
k2=input(' ');
%	
disp(' ');
out1=sprintf(' Enter L1 (%s)',length_unit);
disp(out1);
L1=input(' ');
%
out1=sprintf(' Enter L2 (%s)',length_unit);
disp(out1);
L2=input(' ');
%	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
k(1,1)=k1+k2;
k(1,2)=-k1*L1 + k2*L2;
k(2,1)=k(1,2);
k(2,2)=k1*L1^2 + k2*L2^2;
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
n1 = MS(1,1)*(k1+k2) + MS(2,1)*(k2*L2-k1*L1);
n2 = MS(1,2)*(k1+k2) + MS(2,2)*(k2*L2-k1*L1);
%
omg1=tpi*fn(1,1);
omg12=omg1^2;
%
omg2=tpi*fn(2,2);
omg22=omg2^2;
%
fmax=5*fn(2,2);
df=fn(1,1)/1000;
%
for(i=-10:20)
    if(df<10^(i-4))
        df=10^(i-5);
        break;
    end
end
%
nf=round(fmax/df);
%
clear DH1C;
clear DH2C;
%
m=m(1,1);
q11=MS(1,1);
q12=MS(1,2);
q21=MS(2,1);
q22=MS(2,2);
%
for(j=1:nf)
%
    i=sqrt(-1);
%
    f(j)=(j-1)*df;
    omga=tpi*f(j);
    om2=omga^2;
%
    D1=(omg12-om2)+i*(2*damp1*omg1*omga);
    D2=(omg22-om2)+i*(2*damp2*omg2*omga);
%
    N1(j)=1/D1;
    N2(j)=1/D2;
%
    H1(j)=abs(1+m*om2*(  (q11^2)*N1(j) + q12*q21*N2(j) ));
    H2(j)=  abs(m*om2*(  q11*q21*N1(j) + q22*q21*N2(j) ));
%
    ZH1(j)=m*abs( q11*(q11+L2*q21)*N1(j)  +  q21*(q12+L2*q22)*N2(j) );
    ZH2(j)=m*abs( q11*(q11-L1*q21)*N1(j)  +  q21*(q12-L1*q22)*N2(j) );
%
end
%
figure(1);
plot(f,H1);
title('Translational Acceleration Transfer Function Magnitude');
ylabel('Trans (G/G)');
xlabel('Frequency (Hz)');
grid;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
figure(2);
H2=H2*386;
plot(f,H2);
title('Rotational Acceleration Transfer Function Magnitude');
ylabel('Trans (rad/sec^2/G)');
xlabel('Frequency (Hz)');
grid;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
figure(3);
ZH1=ZH1*386;
ZH2=ZH2*386;
plot(f,ZH1,f,ZH2,'-.');
legend ('spring 1','spring 2'); 
title('Relative Displacement Transfer Function Magnitude');
ylabel('Trans (in/G)');
xlabel('Frequency (Hz)');
grid;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
%
disp(' ');
disp(' Matlab Output Files:');
disp('   transfer_1 ');
disp('   transfer_2 ');
%
transfer_1=[f;H1]';
transfer_2=[f;H2]';
z_transfer_1=[f;ZH1]';
z_transfer_2=[f;ZH2]';