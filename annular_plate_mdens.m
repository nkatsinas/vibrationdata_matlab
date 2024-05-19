%
%  annular_plate_mdens.m  ver 1.0  by Tom Irvine
%

function[mph]=annular_plate_mdens(outer_diam,inner_diam,thick,md,em,mu,f)

tpi=2*pi;

ro=outer_diam/2;
ri=inner_diam/2;
    
area=pi*( ro^2-ri^2 );
    
m_hat=md*thick;
D=em*thick^3/(12*(1-mu^2));
modal_density=(area/(4*pi))*sqrt(m_hat/D);        
 
modal_density=modal_density*(8/pi^2);
 
mph=tpi*modal_density*ones(length(f),1);   

mph=fix_size(mph);        