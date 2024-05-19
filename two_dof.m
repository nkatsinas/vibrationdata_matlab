disp(' ');
disp(' two_dof.m   ver 1.1  May 19, 2011 ');
disp(' by Tom Irvine   Email: tomirvine@aol.com ');
disp(' ');
disp(' This program finds the eigenvalues and eigenvectors for a ');
disp(' two-degree-of-freedom system.');
disp(' The equation of motion is:   M (d^2x/dt^2) + K x = 0 ');
%
clear H1;
clear H2;
%
clear k;
clear m;
clear Eigenvalues;
clear ModeShapes;
clear omega;
clear fn;
clear MST;
clear ModalMass;
clear part;
clear QTMQ;
clear r;
%
disp(' ');
disp(' Enter units ');
disp(' 1=English 2=metric ');
iu=input(' ');
%
if(iu==1)
    disp(' Enter mass unit ');
    disp(' 1=lbm  2=lbf sec^2/in  ');
    imu=input(' ');
end
%
tpi=2.*pi;
%
n=2;
%
disp(' Assume symmetric mass and stiffness matrices. ');
%
iscale=1;
%
disp(' ');
if(iu==1)
    if(imu==1)
        disp(' Mass unit is lbm ');
        iscale=2;
    else
        disp(' Mass unit is lbf sec^2/in ');
    end
else
    disp(' Mass unit is kg ');
end
%
disp(' ');
disp(' Enter m11 ');
m(1,1)=input(' ');
%
disp(' Enter m12 ');
m(1,2)=input(' ');
%	
disp(' Enter m22 ');	
m(2,2)=input(' ');
%
m(2,1)=m(1,2);
%
if(iscale==2)
    m=m/386;
end
%
disp(' ');
%
if(iu==1)
    disp(' Stiffness unit is lbf/in ');
else
    disp(' Stiffness unit is N/m ');
end
disp(' ');
disp(' Enter k11 ');
k(1,1)=input(' ');
%
disp(' Enter k12 ');
k(1,2)=input(' ');
%	
disp(' Enter k22 ');	
k(2,2)=input(' ');
%
k(2,1)=k(1,2);
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
disp(' Particpation Factors = ');
disp(' ');
out1=sprintf('  %8.4g   ', part(1));
out2=sprintf('  %8.4g   ', part(2));
disp(out1);
disp(out2);
%
ModalMass = (part.*part)/1.;
%
disp(' ');
disp(' Effective Modal Mass =');
disp(' ');
out1=sprintf('  %8.4g   ', ModalMass(1));
out2=sprintf('  %8.4g   ', ModalMass(2));
disp(out1);
disp(out2);
%
tm=ModalMass(1)+ModalMass(2);
%
out1=sprintf('\n Total Modal Mass = %12.4f ',tm);
disp(out1)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Frequency Response Functions
%
disp(' ');
disp(' Calculate FRF? ');
disp(' 1=yes 2=no ');
ic=input(' ');
%
if(ic==1)
%
disp(' ');
clear dampv;
dampv(1)=input(' Enter damping ratio 1 ');
dampv(2)=input(' Enter damping ratio 2 ');
%
fmax=10*fn(2,2);
df=fn(1,1)/100;
%
nf=round(fmax/df);
%
clear omn;
fnv=[fn(1,1) fn(2,2)];
omn=tpi*fnv;
omn2=omn.*omn;
H11=zeros(nf);
H12=zeros(nf);
H22=zeros(nf);
%
clear QE;
QE=ModeShapes;
%
num=2;
%
lossv=2*dampv;
%
clear freq;
freq=zeros(nf,1);
for(i=1:nf)
    freq(i)=i*df;
end
%
clear H;
H=zeros(num,num,nf);
%
progressbar
%
for(s=1:nf) % frequency loop
%
progressbar(s/nf);
%
    for(i=1:num)
        for(k=i:num)
            for(r=1:num)
                rho=freq(s)/fnv(r);
                den=1-rho^2+(1i)*lossv(r)*rho;
%                
                term=(QE(i,r)*QE(k,r)/den)/omn2(r);
%       
                H(i,k,s)=H(i,k,s)+term;
            end
        end
    end
end
%
if(iu==2)
    H=1000*H;
end
%
clear HM11;
clear HM12;
clear HM22;
%
clear HP11;
clear HP12;
clear HP22;
%
for(i=1:nf)
%
    HM11(i)=abs(H(1,1,i));
    HM12(i)=abs(H(1,2,i));
    HM22(i)=abs(H(2,2,i));
%
    HP11(i)=-atan2(imag(H(1,1,i)),real(H(1,1,i)))*180/pi;
    HP12(i)=-atan2(imag(H(1,2,i)),real(H(1,2,i)))*180/pi;
    HP22(i)=-atan2(imag(H(2,2,i)),real(H(2,2,i)))*180/pi;
%
end
%
figure(1);
clear f;
f=freq;
plot(f,HM11,f,HM12,f,HM22);
legend ('H11','H12','H22');  
title('Transfer Function Magnitude');
grid on;
if(iu==1)
    ylabel('Displacement/Force (in/lbf)');
else
    ylabel('Displacement/Force (mm/N)');    
end
xlabel('Frequency (Hz)');
%
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
end