    
%  srs_base.m  ver 1.0  by Tom Irvine

% Shock Response Spectrum
%
% SDOF acceleration response to base input acceleration time history 
% via David O. Smallwood digital recursive filtering relationship
%
% The base input time history must have a constant time step
%
%           Q = amplification factor, typically Q=10
% accel_input = base input acceleration time history amplitude accel(G)
%          dt = acceleration input time step
%
%     fstart = starting frequency (Hz)
%       fend = ending frequency (Hz)
%
%   The ending frequency is limited to the sample rate divided by 5
%
%   The sample rate is the inverse of the time step
%
%   accel_pn_srs = SRS with three columns:
%        natural frequency (Hz), peak positive accel (G) 
%                             & peak negative accel (G)
%
%  accel_abs_srs = SRS with two columns:
%       natural frequency (Hz), peak absolute accel (G) 
%     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  External functions
%
%   xtick_label_f
%   generate_plot_srs
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[accel_pn_srs,accel_abs_srs]=srs_base(fstart,fend,Q,accel_input,dt)

    damp=1/(2*Q);
    
    sr=1/dt;
    
    fmax=sr/5;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

    num=1;
    fn(1)=fstart;

    oct=2^(1/24);

    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)*oct;
  
        if(fn(num)>fmax)
            break;
        end
    
    end

    [~,i1]=min(abs(fn-fstart));

    if(fend<fmax)
        [~,i2]=min(abs(fn-fend));    
    else
        [~,i2]=min(abs(fn-fmax));            
    end
    
    fn=fn(i1:i2);  
 
    num=length(fn);

    sz=size(fn);
    if(sz(2)>sz(1))
        fn=transpose(fn);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    peak_pos=zeros(num,1);
    peak_neg=zeros(num,1);
    peak_abs=zeros(num,1);    
     
    for i=1:num

        omega=2*pi*fn(i);
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

        peak_pos(i)=max(accel_resp);
        peak_neg(i)=abs(min(accel_resp));
        peak_abs(i)=max([peak_pos(i) peak_neg(i)]);
        
    end
    
     accel_pn_srs=[fn peak_pos peak_neg];
    accel_abs_srs=[fn peak_abs];
    
    generate_plot_srs(accel_abs_srs,accel_pn_srs,Q);   
    