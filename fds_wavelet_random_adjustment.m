function[fdsr,ampr,accel_input,err_max]=...
    fds_wavelet_random_adjustment(fdsr,ampr,accel_input,yy,num,err_max,accelr,...
                      Lfn,amp,ijk,NHS,td,nt,dur,t,fn,Qv,bv,dt,cage,f)


    xxx=rand();
    
    if(xxx<=0.5)
        xi=2;
        for i=1:num    
            amp(i)=ampr(i)*(0.98+0.04*rand());
        end
        xxx=1;
    else
        xi=3;
        for i=1:num    
        
            j=cage(i);
        
            d(1)=yy(j,1)/fdsr(j,1);
            d(2)=yy(j,2)/fdsr(j,2);
            d(3)=yy(j,3)/fdsr(j,3);
            d(4)=yy(j,4)/fdsr(j,4);       
            
            d=log10(d);
        
            if(min(d)<0)
                amp(i)=amp(i)*(1-0.02*rand());
            else
                amp(i)=amp(i)*(1+0.02*rand());
            end
        end
        xxx=2;
    end
        
    [accel_input]=generate_th_from_wavelet_table(f,amp,NHS,td,nt,dur,t);
    [fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Qv,bv,accel_input,dt);    
    [err_max,ampr,fdsr,accelr]=fds_wavelet_error_check(err_max,ampr,fdsr,accelr,Lfn,yy,fds,amp,accel_input,ijk,xi);
        