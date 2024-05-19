%   four_dof_force_frf.m   ver 1.0  March 11, 2008
%
%   by Tom Irvine   Email: tomirvine@aol.com
%
disp(' ');
disp(' This program finds the eigenvalues and eigenvectors for a ');
disp(' four-degree-of-freedom system.');
disp(' The equation of motion is:   M (d^2x/dt^2) + K x = 0 ');
disp(' ');
disp(' It also finds the frequency response function for an applied force. ');
disp(' ');
disp(' See tutorial:  Four_dof_FRF_force.pdf ');
disp(' ');
%
clear k;
clear m;
clear Eigenvalues;
clear ModeShapes;
clear omega;
clear fn;
clear damp;
clear scale;
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
m = zeros(4,4);
k = zeros(4,4);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    
out1=sprintf(' Enter m1 (%s)',mass_unit);
disp(out1);
m(1,1)=input(' ');
%
out1=sprintf(' Enter m2 (%s)',mass_unit);
disp(out1);	
m(2,2)=input(' ');
%    
out1=sprintf(' Enter m3 (%s)',mass_unit);
disp(out1);
m(3,3)=input(' ');
%
out1=sprintf(' Enter m4 (%s)',mass_unit);
disp(out1);	
m(4,4)=input(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
disp(' ');
out1=sprintf(' Enter k2 (%s)',stiffness_unit);
disp(out1);
k2=input(' ');
%
disp(' ');
out1=sprintf(' Enter k3 (%s)',stiffness_unit);
disp(out1);
k3=input(' ');
%
disp(' ');
out1=sprintf(' Enter k4 (%s)',stiffness_unit);
disp(out1);
k4=input(' ');
%
k(1,1)=k1+k2+k3+k4;
k(1,2)=-k2;
k(1,3)=-k3;
k(1,4)=-k4;
k(2,2)=k2;
k(3,3)=k3;
k(4,4)=k4;
k(2,1)=k(1,2);
k(3,1)=k(1,3);
k(4,1)=k(1,4);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
out1=sprintf(' Enter f1 (%s)',force_unit);
disp(out1);
f1=input(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Enter modal damping ratio 1 ');
damp(1)=input(' ');
%
disp(' Enter modal damping ratio 2 ');
damp(2)=input(' ');
%
disp(' Enter modal damping ratio 3 ');
damp(3)=input(' ');
%
disp(' Enter modal damping ratio 4 ');
damp(4)=input(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
out3=sprintf('  %8.4g Hz',fn(3,3));
out4=sprintf('  %8.4g Hz',fn(4,4));
disp(out1);
disp(out2);
disp(out3);
disp(out4);
%
for(i=1:4)
    if(imag(fn(i,i))>1.0e-20)
        out1=sprintf('\n ** complex frequency warning ** \n %g+i%g \n',real(fn(i,i)),imag(fn(i,i)) ); 
        disp(out1);
        qq=input(' press any key to continue ');
    end
end
%
MST=ModeShapes';
temp=zeros(4,4);
temp=m*ModeShapes;
QTMQ=MST*temp;
%   
for(i=1:4)
    scale(i)=1./sqrt(QTMQ(i,i));
end
%
for(i=1:4)
    ModeShapes(:,i) = ModeShapes(:,i)*scale(i);  
end 
%
MS=ModeShapes;
MST=ModeShapes';
%
disp(' ');
disp('  Modes Shapes (column format) =');
disp(' ');
for(i=1:4)
    out1=sprintf(' %12.4g  %12.4g  %12.4g  %12.4g',ModeShapes(i,1),ModeShapes(i,2),ModeShapes(i,3),ModeShapes(i,4));
    disp(out1);
end
%
for(i=1:4)
    r(i)=1;
end
%
part = MST*m*r';
%
disp(' ')
disp(' Participation Factors = ');
disp(' ');
for(i=1:4)
    out1=sprintf('  %8.4g   ', part(i));
    disp(out1);
end
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
for(i=1:4)
    out1=sprintf('  %8.4g   %s', ModalMass(i)*iscale,mass_unit);
    disp(out1);
end
%
tm=ModalMass(1)+ModalMass(2)+ModalMass(3)+ModalMass(4);
%
out1=sprintf('\n Total Modal Mass = %12.4f %s',tm*iscale,mass_unit);
disp(out1)
%
clear f;
clear H;
clear H1;
clear H2;
clear H3;
clear H4;
clear D1;
clear D2;
clear n;
clear omg;
clear omg2;
%
for(i=1:4)
    n(i)=MS(1,i);
end
%
for(i=1:4)
     omg(i)=tpi*fn(i,i);
    omg2(i)=omg(i)^2;
end
%
fstart=fn(1,1)*(1/4);
fend=fn(4,4)*4;
%
for(j=-10:10)
    if(fn(4,4)<10^j)
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
%  fix here....................
%
j=1;
clear f;
clear H;
clear N;
clear D;
clear aaa;
%
f(1)=fstart;
if(f(1)<1.0e-03)
    f(1)=1.0e-03;
end
%
while(1)
%
    i=sqrt(-1);
%
    omga=tpi*f(j);   % base excitation frequency
    om2=omga^2;
%
    for(kj=1:4)
        D(kj)=(omg2(kj)-om2)+i*(2*damp(kj)*omg(kj)*omga);
    end      
%
    for(kj=1:4)
        N(kj)=om2*n(kj)/D(kj);
    end    
%
%
%    aaa= ( MS(1,1)*N1(j) + MS(1,2)*N2(j));
%    bbb= ( MS(2,1)*N1(j) + MS(2,2)*N2(j));
%
%
    for(kj=1:4)
        aaa(kj)= ( MS(kj,1)*N(1) + MS(kj,2)*N(2) + MS(kj,3)*N(3) + MS(kj,4)*N(4) );             
    end
%
    for(kj=1:4)
        H(kj,j)=f1*abs(aaa(kj));
    end
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
    H=H/386;
else
    H=H/9.81; 
end
%
H1=H(1,:);
H2=H(2,:);
H3=H(3,:);
H4=H(4,:);
%
plot(f,H1,f,H2,'-.',f,H3,'--',f,H4,':');
legend ('mass 1','mass 2','mass 3','mass 4');  
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
disp('   accel_3 ');
disp('   accel_4 ');
%
accel_1=[f;H1]';
accel_2=[f;H2]';
accel_3=[f;H3]';
accel_4=[f;H4]';
%
%
for(kj=1:4)
    out1 = sprintf('\n Mass %d:  ',kj);
    disp(out1);
%
    for(j=2:(length(f)-1))
        if(H(kj,j)>H(kj,j-1) & H(kj,j)>H(kj,j+1))
            out1=sprintf(' %8.4g Hz %8.4g G ',f(j),H(kj,j));
            disp(out1);
        end
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
%%
    [writefname, writepname] = uiputfile('*',' Save Mass 3 Response ');
    writepfname = fullfile(writepname, writefname);
    writedata = [f' H3'];
    fid = fopen(writepfname,'w');
    fprintf(fid,'  %g  %g \n',writedata');
    fclose(fid);
%%
    [writefname, writepname] = uiputfile('*',' Save Mass 4 Response ');
    writepfname = fullfile(writepname, writefname);
    writedata = [f' H4'];
    fid = fopen(writepfname,'w');
    fprintf(fid,'  %g  %g \n',writedata');
    fclose(fid);    
end   