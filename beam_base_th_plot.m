%
%  beam_base_th_plot.m  ver 1.3  January 14, 2014
%
function[acc,rel_disp,fig_num]=...
      beam_base_th_plot(t,acc,vel,rel_disp,abase,nodex,ipin,fig_num,iu)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
     [vel]=add_column(vel,2);
     [rel_disp]=add_column(rel_disp,2); 
end
if(ipin==3)
     [acc]=add_column(acc,2);
     [vel]=add_column(vel,2);
     sz=size(acc);
     [acc]=add_column(acc,sz(2)+1);
     [vel]=add_column(vel,sz(2)+1);
%
     [rel_disp]=add_column(rel_disp,2);
     sz=size(rel_disp);
     [rel_disp]=add_column(rel_disp,sz(2)+1);
end
%
sz=size(rel_disp);
%
bp=round(sz(1)/2);
%
for i=1:2:sz(2)
    rel_disp(:,i)=detrend(rel_disp(:,i),'linear',bp);
    ccc=rel_disp(1,i);
    rel_disp(:,i)=rel_disp(:,i)-ccc;
end
%
node_max=length(nodex);
%
while(1)
%
    disp(' ');
    out1=sprintf(' Enter response node for plotting (max=%d) ',node_max);
    disp(out1);
    sn=input(' ');
%
    plot_dof=2*sn-1;
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,acc(:,plot_dof),t,abase);
%
    out1=sprintf(' Acceleration  Node %d, x=%8.4g in',...
                                                   sn,nodex(sn));    
    title(out1);
    ylabel('Accel(G) ');
    xlabel('Time(sec)');
    legend('response','input');  
    grid on;
%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,vel(:,plot_dof));
%
    if(iu==1)
        out1=sprintf(' Velocity  Node %d, x=%8.4g in',sn,nodex(sn));    
        ylabel('Vel(in/sec) ');
    else
        out1=sprintf(' Velocity  Node %d, x=%8.4g meters',sn,nodex(sn));    
        ylabel('Vel(m/sec) ');       
    end    
%    
    title(out1);    
    xlabel('Time(sec)');
    grid on;
%
%%%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rel_disp(:,plot_dof));
%
    if(iu==1)
        out1=sprintf(' Relative Displacement %d, x=%8.4g inch ',sn,nodex(sn));    
        ylabel('Rel Disp(in) ');
    else
        out1=sprintf(' Relative Displacement %d, x=%8.4g meters ',sn,nodex(sn));    
        ylabel('Rel Disp(m) ');        
    end
 %   
    title(out1);
    xlabel('Time(sec)');  
    grid on;
%
%
    out1=sprintf('\n  Response at node %d \n',sn);
    out2=sprintf('       Accel(G):  max=%7.4g  min=%7.4g ',...
                           max(     acc(:,plot_dof)),min(acc(:,plot_dof)));
%
    if(iu==1)
    out3=sprintf('    Vel(in/sec):  max=%7.4g  min=%7.4g ',...
                       max( vel(:,plot_dof)),min(vel(:,plot_dof)));    
    out4=sprintf('   Rel Disp(in):  max=%7.4g  min=%7.4g ',...
                      max(rel_disp(:,plot_dof)),min(rel_disp(:,plot_dof)));
    else
    out3=sprintf('   Vel(m/sec):  max=%7.4g  min=%7.4g ',...
                       max( vel(:,plot_dof)),min(vel(:,plot_dof)));    
    out4=sprintf('   Rel Disp(m):  max=%7.4g  min=%7.4g ',...
                      max(rel_disp(:,plot_dof)),min(rel_disp(:,plot_dof)));        
    end    
%    
    disp(out1);
    disp(out2);  
    disp(out3); 
    disp(out4);
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