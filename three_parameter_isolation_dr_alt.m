
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

% -->  partfrac((A*s+B)/((s-k)*(s^2-2*a*s+b^2+a^2)),s);
% (%o18) (A*k+B)/((k^2-2*a*k+b^2+a^2)*(s-k))-((A*k+B)*s+B*k-A*b^2-A*a^2-2*B*a)/((k^2-2*a*k+b^2+a^2)*(s^2-2*a*s+b^2+a^2))




omega_1=sqrt(omega1_2);

fn=(omega_1/tpi);

sr=fn*20;

T=1/fn;

dur=10*T;

dt=1/sr;

nt=round(dur/dt);

x=zeros(nt,1);
tt=zeros(nt,1);

A=f;
B=g;

a=real(v);
b=abs(imag(v));

C1=(A*u+B)/(u^2-2*a*u+b^2+a^2);
C2=C1;
Q=B*u-A*b^2-A*a^2-2*B*a;
P=(A*u+B);
lambda=Q/P;

C1
C3=(lambda+a)/b

for i=1:nt
    
    t=(i-1)*dt;
    tt(i)=t;
    
    arg=b*t;

    x(i)=C1*( exp(t*u)- exp(a*t)*(cos(arg)+C3*sin(arg)) );

end


figure(9);
plot(tt,x);
xlabel('Time(sec)');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn=b/tpi;

sr=fn*50;

dur=10*T;

dt=1/sr;

nt=round(dur/dt);



D=C1;
E=C3;

T=dt;

bT=b*T;
aT=a*T;

Q1=D*T*(1-cos(bT));
Q2=D*T*(-E*exp(aT)*sin(bT));
Q3=D*T*(1-cos(bT)+E*sin(bT))*exp(2*aT);

P1=(2*cos(bT)+1)*exp(aT);
P2=-(1+2*cos(bT))*exp(2*aT);
P3=exp(3*aT);

out1=sprintf('Q1=%8.4g  Q2=%8.4g  Q3=%8.4g',Q1,Q2,Q3);
out2=sprintf('P1=%8.4g  P2=%8.4g  P3=%8.4g',P1,P2,P3);
disp(out1);
disp(out2);

nt=4*nt;

accel=zeros(nt,1);
ttt=zeros(nt,1);

aaa=zeros(nt,1);

for i=1:nt
    t=(i-1)*dt;
    ttt(i)=t;
    aaa(i)=b*t;
end

yin=10*sin(aaa);
  

for i=1:nt
    
        forward=[ Q1,  Q2,  Q3, 0  ];    
        back   =[ 1, -P1, -P2, -P3 ];    
%    
        accel=filter(forward,back,yin); 
end


figure(10);
plot(ttt,yin,ttt,accel);
xlabel('Time(sec)');
grid on;


max(accel)/max(yin)

%%% for i=1:nt    
%        
%%%    accel(i)=Q1*yin(i);
%%%   
%%%    if(i>=2)
%%%        accel(i)=accel(i)+Q2*yin(i-1);
%%%    end    
%%%    if(i>=3)
%%%        accel(i)=accel(i)+Q3*yin(i-2);
%%%    end    
%%%    
%%%    if(i>=2)
%%%        accel(i)=accel(i)+P1*accel(i-1);
%%%    end    
%%%    if(i>=3)
%%%        accel(i)=accel(i)+P2*accel(i-2);
%%%    end    
%%%    if(i>=4)
%%%        accel(i)=accel(i)+P3*accel(i-3);
%%%    end          
%%%
%%% end  

