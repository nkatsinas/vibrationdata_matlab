disp(' ');
disp(' srs_from_fft.m   ver 1.2  November 8, 2012 ');
disp(' ');
disp(' by Tom Irvine   Email: tom@vibrationdata.com ');
disp(' ');
disp(' This program caculates the shock response spectrum ');
disp(' using the FFT method.  It is intended mainly for ');
disp(' demonstration purposes. ');
disp(' ');
%
close all;
%
clear length;
clear t;
clear y;
clear Y;
clear srs_max;
clear srs_min;
clear fn;
clear H_acc;
clear base_FFT;
clear base_complex_FFT;
%
fig_num=1;
%
tpi=2.*pi;
%
iunit=input(' Enter acceleration unit:   1= G   2= m/sec^2  ');	
%
disp(' ');
disp(' The time history must have two columns: time(sec) & acceleration')
%
[t,y,dt,sr,tmx,tmi,n,ncontinue]=enter_time_history();
%
figure(fig_num);
fig_num=fig_num+1;
plot(t,y);
grid on;
xlabel('Time(sec)');
%
N=2^floor(log(n)/log(2));
%
if(n ~= N)  % zero pad
    N=2*N;
    temp=zeros(N,1);
    temp(1:n)=y(1:n);
    clear y;
    y=temp;
end
%
df=1/(N*dt);
%
m_choice=1; % mean removal yes
h_choice=1; % rectangular window
%
[freq,full,phase,base_complex_FFT]=...
                                 full_FFT_core(m_choice,h_choice,y,N,dt);
%
base_FFT=base_complex_FFT(:,2)+(1i)*base_complex_FFT(:,3);
%
num_freq=N/2;  % for the one-sided transfer function calculation
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
fn(1)=input(' Enter the starting frequency (Hz)  ');
if fn(1)>sr/30.
    fn(1)=sr/30.;
end
%
j=1;
while(1)
    if (fn(j) > sr/8.)
        break
    end
    fn(j+1)=fn(1)*(2. ^ (j*(1./12.))); 
    j=j+1;
end
%
idamp=input(' Enter damping format:  1= damping ratio   2= Q  ');	
%
disp(' ')
if(idamp==1)
    damp=input(' Enter damping ratio (typically 0.05) ');
else
    Q=input(' Enter the amplification factor (typically Q=10) ');
    damp=1./(2.*Q);
end
%
num=length(fn);
%
srs_max=zeros(num,1);
srs_min=zeros(num,1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
for ijk=1:num
%
%   calculate the complex transfer function H_acc
%
    [f,H_acc,~]=sdof_base_accel_transfer(iunit,df,num_freq,fn(ijk),damp);
%
%   make H_acc two-sided
%
    nf=length(f);
%
    frf=zeros(2*nf,1);
    frf(1:nf)=H_acc(1:nf);
%
    aa=H_acc;
    bb= flipud(aa);
%
    for i=1:nf
        frf(i+nf)=real(bb(i))-(1i)*imag(bb(i));
    end
%
    nf=2*nf;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   multiply the base input FFT by the two-sided transfer function
%
    response_FFT=base_FFT.*frf;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   take the inverse FFT
%
    Y = nf*real(ifft(response_FFT,nf,'symmetric'));
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    srs_max(ijk)=max(Y);
    srs_min(ijk)=abs(min(Y));
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
%
figure(fig_num);
fig_num=fig_num+1;
%
plot(fn,srs_max,fn,abs(srs_min),'-.');
legend ('positive','negative'); 
%
if iunit==1
        ylabel('Peak Accel (G)');
else
        ylabel('Peak Accel (m/sec^2)');
end
xlabel('Natural Frequency (Hz)');
Q=1./(2.*damp);
out5 = sprintf(' Acceleration Shock Response Spectrum Q=%g ',Q);
title(out5);
grid;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
%
ymax= 10^(ceil(log10(max(srs_max))));
ymin= 10^(floor(log10(min(srs_min))));
%
fmax=max(fn);
fmin=min(fn);
%
fmax= 10^(ceil(log10(fmax)));
fmin= 10^(floor(log10(fmin)));
%
axis([fmin,fmax,ymin,ymax]); 
%