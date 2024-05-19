disp(' ');
disp(' beam.m,  ver 1.8, January 15, 2014 ');
disp(' ');
disp(' by Tom Irvine ');
disp(' Email: tom@vibrationdata.com ');
disp(' ');
disp(' This script calculates the bending natural frequencies of a ');
disp(' straight beam via the finite element method. ');
disp(' ');
%
clear length;
clear sum;
clear mass;
clear stiff;
clear A;
clear I;
clear E;
clear fn;
clear ModeShapes;
clear MST;
clear mode;
clear omega;
clear mmm;
%
close all
%
disp(' ');
disp(' Select units:  1=English  2=metric ');
iu=input(' ');
%
[E,I,A,rho,ibc,ne,total_length,xv,dx,dof,ipm,pm,xpm]=beam_data_entry(iu);
%
dof_orig=2*ne+2;
%
[klocal] = local_stiffness(E,I,ne,dx);
[mlocal] = local_mass(rho,ne,dx);
%
[stiff,mass,dof,dof_status]=assembly(ne,klocal,mlocal,ibc,dof,ipm,pm,xpm,dx);
%
disp(' ');
disp(' Apply mass condensation?');
icmc=input(' 1=yes 2=no ');
if (icmc==1)
    [S2,M2,mass,C,dof]=mass_condense(stiff,mass,dof);
end
%
if(icmc==1)
    [fn,omega,ModeShapes,MST]=Generalized_Eigen(S2,M2,2);
else
    [fn,omega,ModeShapes,MST]=Generalized_Eigen(stiff,mass,2);
end
%
mode=ModeShapes;
%
v=ones(dof,1);
%
disp(' ');
disp('        Natural    Participation    Effective  ');
disp('Mode   Frequency      Factor        Modal Mass ');
%    
%  The accuracy decreases with mode number.
%
pff=zeros(dof,1);
emm=zeros(dof,1);
%
if(icmc==1)
%      
   fmode=C*mode;
   mmm=fmode'*mass*fmode;   
%
   for i=1:2*dof
       v(i)=1.;
   end
%
   szz=size(v);
   if(szz(2)>szz(1))
       v=v';
   end
%
   LM=fmode'*mass*v;
   pf=LM;
   sum=0;
%
    for i=1:dof
        pff(i)=pf(i)/mmm(i,i);
        emm(i)=pf(i)^2/mmm(i,i);
        if(emm(i) < rho*total_length/100000.)
            emm(i)=0.;
            pff(i)=0.;
        end
    end
%    
    for i=1:dof
        out1 = sprintf('%d  %10.4g Hz   %10.4g   %10.4g',i,fn(i),pff(i),emm(i) );
        disp(out1)
        sum=sum+emm(i);
    end
end    
if(icmc==2)
    LM=mode'*mass*v;
    pf=LM;
    sum=0;
%    
    mmm=mode'*mass*mode;   
%  
    for i=1:dof
        pff(i)=pf(i)/mmm(i,i);
        emm(i)=pf(i)^2/mmm(i,i);
        if(emm(i) < rho*total_length/100000.)
            emm(i)=0.;
            pff(i)=0.;
        end
        out1 = sprintf('%d  %10.4g Hz   %10.4g   %10.4g',i,fn(i),pff(i),emm(i) );
        disp(out1)
        sum=sum+emm(i);
    end
end
disp(' ')
out1 = sprintf(' Total Effective Modal Mass = %10.4g lbf sec^2/in',sum );
disp(out1)
%
disp(' ')
out1 = sprintf(' Total Mass = %10.4g lbf sec^2/in',(pm + rho*total_length) );
disp(out1)
if(iu==1)
    out1 = sprintf('            = %10.4g lbm',(pm*386 + rho*total_length*386. ));
else
    out1 = sprintf('            = %10.4g lbm',(pm + rho*total_length )); 
end    
disp(out1)
%
if(max(xv)>total_length)
    xv(length(xv))=[];
end
%
if(icmc==2)
    [pmode]=plot_modes(dof_status,mode,dof,xv,fn,iu);
end
%
clear sum;
%
disp(' ');
disp(' Output arrays: ');
disp('  ');
disp('      stiff - stiffness matrix ');
disp('       mass - mass matrix ');
disp('   ');
disp('         fn - natural frequencies ');
disp(' ModeShapes - mode shapes      ');