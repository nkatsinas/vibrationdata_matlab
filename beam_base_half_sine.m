%
%  beam_base_half_sine.m  ver 1.0  September 28, 2012
%
function[acc,rel_disp,abase,fig_num]=...
    beam_base_half_sine(fn,damp,PF,ModeShapes,T1,T2,ngw,...
                                   nodex,ipin,fig_num)
%
[t,acc,rel_disp,abase]=mdof_half_sine_core(fn,damp,PF,ModeShapes,T1,T2,ngw);
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%%
%%%% disp('  Constraint rotational dof ');
%%%% disp('  1=none '); 
%%%% disp('  2=left end only ');
%%%% disp('  3=left & right ends  ')
% fix here..
%
if(ipin==2)
     [acc]=add_column(acc,2);
     [rel_disp]=add_column(rel_disp,2); 
end
if(ipin==3)
     [acc]=add_column(acc,2);
     sz=size(acc);
     [acc]=add_column(acc,sz(2)+1);
%
     [rel_disp]=add_column(rel_disp,2);
     sz=size(rel_disp);
     [rel_disp]=add_column(rel_disp,sz(2)+1);
end
%
%
while(1)
%
    disp(' ');
    sn=input(' Enter response node for plotting ');
%
    plot_dof=2*sn-1;
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,acc(:,plot_dof),t,abase);
%
    out1=sprintf(' Acceleration  Node %d relative to Base, x=%8.4g in',...
                                                   sn,nodex(sn));    
    title(out1);
    ylabel('Accel(G) ');
    xlabel('Time(sec)');
    legend('response','input');  
    grid on;
%
%%%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rel_disp(:,plot_dof));
%
    out1=sprintf(' Relative Displacement %d, x=%8.4g  ',sn,nodex(sn));    
    title(out1);
    ylabel('Rel Disp(in) ');
    xlabel('Time(sec)');  
    grid on;
%
%
    out1=sprintf('\n  Response at node %d \n',sn);
    out2=sprintf('       Accel(G):  max=%7.4g  min=%7.4g ',max(acc(:,plot_dof)),min(acc(:,plot_dof)));
    out3=sprintf('   Rel Disp(in):  max=%7.4g  min=%7.4g ',max(rel_disp(:,plot_dof)),min(rel_disp(:,plot_dof)));
%    
    disp(out1);
    disp(out2);  
    disp(out3);   
%
    disp(' ');
    disp(' Plot response at another node?  1=yes 2=no ');
    ian=input(' ');
    if(ian==2)
        break;
    end
%
end
%
acc=[t acc];
rel_disp=[t rel_disp];