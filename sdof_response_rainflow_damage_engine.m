    
%  sdof_response_rainflow_damage_engine.m  ver 1.0  by Tom Irvine

%
% SDOF acceleration response to base input acceleration time history 
% via David O. Smallwood digital recursive filtering relationship
%
% The base input time history must have a constant time step
%
%          fn = natural frequency (Hz)
%           Q = amplification factor, typically Q=10
%           b = fatigue exponent (typically: 4 <= b <= 8 )
%
% accel_input = base input acceleration time history amplitude 
%          dt = acceleration input time step

%  accel_resp = sdof response time history to base input

% Response acceleration has same unit as input acceleration
%
%     damage = relative damage, dimension: (acceleration unit)^b


function[accel_resp,damage]=sdof_response_rainflow_damage_engine(fn,Q,b,accel_input,dt)

    damp=1/(2*Q);

    omega=2*pi*fn;
    omegad=omega*sqrt(1-damp^2);

    E=(exp(-damp*omega*dt));
    K=(omegad*dt);
    C=(E*cos(K));
    S=(E*sin(K));

    Sp=S/K;

    a1=(2*C);
    a2=(-(E^2));

    b1=(1.-Sp);
    b2=(2.*(Sp-C));
    b3=((E^2)-Sp);

    forward=[ b1,  b2,  b3 ];    
    back   =[  1, -a1, -a2 ];    

    accel_resp=filter(forward,back,accel_input);
    
    
    c=rainflow(accel_resp);

% The output array c has five columns:   Count, Range, Mean, Start, and End
% Only the first two columns are needed for the damage calculation  
% The relative damage can then be calculated for a fatigue exponent b  
% The amplitude is one-half of range.

    cycles=c(:,1);
    amp=c(:,2)/2;
    damage=sum( cycles.*amp.^b );

    