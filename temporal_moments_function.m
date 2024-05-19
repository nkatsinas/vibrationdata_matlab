
% temporal_moments_function  ver 1.0  by Tom Irvine

%   E = Energy
%  Ae = Root energy amplitude 
%   T = Central time 
%   D = RMS duration
%  St = Central skewness
%   S = Normalized skewness
%  Kt = Central kurtosis
%   K = Normalized kurtosis

function[E,Ae,T,D,St,S,Kt,K]=temporal_moments_function(tim,amp,dt,ref)

a2 = amp.^2; % Square each element of amp array

ta = tim - ref; % Calculate ta array

% Calculate the moments
m0 = sum(a2); 
m1 = sum(ta .* a2);
m2 = sum((ta.^2) .* a2);
m3 = sum((ta.^3) .* a2);
m4 = sum((ta.^4) .* a2);

% Multiply each moment by dt
m0 = m0 * dt;
m1 = m1 * dt;
m2 = m2 * dt;
m3 = m3 * dt;
m4 = m4 * dt;

E = m0; % Assign E as m0

D=sqrt( (m2/m0) - (m1/m0)^2 );
%
Ae=sqrt(E/D);
T=m1/m0;
ss=(m3/m0)-3*(m1*m2/m0^2)+2*(m1/m0)^3;
St=(ss)^(1/3);
S=St/D;

kk=(m4/m0)-4*(m1*m3/m0^2)+6*(m1^2*m2/m0^3)-3*(m1/m0)^4;
Kt=(kk)^(1/4);

K=Kt/D;