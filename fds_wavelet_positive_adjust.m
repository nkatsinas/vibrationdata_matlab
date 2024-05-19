function[fdsr,ampr,accelr]=fds_wavelet_positive_adjust(fdsr,ampr,accelr,f,NHS,td,nt,dur,t,fn,Qv,bv,dt,yy,mpa)

amp=ampr;
fds=fdsr;

progressbar;

for ijk=1:mpa

    progressbar(ijk/mpa);
    
    d1=yy(:,1)-fds(:,1);
    d2=yy(:,2)-fds(:,2);
    d3=yy(:,3)-fds(:,3);
    d4=yy(:,4)-fds(:,4);
    
    if(max(d1)>1 || max(d2)>1 || max(d3)>1 || max(d4)>1)
            amp=amp*1.03;
    else
        progressbar(1);
        break;
    end
    
    [accel_input]=generate_th_from_wavelet_table(f,amp,NHS,td,nt,dur,t);
    [fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Qv,bv,accel_input,dt);
    
    accelr=accel_input;
    ampr=amp;
    fdsr=fds;
end

end