%
clear X;
clear Y;
clear b;
clear na;
clear t;
clear length;
%
dur=90;
sr=20000;
dt=1/sr;
nt=floor(dur/dt);
%
mu=0;
sigma=1;
[X]=simple_white_noise(mu,sigma,nt);
%
t=zeros(nt,1);
Y=zeros(nt,1);
%
for i=1:nt
    t(i)=(i-1)*dt;
end            
%
b_length=26;
na_length=26;
%
tL=b_length*na_length;
%
bss=zeros(tL,4);
%
 b=zeros(b_length,1);
na=zeros(b_length,1);
%

beta=input(' Enter beta ');
n=input(' ');
            
        for i=1:nt
            Y(i)=X(i)+beta*sign(X(i))*(abs(X(i))^n);
        end
%        
        Y=sigma*Y/std(Y);
%
        [amean,amax,amin,aabs,astd,arms,askew,akurt]=dstats(Y);

%
astd
akurt

figure(10)
plot(t,Y);
grid on;

fig_num=11;

[fig_num]=plot_histogram(Y,'Amplitude',fig_num);



