%
%  fixed_plate_uniform_pressure.m  ver 1.0  by Tom Irvine
%
function[accel_psd,vel_psd,disp_psd,accel_psd_spatial]=...
         fixed_plate_uniform_pressure(a,b,total_mpa,damp,fn,norm,beta,THM,f,nf)

%
%  Calculate mode shapes and mass-normalized
%

%
beta_x=beta/a;
beta_y=beta/b;
%
sigma=( sinh(beta)+sin(beta)  )/( cosh(beta)-cos(beta)  );
%
P=@(x)( cosh(beta_x*x)-cos(beta_x*x) )-sigma*( sinh(beta_x*x)-sin(beta_x*x) );
W=@(y)( cosh(beta_y*y)-cos(beta_y*y) )-sigma*( sinh(beta_y*y)-sin(beta_y*y) );
          
x=a/2;
y=b/2;

HMd=zeros(nf,1);
HMv=zeros(nf,1);
HMa=zeros(nf,1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

omega=2*pi*f;
omegamn=2*pi*fn;
%%

for k=1:nf   
%            
    num=P(x)*W(y);
%            
    den=(omegamn^2-omega(k)^2) + (1i)*2*damp*omega(k)*omegamn;
%
    HMd(k)=num/den;
    HMv(k)=1i*omega(k)*num/den;
    HMa(k)=-omega(k)^2*num/den; 
%
end
%

PF=0.690*norm;
PP=PF/(total_mpa*norm);
%
HMd=abs(PP*HMd);
HMv=abs(PP*HMv);
HMa=abs(PP*HMa);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
nni=2;  % log
fb=THM(:,1);
bb=THM(:,2);
 
fa=f;
aa=HMa;
aa=aa.*aa;
[ppp,~]=power_transmissibility_mult_function(fa,aa,fb,bb,nni);
accel_psd=[ppp(:,1) ppp(:,2)/386^2];

aa=HMv;
aa=aa.*aa;
[ppp,~]=power_transmissibility_mult_function(fa,aa,fb,bb,nni);
vel_psd=ppp;

aa=HMd;
aa=aa.*aa;
[ppp,~]=power_transmissibility_mult_function(fa,aa,fb,bb,nni);
disp_psd=ppp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

aps=zeros(nf,1);

clear x;
clear y;

x=a*(1:9)/10;
y=b*(1:9)/10;

ntotal=length(x)*length(y);

for i=1:length(x)
    for j=1:length(y)
 
        HMa=zeros(nf,1);

        for k=1:nf
%
            num=P(x(i))*W(y(j));
%            
            den=(omegamn^2-omega(k)^2) + (1i)*2*damp*omega(k)*omegamn;
%
            HMa(k)=-omega(k)^2*num/den;             
%
        end
%
        HMa=abs(PP*HMa); 
               
        fa=f;
        aa=HMa;
        
        aa=aa.*aa;
        [ppp,~]=power_transmissibility_mult_function(fa,aa,fb,bb,nni);
        nnn=length(ppp(:,2));
        aps(1:nnn,1)=aps(1:nnn,1)+ppp(:,2)/386^2;
    end
end

accel_psd_spatial(1:nnn,:)=[ppp(:,1) aps(1:nnn,1)/ntotal];
if(aps(end,1)==0)
    accel_psd_spatial(end,:)=[];
end