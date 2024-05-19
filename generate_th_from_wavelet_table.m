
% generate_th_from_wavelet_table.m  ver 1.0  by Tom Irvine

function[accel]=generate_th_from_wavelet_table(f,amp,NHS,td,nt,dur,t)

tpi=2*pi;
 
last_wavelet=length(f);

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
 
 
accel=zeros(nt,1);

 
%     
for i=1:last_wavelet       
%
        sa=zeros(nt,1);
        sb=zeros(nt,1);
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