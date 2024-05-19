
% wavelet_reconstruction_function.m  ver 1.0  by Tom Irvine

function[t,dispx,velox,accel]=...
         wavelet_reconstruction_function(sr,f,amp,NHS,td,dur,vscale,dscale,delay)

tpi=2*pi;

last_wavelet=length(f);

dt=1/sr;

beta=tpi*f;

alpha=zeros(last_wavelet,1);
upper=zeros(last_wavelet,1);

wavelet_low=zeros(last_wavelet,1);
wavelet_up=zeros(last_wavelet,1);

tmax=0;

for i=1:last_wavelet
    alpha(i)=beta(i)/double(NHS(i));
    te=(NHS(i)/(2.*f(i)));
    upper(i)=td(i)+te;
    if(te>tmax)
        tmax=te;
    end
end

if(tmax>dur)
    dur=1.05*tmax;
    out1=sprintf('Duration reset to %8.4g sec',dur);    
    msgbox(out1);     
end

nt=ceil(dur/dt);



for i=1:last_wavelet
%    
    wavelet_low(i)=round( 0.5 +   (td(i)/dur)*nt);
     wavelet_up(i)=round(-0.5 +(upper(i)/dur)*nt);   
%    
    if(wavelet_low(i)==0)
        wavelet_low(i)=1;       
    end
    if(wavelet_up(i)>nt)
        wavelet_up(i)=nt;       
    end   
% 
end

%%%

t=linspace(0,nt*dt,nt);  

accel=zeros(nt,1);
velox=zeros(nt,1);
dispx=zeros(nt,1);  

APB=zeros(nt,1);
AMB=zeros(nt,1);

%     
for i=1:last_wavelet       
%
        sa=zeros(nt,1);
        sb=zeros(nt,1);
        sc=zeros(nt,1);
%
        ia=wavelet_low(i);
        ib=wavelet_up(i);
%       
        sa(ia:ib)=sin( alpha(i)*( t(ia:ib)-td(i) ) );
        sb(ia:ib)=sin(  beta(i)*( t(ia:ib)-td(i) ) );
        sc=amp(i)*sa.*sb;
%
		accel(ia:ib)=accel(ia:ib)+sc(ia:ib);
%
end
%
%    
for i=1:last_wavelet    
        APB(i)=alpha(i)+beta(i);
        AMB(i)=alpha(i)-beta(i);
end
%
for i=1:last_wavelet
%
        sa=zeros(nt,1);
        sb=zeros(nt,1);
        sc=zeros(nt,1);  
%
        ia=wavelet_low(i);
        ib=wavelet_up(i);
%
        sa(ia:ib)=sin( APB(i)*( t(ia:ib)-td(i) ) )/APB(i);
        sb(ia:ib)=sin( AMB(i)*( t(ia:ib)-td(i) ) )/AMB(i);
        sc=amp(i)*(-sa+sb)*0.5;
%          
		velox(ia:ib)=velox(ia:ib)+sc(ia:ib);
%				
end

velox=velox*vscale;

%
for i=1:last_wavelet
%
        sa=zeros(nt,1);
        sb=zeros(nt,1);
        sc=zeros(nt,1);  
%
        ia=wavelet_low(i);
        ib=wavelet_up(i);
%
        sa(ia:ib)=(-1+cos(APB(i)*( t(ia:ib)-td(i) ) ))/((APB(i))^2);
        sb(ia:ib)=(-1+cos(AMB(i)*( t(ia:ib)-td(i) ) ))/((AMB(i))^2);
        sc=amp(i)*(sa-sb)*0.5;
%          
		dispx(ia:ib)=dispx(ia:ib)+sc(ia:ib);
%				
end

dispx=dispx*dscale;

t=fix_size(t);
t=t+delay;
