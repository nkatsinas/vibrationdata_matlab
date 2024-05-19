    
%  fds_sdof_response_apvrd.m  ver 1.2  by Tom Irvine
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions
% 
%      fix_size
%      sdof_response_engine.m
%      ytick_linear_min_max_alt.m
%      xtick_label.m
%      plot_fds_function.m
%      plot_fds_1x2_function.m
%      plot_fds_2x2_function.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[fds_a,fds_pv,fds_rd]=fds_sdof_response_apvrd(fstart,fend,ispace,Q,b,accel_input,dt,iu,nFDS)

    close all;

    sr=1/dt;
    
    fmax=sr/5;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

    num=1;
    fn(1)=fstart;

    if(ispace==1)
        oct=2^(1/3);
    end     
    if(ispace==2)
        oct=2^(1/6);
    end   
    if(ispace==3)
        oct=2^(1/12);
    end    
    if(ispace==4)
        oct=2^(1/24);
    end    
    if(ispace==5)
        oct=2^(1/48);
    end   

    while(1)
    
        num=num+1;
  
        fn(num)=fn(num-1)*oct;
  
        if(fn(num)>fmax)
            break;
        end

        if(fn(num)==fend)
            break;
        end

        if(fn(num)>fend)
            fn(num)=fend;
            break;
        end
    
    end 
 
    num=length(fn);

    fn=fix_size(fn);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
    NQ=length(Q);
    Nb=length(b);

    m=NQ*Nb+1;

    fds_a=zeros(num,m);
    fds_pv=zeros(num,m);
    fds_rd=zeros(num,m);    
    
    fds_a(:,1)=fn;
    fds_pv(:,1)=fn;    
    fds_rd(:,1)=fn;

    nc=zeros(NQ,Nb);
    
    ijk=1;
    
    for iq=1:NQ
        for ib=1:Nb  
            nc(iq,ib)=ijk;
            ijk=ijk+1;
        end
    end    
            
    for iq=1:NQ
        
        for i=1:num 
        
            [accel_resp,rd_resp]=sdof_response_engine(fn(i),Q(iq),accel_input,dt);
    
            c=rainflow(accel_resp);

% The output array c has five columns:   Count, Range, Mean, Start, and End
% Only the first two columns are needed for the damage calculation  
% The relative damage can then be calculated for a fatigue exponent b  
% The amplitude is one-half of range.

            cycles=c(:,1);
            amp=c(:,2)/2;
                
            for ib=1:Nb      
                damage=sum( cycles.*amp.^b(ib) );
                fds_a(i,(nc(iq,ib)+1))=damage;
            end
        
        end
    end
           
    disp(' ');
    disp(' * * * * * * * * * * * * * * ');
    disp(' ');
    disp(' Output array fds has the following columns:');
    disp('  Col 1:  natural frequency (Hz)');
    
    for iq=1:NQ
        for ib=1:Nb  
            fprintf('  Col %d:  fds damage (G^%g)   Q=%g  b=%g \n',(1+nc(iq,ib)),b(ib),Q(iq),b(ib));
        end
    end      
    disp(' ');    
    
