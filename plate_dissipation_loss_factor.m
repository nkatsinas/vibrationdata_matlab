%
%  plate_dissipation_loss_factor.m  ver 1.0  by Tom Irvine
%

function[lf]=plate_dissipation_loss_factor(f)

fp=2500;

if(f<=80)
    lf=0.05;
end    
if(f>80 && f<fp)
    lf=1.8/(f^0.87);
end
if(f>=fp)
    lf=0.002;
end