function[a]=generate_sine(amp,freq,T,SR)
%
dt=1/SR;
N=floor(T/dt);
a=zeros(N,2);
%
for i=1:N
    time=(i-1)*dt;
    a(i,1)=time;
    a(i,2)=amp*sin(2*pi*freq*time);
end
