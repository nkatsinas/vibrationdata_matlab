    
%  fds_engine_apvrd.m  ver 1.2  by Tom Irvine
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
%   The ending frequency is limited to the sample rate divided by 5
%
%   The sample rate is the inverse of the time step
%
%     nFDS=1 for acceleration
%         =2 for pseudo velocity
%         =3 for relative displacement
%
%   fds has multiple columns:
%       natural frequency (Hz)
%       and relative damage (unit)^b for each Q and b combination 
%                
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions
% 
%      fix_size
%      sdof_response_arbitrary.m
%      ytick_linear_min_max_alt.m
%      xtick_label.m
%      plot_fds_function.m
%      plot_fds_1x2_function.m
%      plot_fds_2x2_function.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[fds_n]=fds_engine_apvrd(fn,Q,b,accel_input,dt,iu,nFDS)    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
 
    num=length(fn);

    fn=fix_size(fn);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    NQ=length(Q);
    Nb=length(b);

    m=NQ*Nb+1;

    nc=zeros(NQ,Nb);
    
    ijk=1;
    
    for iq=1:NQ
        for ib=1:Nb  
            nc(iq,ib)=ijk;
            ijk=ijk+1;
        end
    end    

    fds_n=zeros(num,m-1);

    kk=0;

    NQn=NQ*num;

    progressbar;
            
    for iq=1:NQ

        damp=1/(2*Q(iq));
        
        for i=1:num

            progressbar(kk/NQn);
            kk=kk+1;

            [accel,pv,rd]=sdof_response_arbitrary(accel_input,fn(i),damp,dt,iu);
        
            if(nFDS==1 || nFDS==4)
                c=rainflow(accel);                
            end    
            if(nFDS==2)
                c=rainflow(pv);                
            end    
            if(nFDS==3)
                c=rainflow(rd);                
            end

% The output array c has five columns:   Count, Range, Mean, Start, and End
% Only the first two columns are needed for the damage calculation  
% The relative damage can then be calculated for a fatigue exponent b  
% The amplitude is one-half of range.

            cycles=c(:,1);
            amp=c(:,2)/2;
                
            for ib=1:Nb      
                damage=sum( cycles.*amp.^b(ib) );
                fds_n(i,nc(iq,ib))=damage;
            end
        
        end
    end
    pause(0.1);
    progressbar(1);