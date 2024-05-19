
% sdof_force_response_psd.m  ver 1.0  by Tom Irvine

function[dpsd,vpsd,apsd,FT_psd,FT_rms,drms,vrms,grms]=sdof_force_response_psd(fi,fn,stiffness,damp,ai,iu)

tpi=2*pi;

omegan=tpi*fn;

omegan2=omegan^2;

n_ref=length(fi);

t=zeros(n_ref,1);
omega=zeros(n_ref,1);
omega2=zeros(n_ref,1);
%
for j=1:n_ref   
    omega(j)=tpi*fi(j);
    omega2(j)=omega(j)^2;
end
%
dpsd=zeros(n_ref,1);
vpsd=zeros(n_ref,1);
apsd=zeros(n_ref,1);
FT_psd=zeros(n_ref,1);

%
%      Transmitted Force
%
for j=1:n_ref
%
    rho=fi(j)/fn;
    num= 1.+(2*damp*rho)^2;
    den= (1-rho^2)^2 + (2*damp*rho)^2;
    t(j)= num/den;
    FT_psd(j)=( t(j)*ai(j) );
%
end
%
%      Absolute Displacement
%
for j=1:n_ref
%        
	num=( (omegan2/stiffness)^2 );
	den=( (omegan2-omega2(j))^2) + ( (2*damp*omega(j)*omegan)^2);
	t(j)= num/den;
    dpsd(j)=( t(j)*ai(j) );
%
end
%
%      Velocity
%
for j=1:n_ref
%     
    num=( (omega(j)*omegan2/stiffness)^2 );
    den=( (omegan2-omega2(j))^2) + ( (2*damp*omega(j)*omegan)^2);
    t(j)= num/den;
    vpsd(j)=( t(j)*ai(j) );
%
end
%
%      Acceleration
%
for j=1:n_ref
%
    num=( (omega2(j)*omegan2/stiffness)^2 );
    den=( (omegan2-omega2(j))^2) + ( (2*damp*omega(j)*omegan)^2);
    t(j)= num/den;
    apsd(j)=( t(j)*ai(j) );
%
end

[~,FT_rms]=cm0(FT_psd,fi,n_ref);
[~,drms]=cm0(dpsd,fi,n_ref);
[~,vrms]=cm0(vpsd,fi,n_ref);
[~,grms]=cm0(apsd,fi,n_ref)

apsd=fix_size(apsd);
vpsd=fix_size(vpsd);
dpsd=fix_size(dpsd);
FT_psd=fix_size(FT_psd);

if(iu==1)
    grms=grms/386;
    apsd=apsd/386^2;
else
    drms=drms*1000;
    dpsd=dpsd*1000^2;
end
         
