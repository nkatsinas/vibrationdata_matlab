
f=16;
omega=2*pi*f;  % 1/sec
rho_c=415;     % kg / (s m^2)

% t=0.64/1000;   % m

t=3.175/1000;


rho=   8025.8;      % kg/m^3

m = rho*t;


m/rho_c

a=m^2*omega^2;
b=12.7*rho_c^2;

TL=10*log10(a/b)

ratio=((omega*m)/(2*rho_c))^2