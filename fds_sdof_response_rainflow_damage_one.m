    
%  fds_sdof_response_rainflow_damage_one.m  ver 1.1  by Tom Irvine
%

% Fatigue Damage Spectrum
%
% SDOF acceleration response to base input acceleration time history 
% via David O. Smallwood digital recursive filtering relationship
%
% The base input time history must have a constant time step
%
%          fn = natural frequency (Hz)
%           Q = amplification factor (typically 10 <= Q <=30)
%           b = fatigue exponent (typically 4 <= b <= 8 )
%
%
% accel_input = base input acceleration time history amplitude 
%          dt = acceleration input time step
%
%     fstart = starting frequency (Hz)
%       fend = ending frequency (Hz)
%
%   The ending frequency is limited to the sample rate divided by 5
%
%   The sample rate is the inverse of the time step
%
%
%    ispace is frequency spacing index
%
%    ispace=1 for 1/6 octave
%          =2 for 1/12 octave
%          =3 for 1/24 octave
%
%
%   fds has multiple columns:
%       natural frequency (Hz)
%       and relative damage (accel unit)^b for each Q and b combination 
%                


function[fds]=fds_sdof_response_rainflow_damage_one(fn,Q,b,accel_input,dt)


    sr=1/dt;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
 
    num=length(fn);

    fn=fix_size(fn);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
 
    ncols=1;
    NQ=1;
    Nb=1;

    fds=zeros(num,ncols);
    
    nc=zeros(NQ,Nb);
    
            
    for iq=1:ncols
        
        damp=1/(2*Q(iq));
        
       
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

%  accel_resp = sdof response time history to base input
    
            accel_resp=filter(forward,back,accel_input);
    
            c=rainflow(accel_resp);

% The output array c has five columns:   Count, Range, Mean, Start, and End
% Only the first two columns are needed for the damage calculation  
% The relative damage can then be calculated for a fatigue exponent b  
% The amplitude is one-half of range.

            cycles=c(:,1);
            amp=c(:,2)/2;
                
            for ib=1:Nb      
                damage=sum( cycles.*amp.^b(ib) );
                fds(i,(nc(iq,ib)+1))=damage;
            end
        
        end
        
    end

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
