    
%  sdof_response_engine.m  ver 1.1  by Tom Irvine

%
% SDOF acceleration response to base input acceleration time history 
% via David O. Smallwood digital recursive filtering relationship
%
% The base input time history must have a constant time step
%
%          fn = natural frequency (Hz)
%           Q = amplification factor, typically Q=10
% accel_input = base input time history acceleration (G)
%          dt = acceleration input time step (must be constant)
%
%        unit = relative displacement unit:  1 for inch, 2 for mm
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output variables
%
%  accel_resp = sdof response time history to base input
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  External functions
%
%    srs_coefficients
%    subplots_two_linlin_two_titles
%    ytick_linear_double_sided
%    fix_size
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[accel_resp,rd_resp]=sdof_response_engine(fn,Q,accel_input,dt,unit)

    damp=1/(2*Q);
       
    [a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                               srs_coefficients(fn,damp,dt);

    forward=[ b1,  b2,  b3 ];    
    back   =[  1, -a1, -a2 ];    
    accel_resp=filter(forward,back,accel_input);

    forward=[ rd_b1,  rd_b2,  rd_b3 ];    
    back   =[  1, -rd_a1, -rd_a2 ];    
    rd_resp=filter(forward,back,accel_input);

    if(unit==1)
        scale=386;
    else
        scale=9.81*1000;
    end
    rd_resp=rd_resp*scale;

    fig_num=1;

    n=length(accel_input);
   
    t=((1:n)-1)*dt;

    t=fix_size(t);
    accel_input=fix_size(accel_input);
    accel_resp=fix_size(accel_resp);
    rd_resp=fix_size(rd_resp);

    data1=[t accel_input];
    data2=[t accel_resp];

    ylabel1='Accel (G)';
    ylabel2='Accel (G)';
    xlabel2='Time (sec)';
            
    t_string1=('Base Input');
    t_string2=sprintf('Acceleration Response fn=%g Hz  Q=%g',fn,Q);
            
    [fig_num]=subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,...
                                                      data1,data2,t_string1,t_string2);

    figure(fig_num);
    plot(t,rd_resp);
    out1=sprintf('Relative Displacement fn=%g Hz  Q=%g',fn,Q);
    title(out1);
    xlabel(' Time(sec) ')
    if(unit==1)
        ylabel('Rel Disp (in)')
    else
        ylabel('Rel Disp (mm)')
    end
    grid on;
