
%  beam_FEA_base_arbitrary_BC2.m  ver 1.1  by Tom Irvine

function[accel,rel_disp,stress,fig_num]=...
               beam_FEA_base_arbitrary_BC2(ndof,acc,ddd,dt,fn,iu,nde,dx,nt,tpi,cna,E,fig_num,THM,mid_dof)



Y=zeros(nt,4);

rel_acc=( acc(:,mid_dof)-acc(:,1) );

mid_rel_acc=rel_acc;

if(nde==1)

    [rv]=integrate_function(mid_rel_acc,dt);
    rv=rv-mean(rv); 
    
    [rd]=integrate_function(rv,dt);
    rd=detrend(rd);
   
else    
   
    [rv]=integrate_function(rel_acc(:,2),dt);
    [rd]=integrate_function(rv,dt);
     
end    


mid_rel_disp=rd;

mid_pv=mid_rel_acc/(tpi*fn(1));

[mid_rv]=differentiate_function(mid_rel_disp,dt);



if(iu==1)
   acc=acc/386; 
else
   acc=acc/9.81;
   mid_rel_disp=mid_rel_disp*1000;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Calculate Stress');


L=dx;
x=L;

    [B]=beam_stress_B(x,L);

    
    Y(:,1)=0;
    Y(:,2)=ddd(:,2);
    Y(:,3)=rd(:);
    Y(:,2)=ddd(:,4);    

cnaE=cna*E;
 
out1=sprintf('\n nt=%d ',nt);    
disp(out1);    

stress=cnaE*(B*[Y(:,1) Y(:,2) Y(:,3) Y(:,4) ]')';
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' plot data ');

sz=size(acc);
ndof=sz(2);

figure(fig_num);
fig_num=fig_num+1;

plot(THM(:,1),acc(:,mid_dof));

aaa=acc(:,mid_dof);

t_string=sprintf('Acceleration at Beam Midspan \n Max=%7.4g G   Min=%7.4g G    %7.3g GRMS',max(aaa),min(aaa),std(aaa));
title(t_string,'fontsize',10.5);

xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(fig_num);
fig_num=fig_num+1;

plot(THM(:,1),mid_rel_disp);

srdmax=max(mid_rel_disp);
srdmin=min(mid_rel_disp);
srd=std(mid_rel_disp);


if(iu==1)
    t_string=sprintf('Relative Displacement at Beam Midspan \n max=%7.3g in  min=%7.3g in  %7.3g in RMS',srdmax,srdmin,srd);
    ylabel('Rel Disp (in)');
else
    t_string=sprintf('Relative Displacement at Beam Midspan \n max=%7.3g mm  min=%7.3g mm  %7.3g mm RMS',srdmax,srdmin,srd);
    ylabel('Rel Disp (mm)');   
end


xlabel('Time (sec)');

title(t_string,'fontsize',10.5);
grid on;


figure(fig_num);
fig_num=fig_num+1;

plot(THM(:,1),stress);

stss=std(stress);

if(iu==1)
    t_string=sprintf('Bending Stress at Midspan \nMax=%7.5g psi  Min=%7.5g psi   %6.4g psi RMS',max(stress),min(stress),stss);
else
    t_string=sprintf('Bending Stress at Midspan \nMax=%7.5g Pa  Min=%7.5g Pa   %6.4g Pa RMS',max(stress),min(stress),stss);    
end

title(t_string,'fontsize',10.5);

xlabel('Time (sec)');
if(iu==1)
    ylabel('Stress (psi)');
else
    ylabel('Stress (Pa)');    
end
grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp(' ');
disp('  Beam Midspan Accel(G) ');
disp('  ');
disp('      Max    Min    RMS ');

out1=sprintf('%8.4g %8.4g %8.4g',max(acc(:,mid_dof)),min(acc(:,mid_dof)),std(acc(:,mid_dof)));
disp(out1);

% % % % % % % % % % % % % % % % % % % %

disp(' ');
if(iu==1)
    disp('  Beam Mid Span Pseudo Velocity (in/sec) from Fundamental Mode');
    sss=386;
else
    disp('  Beam Mid Span Pseudo Velocity (m/sec) from Fundamental Mode');
    sss=1;
end

aaa=max(abs(acc(:,ndof-1)));
PV=sss*aaa/(2*pi*fn(1));

disp('  ');
disp('      Max Abs');

fprintf('%8.4g \n',PV);

% % % % % % % % % % % % % % % % % % % %

disp(' ');
if(iu==1)
    disp('  Beam Midspan Relative Velocity (in/sec)');
else
    disp('  Beam Midspan Relative Velocity (m/sec)');
end
disp('  ');
disp('      Max    Min    RMS ');

out1=sprintf('%8.4g %8.4g %8.4g',max(mid_rv),min(mid_rv),std(mid_rv));
disp(out1);

% % % % % % % % % % % % % % % % % % % %

disp(' ');
if(iu==1)
    disp('  Beam Midspan Relative Displacement (in) ');
else
    disp('  Beam Midspan Relative Displacement (mm) ');
end
disp('  ');
disp('      Max    Min    RMS ');

out1=sprintf('%8.4g %8.4g %8.4g',max(mid_rel_disp),min(mid_rel_disp),std(mid_rel_disp));
disp(out1);


% % % % % % % % % % % % % % % % % % % %


disp(' ');
if(iu==1)
    disp('  Beam Fixed End  Stress(psi) ');
else
    disp('  Beam Fixed End  Stress(Pa) ');    
end
disp('  ');
disp('      Max    Min    RMS ');

out1=sprintf('%8.4g %8.4g %8.4g',max(stress),min(stress),std(stress));
disp(out1);

disp(' ');

% % % % % % % % % % % % % % % % % % % %

   accel=[THM(:,1) acc(:,mid_dof)];
rel_disp=[THM(:,1) mid_rel_disp];
  stress=[THM(:,1) stress];