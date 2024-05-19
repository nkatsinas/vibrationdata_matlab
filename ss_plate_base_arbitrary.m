%
%  plate_base_arbitrary.m  ver 1.1  October 1, 2012
%
%
function[fig_num]=plate_base_arbitrary(fn,damp,PF,NT,Amn,pax,pby,...
                                               x,y,m_index,n_index,fig_num)
%
    iu=1;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    disp(' ');
    disp(' Peak Response Values ');
    out1=sprintf('          Acceleration = %8.4g G',max(abs(acc)));
%   
    if(iu==1)
        out2=sprintf('\n Relative Displacement = %8.4g in',max(abs(rd)));    
    else
        out2=sprintf('\n Relative Displacement = %8.4g m',max(abs(rd)));        
    end
%    
    disp(out2);
    disp(out1);
%
%%%
%%%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rd);
%
    out1=sprintf(' Relative Displacement at x=%7.4g in  y=%7.4g in',x,y);
    title(out1);
    if(iu==1)
        ylabel('Rel Disp(in) ');
    else
        ylabel('Rel Disp(m) ');
    end
    xlabel('Time(sec)');
    grid on;
%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,acc,t,abase);
%
    out1=sprintf(' Acceleration at x=%7.4g in  y=%7.4g in',x,y);
    title(out1);
    ylabel('Accel(G) ');
    xlabel('Time(sec)');
    legend('response','input');  
    grid on;
%