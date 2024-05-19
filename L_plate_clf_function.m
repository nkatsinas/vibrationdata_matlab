%
%   L_plate_clf_function.m  ver 1.0  by Tom Irvine
%

function[clf_12,clf_21]=L_plate_clf_function(f,em_1,em_2,mu_1,mu_2,...
                                 md_1,md_2,thick_1,thick_2,L,area_1,area_2)

%
tpi=2*pi;

[tau_12,tau_21]=tau_21_function(em_1,em_2,mu_1,mu_2,md_1,md_2,...
                                                          thick_1,thick_2);

fl=length(f);
 
V=2*L/pi;

clf_12=zeros(fl,1);
clf_21=zeros(fl,1);    
    
for i=1:fl
    
    omega=tpi*f(i);  
        
    [Cb1]=plate_bending_phase_speed(em_1,md_1,mu_1,thick_1,omega);
    [Cb2]=plate_bending_phase_speed(em_2,md_2,mu_2,thick_2,omega);        
        
    clf_12(i)=V*Cb1*tau_12/(omega*area_1);
    clf_21(i)=V*Cb2*tau_21/(omega*area_2);
    
end
