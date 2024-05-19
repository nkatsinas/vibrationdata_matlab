%
disp(' sdof_wavelet.m   ver 1.1  June 23, 2009');
disp(' by Tom Irvine  Email: tomirvine@aol.com ');
disp(' ');
%
disp(' This script calculates the response of a single-degree-of-freedom ');
disp(' system to a wavelet base input ');
disp(' ');
%
A=input(' Enter the wavelet amplitude (G) ');
%
f=input(' Enter wavelet frequency (Hz) ');
%
iflag=0;
while(iflag==0)
    N=input(' Enter number of half-sines, odd integer >=3 ');
%    
    for(i=3:2:100)
        if(N==i)
            iflag=1;
            break;
        end
    end
end
%
alpha=(N+1)*(2*pi*f)/N;
alpha2=alpha^2;
%
beta=(N-1)*(2*pi*f)/N;
beta2=beta^2;;
%
B=A/2;
%
disp(' ');
fn=input(' Enter the SDOF natural frequency (Hz) ');
damp=input(' Enter the SDOF damping ratio ');
%
omegan=2*pi*fn;
domegan=damp*omegan;
omegan2=omegan^2;
omegan3=omegan^3;
omegad=omegan*sqrt(1-damp^2);
%
da=(alpha2-omegan2)^2 + (2*damp*alpha*omegan)^2;
db=(beta2 -omegan2)^2 + (2*damp*beta*omegan)^2;
%
C1=-B*(alpha2-omegan2)/da;
C2= B*(2*damp*alpha2*omegan)/da;
C3=-C1;
C4= B*(-2*damp*omegan3)/da;
%
C5= B*(beta2-omegan2)/db;
C6=-B*(2*damp*beta2*omegan)/db;
C7=-C5;
C8= B*(2*damp*omegan3)/db;
%
C10=C3+C7;
C11=C4+C8;
%
C20=C11-domegan*C10;
%
T=N/(2*f);
tpi=2*pi;
%
maxT=T+(5/fn);
%
fm=[alpha,beta,f,fn];
maxf=max(fm);
dt=1/(maxf*40);
nt=round(maxT/dt);
last=nt;
%
aT=alpha*T;
bT=beta*T;
omdT=omegad*T;
expdt=exp(-domegan*T);
%
rd1=C1*cos(aT)+(C2/alpha)*sin(aT);  
rd2=C5*cos(bT)+ (C6/beta)*sin(bT); 
rd3=expdt*(C10*cos(omdT)+(1/omegad)*C20*sin(omdT));
rdT=rd1+rd2+rd3;
%
rv1=( -alpha*C1*sin(aT) + C2*cos(aT) );
rv2=(  -beta*C5*sin(bT) + C6*cos(bT) );
rv3=-domegan*rd3;
rv4= expdt*(-omegad*C10*sin(omdT) + C20*cos(omdT));
rvT=rv1+rv2+rv3+rv4;
%
clear ax;
clear rd;
clear rv;
clear tx;
clear base;
%
for(i=1:last)
    t=dt*(i-1);
    acc=0;
%    
    if(t<T)
        at=alpha*t;
        bt= beta*t;
        omdt=omegad*t;
        expdt=exp(-domegan*t);
%
        base(i)=-B*cos(at)+ B*cos(bt);
%
        rd1=C1*cos(at)+(C2/alpha)*sin(at);  
        rd2=C5*cos(bt)+ (C6/beta)*sin(bt); 
        rd3=expdt*(C10*cos(omdt)+(1/omegad)*C20*sin(omdt));
        rd(i)=rd1+rd2+rd3;
%
        rv1=( -alpha*C1*sin(at) + C2*cos(at) );
        rv2=(  -beta*C5*sin(bt) + C6*cos(bt) );
        rv3=-domegan*rd3;
        rv4= expdt*(-omegad*C10*sin(omdt) + C20*cos(omdt));
        rv(i)=rv1+rv2+rv3+rv4;
%
    else
        tt=t-T;
        omdtt=omegad*tt;
        expdtt=exp(-domegan*tt);
        base(i)=0;      
%        
        rd(i)=expdtt*( rdT*cos(omdtt)+ ((rvT + domegan*rdT)/omegad)*sin(omdtt) );
%        
        rv(i)=-domegan*rd(i)+omegad*expdtt*( -rdT*sin(omdtt)+ ((rvT + domegan*rdT)/omegad)*cos(omdtt) );
%        
    end
    tx(i)=t;
    ax(i)= -2*domegan*rv(i) - omegan2*rd(i);
end
%
figure(1);
plot(tx,rd*386);
out1=sprintf('Relative Displacement  fn=%g Hz  damp=%g',fn,damp);
title(out1);
xlabel('Time(sec)');
ylabel('Rel Disp (in)');
grid on;
%
figure(2);
plot(tx,rv*386);
out1=sprintf('Relative Velocity  fn=%g Hz  damp=%g',fn,damp);
title(out1);
xlabel('Time(sec)');
ylabel('Rel Vel (in/sec)');
grid on;
%
figure(3);
plot(tx,base,tx,ax);
legend ('Input','Response');    
out1=sprintf('Absolute Acceleration  fn=%g Hz  damp=%g',fn,damp);
title(out1);
xlabel('Time(sec)');
ylabel('Accel(G)');
grid on;
%
disp(' ');
out1=sprintf(' maximum relative displacement = %6.3g in',386*max(rd));
disp(out1);
out1=sprintf(' minimum relative displacement = %6.3g in',386*min(rd));
disp(out1);
%
disp(' ');
out1=sprintf(' maximum acceleration = %6.3g G',max(ax));
disp(out1);
out1=sprintf(' minimum acceleration = %6.3g G',min(ax));
disp(out1);
%
%
disp(' ');
disp(' plot phase portraits?');
k=input(' 1=yes  2=no ');
if(k==1)
    figure(4);
    plot(rd*386,ax);
    grid on;
%   
    ylabel('Acceleration (G)');
    xlabel('Relative Displacement (in)');   
%
    figure(5);
    plot(rv*386,ax);
    grid on;   
%   
    ylabel('Acceleration (G)');
    xlabel('Relative Velocity (in/sec)');
%
    figure(6);
    plot(rd*386,rv*386);
    grid on;    
%   
    ylabel('Relative Velocity (in/sec)');
    xlabel('Relative Displacement (in)');
%
end