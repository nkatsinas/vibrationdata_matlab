%
%  other_plate_mdens.m  ver 1.0  by Tom Irvine
%

function[mph]=other_plate_mdens(area,thick,md,em,mu,f)

tpi=2*pi;

m_hat=md*thick;
D=em*thick^3/(12*(1-mu^2));
modal_density=(area/(4*pi))*sqrt(m_hat/D);        
 
mph=tpi*modal_density*ones(length(f),1);   

mph=fix_size(mph);        