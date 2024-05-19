
tpi=2*pi;

m=1;
k=80;
sd=0.1;

omegan=sqrt(k/m);
k0=k;
k1=2*sd*k;
c=k1/omegan;



d=c/m;
k2=k1;
k1=k0;
omega1_2=(k1/m);
omega2_2=(k2/m);

f=(omega1_2+omega2_2);
g=(omega1_2*omega2_2)/d;


% p = [1 omega2_2/d   f  g];
% r = roots(p)

% u=r(1);
% v=r(2);
% w=r(3);

[R]=cubic_roots(p(1),p(2),p(3),p(4));

u=R(1);
v=R(2);
w=R(3);

%  ilt((f*s+g)/((s-u)*(s-v)*(s-w)),s,t);


A1=(f*w+g)/(w^2+(-v-u)*w+u*v);
A2=-(f*v+g)/((v-u)*w-v^2+u*v);
A3=((f*u+g))/((v-u)*w-u*v+u^2);

% A3=conj(A2);
% A1=2*real(A2);

A1
A2
A3

omega_1=sqrt(omega1_2);

fn=(omega_1/tpi);

sr=fn*20;

T=1/fn;

dur=10*T;

dt=1/sr;

nt=round(dur/dt);

x=zeros(nt,1);
tt=zeros(nt,1);

for i=1:nt
    
    t=(i-1)*dt;
    tt(i)=t;

    x(i)=A1*exp(t*w)+A2*exp(t*v)+A3*exp(t*u);

end


figure(9);
plot(tt,x);
xlabel('Time(sec)');
grid on;












