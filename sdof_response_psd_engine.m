
% sdof_response_psd_engine.m  ver 1.0  by Tom Irvine

% sdof response to PSD base input

function[response_psd]=sdof_response_psd_engine(fn,damp,base_psd)

     freq=base_psd(:,1);
     base_psd_int=base_psd(:,2);
     
     tpi=2*pi;
    
    omega=tpi*freq;
    omegan=tpi*fn;
    
    om2=omega.^2;   
    omn2=omegan.^2;
    
    
    den= (omn2-om2) + (1i)*(2*damp*omegan*omega);    
    num=omn2+(1i)*2*damp*omega*omegan;
%
    accel_complex=num./den;

    freq=fix_size(freq);
    accel_complex=fix_size(accel_complex);
    
    power_trans=(abs(accel_complex)).^2;

    response_psd=power_trans.*base_psd_int;
    
    response_psd=[freq response_psd];