
%  beam_FEA_base_arbitrary_BC3.m  ver 1.2  by Tom Irvine

function[accel,rel_disp,stress,fig_num]=...
               beam_FEA_base_arbitrary_BC3(ndof,acc,ddd,dt,fn,iu,nde,dx,nt,tpi,cna,E,fig_num,THM)

Y=zeros(nt,4);

rel_acc=( acc(:,3)-acc(:,1) );
free_rel_acc=( acc(:,ndof-1)-acc(:,1) );

if(nde==1)

    [rv]=integrate_function(rel_acc,dt);
    rv=rv-mean(rv); 
    [rd]=integrate_function(rv,dt);
    rd=detrend(rd);    
    
    [free_rv]=integrate_function(free_rel_acc,dt);
    free_rv=free_rv-mean(free_rv); 
    [free_rd]=integrate_function(free_rv,dt);
    free_rd=detrend(free_rd);    

else
    
    [rv]=integrate_function(rel_acc,dt);
    [rd]=integrate_function(rv,dt);
    
    [free_rv]=integrate_function(free_rel_acc,dt);
    [free_rd]=integrate_function(free_rv,dt);    

end    

free_rel_disp=free_rd;

free_pv=free_rel_acc/(tpi*fn(1));

[rv]=differentiate_function(free_rd,dt);


if(iu==1)
   acc=acc/386; 
else
   acc=acc/9.81;
   free_rel_disp=free_rel_disp*1000;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('Calculate Stress');

L=dx;
L2=L^2;

out1=sprintf('\n dx=%8.4g  cna=%8.4g  \n',dx,cna);
disp(out1);


%
%  http://home.sogang.ac.kr/sites/cmlab/Coursework/course001/Lists/b141/Attachments/1/Ch.02%20(pp.%2017-40)%20Bars%20and%20Beams.%20Linear%20Static%20Analysis.pdf
%


    x=0;
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

plot(THM(:,1),acc(:,ndof-1));

aaa=acc(:,ndof-1);

t_string=sprintf('Acceleration at Beam Center \n Max=%7.4g G   Min=%7.4g G    %7.3g GRMS',max(aaa),min(aaa),std(aaa));
title(t_string,'fontsize',10.5);

xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure(fig_num);
fig_num=fig_num+1;

plot(THM(:,1),free_rel_disp);

srdmax=max(free_rel_disp);
srdmin=min(free_rel_disp);
srd=std(free_rel_disp);


if(iu==1)
    t_string=sprintf('Relative Displacement at Beam Center \n max=%7.3g in  min=%7.3g in  %7.3g in RMS',srdmax,srdmin,srd);
    ylabel('Rel Disp (in)');
else
    t_string=sprintf('Relative Displacement at Beam Center \n max=%7.3g mm  min=%7.3g mm  %7.3g mm RMS',srdmax,srdmin,srd);
    ylabel('Rel Disp (mm)');   
end


xlabel('Time (sec)');

title(t_string,'fontsize',10.5);
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;

plot(THM(:,1),stress);

stss=std(stress);

if(iu==1)
    t_string=sprintf('Bending Stress at Beam Left Fixed End \nMax=%7.5g psi  Min=%7.5g psi   %6.4g psi RMS',max(stress),min(stress),stss);
else
    t_string=sprintf('Bending Stress at Beam Left Fixed End \nMax=%7.5g Pa  Min=%7.5g Pa   %6.4g Pa RMS',max(stress),min(stress),stss);    
end

title(t_string,'fontsize',10.5);

xlabel('Time (sec)');
if(iu==1)
    ylabel('Stress (psi)');
else
    ylabel('Stress (Pa)');    
end
grid on;


disp(' ');
disp('  Beam Center Accel(G) ');
disp('  ');
disp('      Max    Min    RMS ');

out1=sprintf('%8.4g %8.4g %8.4g',max(acc(:,ndof-1)),min(acc(:,ndof-1)),std(acc(:,ndof-1)));
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
    disp('  Beam Center Relative Velocity (in/sec)');
else
    disp('  Beam Center Relative Velocity (m/sec)');
end
disp('  ');
disp('      Max    Min    RMS ');

out1=sprintf('%8.4g %8.4g %8.4g',max(free_rv),min(free_rv),std(free_rv));
disp(out1);

% % % % % % % % % % % % % % % % % % % %


disp(' ');
if(iu==1)
    disp('  Beam Center Relative Displacement (in) ');
else
    disp('  Beam Center Relative Displacement (mm) ');
end
disp('  ');
disp('      Max    Min    RMS ');

out1=sprintf('%8.4g %8.4g %8.4g',max(free_rel_disp),min(free_rel_disp),std(free_rel_disp));
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


   accel=[THM(:,1) acc(:,ndof-1)];
rel_disp=[THM(:,1) free_rel_disp];
  stress=[THM(:,1) stress];


disp(' ');