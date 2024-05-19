    
%  fds_sdof_response_rainflow_damage_Qb.m  ver 1.1  by Tom Irvine
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
%     Both Q & b may be 1-dimensional arrays with multiple values, such as
%
%          Q = [10 30]
%          b = [4 8]
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


function[fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Q,b,accel_input,dt)

   zflag=0; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

    NQ=length(Q);
    Nb=length(b);
  
    num=length(fn);

    fn=fix_size(fn);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

    fds=zeros(num,NQ*Nb);
    
    ijk=1;
    
    nc=zeros(NQ,Nb);
    
    for iq=1:NQ
        for ib=1:Nb  
            nc(iq,ib)=ijk;
            ijk=ijk+1;
        end
    end    

    for iq=1:NQ
        
        if(zflag==1)
            return;
        end          
        
        damp=1/(2*Q(iq));
               
        for i=1:num 
            
            if(zflag==1)
                return;
            end           
            
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
            
%  accel_resp = sdof response time history to base input            
        
            try
                forward=[ b1,  b2,  b3 ];    
                back   =[  1, -a1, -a2 ]; 
                accel_resp=filter(forward,back,accel_input);
            catch
                zflag=1;
                warndlg('Fail: filter');
                return;
            end
    
            try
                c=rainflow(accel_resp);
            catch
                size(accel_resp)
                max(accel_resp)
                Q
                b
                zflag=1;
                warndlg('Fail: rainflow');
                return;
            end

% The output array c has five columns:   Count, Range, Mean, Start, and End
% Only the first two columns are needed for the damage calculation  
% The relative damage can then be calculated for a fatigue exponent b  
% The amplitude is one-half of range.

            try
                cycles=c(:,1);
                amp=c(:,2)/2;
                
                for ib=1:Nb      
                    damage=sum( cycles.*amp.^b(ib) );
                    fds(i,(nc(iq,ib)))=damage;
                end
            catch
                zflag=1;
                warndlg('Fail: damage');
                return;                
            end
            
            if(zflag==1)
                return;
            end
                
        end
        
        if(zflag==1)
            return;
        end
        
    end

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
