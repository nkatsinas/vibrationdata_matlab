%
%  ss_ss_ss_ss_plate_uniform_pressure.m  ver 1.0  by Tom Irvine
%
function[accel_psd,vel_psd,disp_psd,accel_psd_spatial]=...
         ss_ss_ss_ss_plate_uniform_pressure(a,b,total_mpa,damp,omegamn,THM,f,nf)

x=a/2;
y=b/2;


nmodes=6;
%

omega=2*pi*f;
%%
%
HMd=zeros(nf,1);
HMv=zeros(nf,1);
HMa=zeros(nf,1);

for k=1:nf
%    
    for m=1:nmodes
        for n=1:nmodes
%
            SS=sin(m*pi*x/a)*sin(n*pi*y/b);            
            G=(cos(m*pi)-1)*(cos(n*pi)-1);
%            
            num=G*SS;
%            
            den=(omegamn(m,n)^2-omega(k)^2) + 1i*2*damp*omega(k)*omegamn(m,n);
            den=den*(m*n);
%
            HMd(k)=HMd(k)+num/den;
            HMv(k)=HMv(k)+1i*omega(k)*num/den;     
            HMa(k)=HMa(k)-omega(k)^2*num/den;             
%
        end
    end
end
%
P=4/(total_mpa*pi^2);
%
HMd=abs(P*HMd);
HMv=abs(P*HMv);
HMa=abs(P*HMa);
%
nni=2;  % log
fb=THM(:,1);
 b=THM(:,2);
 

fa=f;
a=HMa;
a=a.*a;
[ppp,~]=power_transmissibility_mult_function(fa,a,fb,b,nni);
accel_psd=[ppp(:,1) ppp(:,2)/386^2];

a=HMv;
a=a.*a;
[ppp,~]=power_transmissibility_mult_function(fa,a,fb,b,nni);
vel_psd=ppp;

a=HMd;
a=a.*a;
[ppp,~]=power_transmissibility_mult_function(fa,a,fb,b,nni);
disp_psd=ppp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aps=zeros(nf,1);

clear x;
clear y;


x=(1:9)/10;
y=(1:9)/10;


ntotal=length(x)*length(y);

for i=1:length(x)
    for j=1:length(y)
 
        HMa=zeros(nf,1);

        for k=1:nf
%    
            for m=1:nmodes
                for n=1:nmodes
%
                    SS=sin(m*pi*x(i))*sin(n*pi*y(j));
%            
                    G=(cos(m*pi)-1)*(cos(n*pi)-1);
%            
                    num=G*SS;
%            
                    den=(omegamn(m,n)^2-omega(k)^2) + 1i*2*damp*omega(k)*omegamn(m,n);
                    den=den*(m*n);
    
                    HMa(k)=HMa(k)-omega(k)^2*num/den;             
%
                end
            end
        end
        P=4/(total_mpa*pi^2);
        fa=f;
        a=abs(P*HMa);
        a=a.*a;
        [ppp,~]=power_transmissibility_mult_function(fa,a,fb,b,nni);
        nnn=length(ppp(:,2));
        aps(1:nnn,1)=aps(1:nnn,1)+ppp(:,2)/386^2;
    end
end

accel_psd_spatial(1:nnn,:)=[ppp(:,1) aps(1:nnn,1)/ntotal];
if(aps(end,1)==0)
    accel_psd_spatial(end,:)=[];
end


