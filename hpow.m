
function[rms]=hpow(ss)

F=evalin('base',ss);

[M,Ia]=max(F(:,2));

% Mh=M*0.25;

% [N,J1]=min(abs(F(1:Ia,2)-Mh));

% [N,J2]=min(abs(F(Ia:end,2)-Mh));

fc=F(Ia,1);

q=2^(1/6);

flow=fc/q;
fup=fc*q;

[N,J1]=min(abs(F(:,1)-flow));
[N,J2]=min(abs(F(:,1)-fup));

% Ia;

% J2=J2+Ia-1;

% F(J1,1);
% F(J2,1);

f=F(:,1);
a=F(:,2);

[s,rms] = calculate_PSD_slopes_no(f(J1:J2),a(J1:J2));

% log2(fup/flow)


