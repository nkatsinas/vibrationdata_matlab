%
%  generate_time_history_wavelet_table.m  ver 1.1  by Tom Irvine
%
function[accel]=generate_time_history_wavelet_table(f,amp,NHS,td,t)


dur=max(t);
nt=length(t);

last_wavelet=length(f);

tpi=2*pi;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
 
alpha=zeros(last_wavelet,1);
upper=zeros(last_wavelet,1);
 
beta=tpi*f;
 
for i=1:last_wavelet
    alpha(i)=beta(i)/double(NHS(i));
    upper(i)=td(i)+(NHS(i)/(2*f(i))); 
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
wavelet_low=zeros(last_wavelet,1);
wavelet_up =zeros(last_wavelet,1);
%
for i=1:last_wavelet
%    
    wavelet_low(i)=round( 0.5 +   (td(i)/dur)*nt);
     wavelet_up(i)=round(-0.5 +(upper(i)/dur)*nt);   
%    
    if(wavelet_low(i)<=0)
        wavelet_low(i)=1;       
    end
    if(wavelet_up(i)>nt)
        wavelet_up(i)=nt;       
    end   
% 
end
 
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