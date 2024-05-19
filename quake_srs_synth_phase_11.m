%
%   quake_srs_synth_phase_11.m  ver 1.7  by Tom Irvine
%
function[ramp]=...
    quake_srs_synth_phase_11(f,amp,NHS,td,last_wavelet,iter,fn,srs_spec,...
                             error_limit,uewf,wavelet_low,wavelet_up,...
                             alpha,beta,a1,a2,b1,b2,b3,t,error_max,num )
                                         
    
tpi=2*pi;                        
                        
%%

                                         
ic=0;
                                     
ramp=amp;


ih=round(iter/3);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
                          
         

for i=1:length(f)
    if(f(i)>max(fn))
        amp(i)=0;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%
for i=1:iter

%
    [aa]=generate_time_history_wavelet_table_q(f,amp,NHS,td,t,...
                                         wavelet_low,wavelet_up,alpha,beta);
                                     
                                     
       
    fmin=0.;
    

    [error,error_p,lerr,merr,fm1,fm2]=...
                   quake_srs_function(b1,b2,b3,a1,a2,fn,num,aa,srs_spec);
               
    fmax=fm1;  % keep
    fmin=fm2;
   
    if(error<error_max );
        
        error_max=error;
        ramp=amp;       
        
        out1=sprintf('%d  %8.4g  %d',i,error,ic);
        disp(out1);
        
    end
    
%
    
    if(i<iter)
        if(i> round(iter*0.03) || i>20)

            if(rand()<0.5)
                if(rand()<0.6 || i > ih)
                    amp=ramp;
                    jk=1+floor(last_wavelet*rand());
                    amp(jk)=ramp(jk)*(0.95+0.1*rand());
                    ic=1;
                else    
                    if(rand()<0.7)
                        for j=1:last_wavelet
                            amp(j)=ramp(j)*(0.99+0.02*rand());
                        end
                        ic=2;
                    else
                        for j=1:last_wavelet
                            amp(j)=ramp(j)*(0.95+0.10*rand());
                        end  
                        ic=3;
                    end 
                end
            else
                if(rand()<0.5)
                    ferr=1.0e+20;
                    for jj=1:length(f)
                        diff=abs(f(jj)-fmax);
                        if(diff<ferr)
                            jk=jj;
                            ferr=diff;
                        end
                    end
                    amp(jk)=ramp(jk)*(0.95+0.1*rand());
                    ic=4;
                else
                    ferr=1.0e+20;
                    for jj=1:length(f)
                        diff=abs(f(jj)-fmin);
                        if(diff<ferr)
                            jk=jj;
                            ferr=diff;
                        end
                    end
                    amp(jk)=ramp(jk)*(0.95+0.1*rand());
                    ic=5;                   
                end
            end
        else
            scale=0.98+0.04*rand();
            amp=ramp*scale;
        end    
    end
%
end

