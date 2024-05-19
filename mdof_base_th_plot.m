%
%   mdof_base_th_plot.m  ver 1.0  September 29, 2012  
%
function[acc,rel_disp,fig_num]=...
                           mdof_base_th_plot(t,acc,rel_disp,abase,fig_num)
%
%
while(1)
%
    disp(' ');
    sn=input(' Enter response dof for plotting ');
%
    plot_dof=sn;
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,acc(:,plot_dof),t,abase);
%
    out1=sprintf(' Acceleration  dof %d ',sn);    
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
    out1=sprintf(' Relative Displacement dof %d',sn);    
    title(out1);
    ylabel('Rel Disp(in) ');
    xlabel('Time(sec)');  
    grid on;
%
%
    out1=sprintf('\n  Response at dof %d \n',sn);
    out2=sprintf('       Accel(G):  max=%7.4g  min=%7.4g ',max(acc(:,plot_dof)),min(acc(:,plot_dof)));
    out3=sprintf('   Rel Disp(in):  max=%7.4g  min=%7.4g ',max(rel_disp(:,plot_dof)),min(rel_disp(:,plot_dof)));
%    
    disp(out1);
    disp(out2);  
    disp(out3);   
%
    disp(' ');
    disp(' Plot response at another dof?  1=yes 2=no ');
    ian=input(' ');
    if(ian==2)
        break;
    end
%
end
%
acc=[t acc];
rel_disp=[t rel_disp];