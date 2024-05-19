%
%   panel_modal_density_bc.m  ver 1.1  by Tom Irvine
%
%   bc = 1 SS
%      = 2 Free
%      = 3 Clamped
%      = 4 Generic
%
function[mph,mpr,D]=panel_modal_density_bc(em,mu,md,thick,L,W,f,bc)
%
tpi=2*pi;

H=thick;

area=L*W;
    
[~,modal_density_rad,D,m_hat]=panel_generic_modal_density(em,mu,md,H,area);

md1r=modal_density_rad;

cc=((m_hat/D)^(1/4)*(L+W)/ pi );
omega=tpi*f;
        
md2r=cc/sqrt(omega);

if(bc==1)  % SS  1
    mpr=md1r-(1/4)*md2r;
end
if(bc==2)  % Free   2
    mpr=md1r+(1/2)*md2r;
end
if(bc==3)  % Clamped   3
    mpr=md1r-(1/2)*md2r;
end 
if(bc==4)  % Generic   4
    mpr=md1r;
end 

mph=tpi*mpr;
