
%  ws_th_from_wavelet_table.m  ver 1.1  by Tom Irvine

function[acceleration,velocity,displacement]=ws_th_from_wavelet_table(iwin,store_amp,store_NHS,store_td,dur,dt,nt,iunit,f)
%
    tpi=2*pi;
%
	amp=store_amp(iwin,:);
    NHS=store_NHS(iwin,:);
     td=store_td(iwin,:);
%    
	last_wavelet=length(f);
%
%%	out1=sprintf(' last_wavelet= %d \n',last_wavelet);
%%    disp(out1);  
%
%%	out1=sprintf(' nt= %d \n',nt);
%%    disp(out1);
%%	out1=sprintf(' dt= %9.5g sec \n',dt);
%%    disp(out1);  
%
isu=1;
if(iunit==1)
	isu=386.;
end
if(iunit==2)
    isu=9.81;
end
disp(' ');
%
beta=tpi*f;
alpha=zeros(last_wavelet,1);
upper=zeros(last_wavelet,1);

for i=1:last_wavelet 
    alpha(i)=beta(i)/double(NHS(i));
    upper(i)=td(i)+(NHS(i)/(2.*f(i))); 
end

%
%% disp(' ref 1 ');
%
wavelet_low=zeros(last_wavelet,1);
wavelet_up=zeros(last_wavelet,1);

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
%
%% disp(' ref 2 ');
%
t=linspace(0,nt*dt,nt);  
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    accel=zeros(nt,1);
    velox=zeros(nt,1);
    dis=zeros(nt,1);   
%     
 	for i=1:last_wavelet
%%        progressbar(i/last_wavelet) % Update figure       
%
        sa=zeros(nt,1);
        sb=zeros(nt,1);
%        sc=zeros(nt,1);
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
%    APB=zeros(last_wavelet,1);
%    AMB=zeros(last_wavelet,1);

% 	for i=1:last_wavelet    
%        APB(i)=alpha(i)+beta(i);
%        AMB(i)=alpha(i)-beta(i);
%    end

    APB = alpha(1:last_wavelet) + beta(1:last_wavelet);
    AMB = alpha(1:last_wavelet) - beta(1:last_wavelet);

%    
 	for i=1:last_wavelet
%
        sa=zeros(nt,1);
        sb=zeros(nt,1);
%        sc=zeros(nt,1);  
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
%
 	for i=1:last_wavelet
%
        sa=zeros(nt,1);
        sb=zeros(nt,1);
%        sc=zeros(nt,1);  
%
        ia=wavelet_low(i);
        ib=wavelet_up(i);
%
        sa(ia:ib)=(-1+cos(APB(i)*( t(ia:ib)-td(i) ) ))/((APB(i))^2);
        sb(ia:ib)=(-1+cos(AMB(i)*( t(ia:ib)-td(i) ) ))/((AMB(i))^2);
        sc=amp(i)*(sa-sb)*0.5;
%          
		dis(ia:ib)=dis(ia:ib)+sc(ia:ib);
%				
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

t=t';
acceleration=[t,accel];
%
velox=velox*isu;
dis=dis*isu;   
%
velocity=[t,velox];
%
displacement=[t,dis];