

% ws_max_param_alt_dv.m  ver 1.0  by Tom Irvine


function[vmax,dmax,vth,dth]=ws_max_param_alt_dv(iunit,th,dt)
%

    [vth]=integrate_function(th,dt);
    [dth]=integrate_function(vth,dt);    
    
    vmax=max(abs(vth));
    dmax=max(abs(dth));    
    
%
    if(iunit==1)
        vmax=vmax*(386.);
        dmax=dmax*(386.);
    end
    if(iunit==2)
        vmax=vmax*(9.81);
        dmax=dmax*(9810.);
    end
    if(iunit==3)
        vmax=vmax*(1.);
        dmax=dmax*(1000.);
    end