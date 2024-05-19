%
%  rectangular_plate_th_plot.m  ver 1.0  September 28, 2012
%
function[acc,rel_disp,fig_num]=rectangular_plate_th(t,acc,rel_disp,abase,...
                                   nodex,nodey,con_dof,num_con_dof,fig_num)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
con_dof=sort(con_dof);
%
for i=1:num_con_dof
    ijk=con_dof(i);
    [acc]=add_column(acc,ijk);
    [rel_disp]=add_column(rel_disp,ijk);   
end
%
%
while(1)
%
    disp(' ');
    sn=input(' Enter response node for plotting ');
%
    plot_dof=3*sn-2;
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,acc(:,plot_dof),t,abase);
%
    out1=sprintf(' Acceleration  Node %d, x=%8.4g  y=%8.4g in',...
                                                   sn,nodex(sn),nodey(sn));    
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
    out1=sprintf(' Relative Displacement %d, x=%8.4g  y=%8.4g in',...
                                                   sn,nodex(sn),nodey(sn));    
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