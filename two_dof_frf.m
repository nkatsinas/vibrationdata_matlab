disp(' ');
disp('   two_dof_frf.m   ver 1.8  October 19, 2011 ');
disp('   by Tom Irvine   Email: tomirvine@aol.com  ');
disp(' ');
disp(' This program finds the eigenvalues and eigenvectors for a ');
disp(' two-degree-of-freedom system.');
disp(' The equation of motion is:   M (d^2x/dt^2) + K x = 0 ');
disp(' ');
disp(' It also finds the frequency response function for base excitation ');
disp(' and the response to applied excitation. ');
%
close all;
%
clear k;
clear m;
clear Eigenvalues;
clear ModeShapes;
clear omega;
clear omegan;
clear omegad;
clear fn;
clear MS;
clear MST;
clear ModalMass;
clear part;
clear QTMQ;
clear r;
clear H1;
clear H2;
clear H1_sq;
clear H2_sq;
clear N1;
clear N2;
clear ZH1;
clear ZH2;
clear ZH3;
clear ZH1_sq;
clear ZH2_sq;
clear ZH3_sq;
clear ZN1;
clear ZN2;
clear transfer_1;
clear transfer_2;
clear power_trans_1;
clear power_trans_2;
clear z_transfer_1;
clear z_transfer_2;
clear z_transfer_21;
%
clear z_power_trans_1;
clear z_power_trans_2;
clear z_power_trans_21;
%
fig_num=1;
%
tpi=2.*pi;
%
n=2;
%
disp(' ');
disp(' Select units: 1=English  2=metric ');
iunit=input(' ');
iu=iunit;
%
disp(' Assume symmetric mass and stiffness matrices. ');
disp(' ');
%
if(iunit==1)
    mass_unit='lbm';
    stiffness_unit='lbf/in';
else
    mass_unit='kg';
    stiffness_unit='N/m';
end
iu=iunit;
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
disp(' ');
disp(' Enter modal damping ratio 1 ');
damp1=input(' ');
%
disp(' Enter modal damping ratio 2 ');
damp2=input(' ');
%
clear damp;
damp=zeros(2,1);
damp(1,1)=damp1;
damp(2,1)=damp2;
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
omegan=[omega(1,1) omega(2,2)];
%
sz=omegan;
if(sz(2)>sz(1))
    omegan=omegan';
end
%
clear omegad;
omegad=zeros(2,1);
for(i=1:2)
   omegad(i)=omegan(i)*sqrt(1-(damp(i))^2);
end
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
clear Q;
Q=ModeShapes;
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
out1=sprintf('\n Total Modal Mass = %8.4g %s',tm*iscale,mass_unit);
disp(out1)
%
clear f;
clear H1;
clear H2;
clear D1;
clear D2;
%
n1=(MS(1,1)*m(1,1)+MS(2,1)*m(2,2));
n2=(MS(1,2)*m(1,1)+MS(2,2)*m(2,2));
%
omg1=tpi*fn(1,1);
omg12=omg1^2;
%
omg2=tpi*fn(2,2);
omg22=omg2^2;
%
fmax=10*fn(2,2);
df=fn(1,1)/100;
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
i=sqrt(-1);
%
for(j=1:nf)
%
    f(j)=(j-1)*df;
    omga=tpi*f(j);
    om2=omga^2;
%
    D1=(omg12-om2)+i*(2*damp1*omg1*omga);
    D2=(omg22-om2)+i*(2*damp2*omg2*omga);
%
    N1(j)=om2*n1/D1;
    N2(j)=om2*n2/D2;
%
    aaa= 1 + ( MS(1,1)*N1(j) + MS(1,2)*N2(j));
    bbb= 1 + ( MS(2,1)*N1(j) + MS(2,2)*N2(j));
%
    H1(j)=abs(aaa);
    H2(j)=abs(bbb);
%
    H1_sq(j)=(H1(j))^2;
    H2_sq(j)=(H2(j))^2;    
%
    ZN1(j)=n1/D1;
    ZN2(j)=n2/D2;
%
    aaa= -( MS(1,1)*ZN1(j) + MS(1,2)*ZN2(j));
    bbb= -( MS(2,1)*ZN1(j) + MS(2,2)*ZN2(j));
%
    ZH1(j)=386*abs(aaa);
    ZH2(j)=386*abs(bbb);
    ZH3(j)=386*abs(bbb-aaa);
%
    ZH1_sq(j)=(ZH1(j))^2;
    ZH2_sq(j)=(ZH2(j))^2;
    ZH3_sq(j)=(ZH3(j))^2;    
%
end
%
figure(fig_num);
fig_num=fig_num+1;
plot(f,H1,f,H2,'-.');
legend ('mass 1','mass 2');  
title('Acceleration Transfer Function Magnitude');
ylabel('Trans (G/G)');
xlabel('Frequency (Hz)');
grid;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
disp(' ');
disp(' Matlab Output Files:');
disp('   transfer_1 ');
disp('   transfer_2 ');
%
transfer_1=[f;H1]';
transfer_2=[f;H2]';
%
power_trans_1=[f;H1_sq]';
power_trans_2=[f;H2_sq]';
%
figure(fig_num);
fig_num=fig_num+1;        
plot(f,ZH1,f,ZH2,f,ZH3);
legend ('mass 1','mass 2','mass 2-mass 1');  
title('Relative Displacement Transfer Function Magnitude');
ylabel('Trans (inch/G)');
xlabel('Frequency (Hz)');
grid;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
z_transfer_1=[f;ZH1]';
z_transfer_2=[f;ZH2]';
z_transfer_21=[f;ZH3]';
%
z_power_trans_1=[f;ZH1_sq]';
z_power_trans_2=[f;ZH2_sq]';
z_power_trans_21=[f;ZH3_sq]';
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[fig_num]=two_dof_frf_apply_sine(omg12,omg22,damp1,damp2,omg1,omg2,MS,n1,n2,fig_num,iu);
%
[fig_num]=two_dof_frf_apply_random(m,fn,omegan,omegad,damp,Q,fig_num,iu,...
            power_trans_1,power_trans_2,z_power_trans_1,z_power_trans_2,z_power_trans_21);
%
[fig_num]=two_dof_frf_apply_rba(m,k,fig_num,iu);
%
[fig_num]=two_dof_frf_apply_initial(m,fn,omegan,omegad,damp,Q,fig_num,iu);
%
[fig_num]=two_dof_frf_apply_hs(m,fn,omegan,omegad,damp,Q,fig_num,iu);
%
[fig_num]=two_dof_frf_apply_arbit(m,fn,omegan,omegad,damp,Q,fig_num,iu);