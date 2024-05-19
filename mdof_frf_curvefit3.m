disp(' ');
disp(' mdof_frf_curvefit.m  ver 1.3  January 22, 2014 ');
disp(' ');
disp(' by Tom Irvine ');
disp(' ');
disp(' This script extracts modal frequencies and damping from an FRF ');
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear HFRF;
clear HW;
clear Hsum;
clear frf_r;
clear frf_i;
clear f;
clear fest;
clear sum;
clear nh;
clear num;
clear NM;
%
close all;
%
fig_num=1;
%
tpi=2*pi;
%
disp(' The input FRF must have two columns:  freq(Hz) complex amp ');
disp(' ');
HFRF=input(' Enter the input array name  ');
sz=size(HFRF);
nh=sz(1);
f=HFRF(:,1);
%
disp(' ');
disp(' Select input FRF type ');
disp('  1=Acceleration/Force ');
disp('  2=    Velocity/Force ');
disp('  3=Displacement/Force ');
iresp=input(' ');
%
disp(' ');
fstart=input(' Enter starting frequency for curve-fit:  ');
fend  =input(' Enter ending   frequency for curve-fit:  ');
%
for i=1:nh
    if(f(i)>=fstart)
        i1=i;
        break;
    end
end
%
for i=1:nh
    if(f(i)>fend)
        i2=i-1;
        break;
    end
end
%
if(i2>nh)
    i2=nh;
end
%
disp(' ');
num=input(' Enter number of natural frequencies for curve-fit: ');
%
disp(' ');
fest=zeros(num,1);
for i=1:num
    out1=sprintf(' Enter frequency esimate %d:   ',i);
    fest(i)=input(out1);
end
%
disp(' ');
out1=sprintf(' Enter number of trials (suggest %d) ',num*5000);
ntrials=input(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(iresp==1)
%
   tlabel='Acceleration';
   yl='Accel/Force';
%    
   MFRF_R=@(omega,rho,damp)(real(-omega^2/((1-rho^2)+(1i)*(2*damp*rho)))); 
   MFRF_I=@(omega,rho,damp)(imag(-omega^2/((1-rho^2)+(1i)*(2*damp*rho)))); 
%      
end
%
if(iresp==2)
%
   tlabel='Velocity';
   yl='Velocity/Force';   
   
%    
   MFRF_R=@(omega,rho,damp)(real((1i)*omega/((1-rho^2)+(1i)*(2*damp*rho))));
   MFRF_I=@(omega,rho,damp)(imag((1i)*omega/((1-rho^2)+(1i)*(2*damp*rho))));   
%        
end
%
if(iresp==3)
%
   tlabel='Displacement';
   yl='Disp/Force';   
%
   MFRF_R=@(omega,rho,damp)(real(1/((1-rho^2)+(1i)*(2*damp*rho))));    
   MFRF_I=@(omega,rho,damp)(imag(1/((1-rho^2)+(1i)*(2*damp*rho)))); 
%      
end
%
%%% HW=HFRF(:,2);
frf_r=HFRF(:,2);
frf_i=HFRF(:,3);
Hsum=zeros(nh,1);
%
NM=zeros(num,1);
fr=zeros(num,1);
dr=zeros(num,1);
AXr=zeros(num,1);
%
c_r=zeros(nh,num);
c_i=zeros(nh,num);
%
c_r_rec=zeros(nh,num);
c_i_rec=zeros(nh,num);
%
for nv=1:num
    NM(nv)=nv;
end    
%
%%%  for nv=1:num
%    
    errormax=1.0e+90;
%
    maxa=0;
%
    for i=i1:i2
        if( sqrt(frf_r(i)^2+frf_i(i)^2 )>maxa)
            maxa=sqrt(frf_r(i)^2+frf_i(i)^2 );
            maxf=f(i);
        end
    end
%
    disp('  ');
    disp(' n   error     A       fn       damp ');
%
    [fr,dr,AXr,errormax]=...
    mdof_frf_curvefit_phase1(num,NM,maxa,maxf,c_r,c_i,c_r_rec,c_i_rec,...
                             fr,dr,AXr,MFRF_R,MFRF_I,tlabel,yl,errormax,...
                             nh,fest,ntrials,f,Hsum,i1,i2,frf_r,frf_i);  
%
%    
%%% end
%
disp(' ');
disp(' Results ');
disp(' n   freq(Hz)  damping ');
for i=1:num
    out1=sprintf(' %d.  %8.4g  %8.3g ',i,fr(i),dr(i));
    disp(out1);
end    