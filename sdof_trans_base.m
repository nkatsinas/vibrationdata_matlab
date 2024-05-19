
%  sdof_trans_base.m  ver 1.0  by Tom Irvine

function[accel_complex,rd_complex,accel_mag,rd_mag]=...
                                              sdof_trans_base(freq,fn,damp)
%
    tpi=2*pi;
    
    omega=tpi*freq;
    omegan=tpi*fn;
    
    om2=omega^2;   
    omn2=omegan^2;
    
    den= (omn2-om2) + (1i)*(2*damp*omegan*omega);    
    num=omn2+(1i)*2*damp*omega*omegan;
%
    accel_complex=num/den;
%
    rd_complex=-1/den;

    accel_mag=abs(accel_complex);
    rd_mag=abs(rd_complex);