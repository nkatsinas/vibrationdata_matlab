%
%  shear_frequencies.m  ver 1.2  by Tom Irvine
%
%  Reference: 
%
%  G. Kurtz, B. Watters, New Wall Design for High Transmission Loss or
%  High Damping, Journal of Acoustic Society America, volume 31, 739-48, 
%  1959

function [f1,f2]=shear_frequencies(E,G,mu,tf,hc,rhof,rhoc)

tpi=2*pi;

if(tf>0.25*hc)
    disp('Warning: ratio of skin/core thickness is high');
end


out1=sprintf('\n tf=%8.4g  hc=%8.4g \n rhof=%8.4g  rhoc=%8.4g \n',tf,hc,rhof,rhoc);
disp(out1);

[B,~,~,mpa]=honeycomb_sandwich_properties(E,G,mu,tf,hc,rhof,rhoc);

[Bskin]=flexural_rigidity(E,tf,mu);


out1=sprintf('\n B=%8.4g  Bskin=%8.4g  mpa=%8.4g \n',B,Bskin,mpa);
disp(out1);

% cs=sqrt(G*hc/mpa);


out1=sprintf('\n G*hc=%8.4g \n',G*hc);
disp(out1);

%% omega1=cs^2/sqrt(B/mpa);

omega1=G*hc/sqrt(B*mpa);
omega2=G*hc/sqrt(2*Bskin*mpa);

f1=omega1/tpi;
f2=omega2/tpi;

%%%
%%%  s3=G*hc;
%%%  B=E*tf*(hc+tf)^2/( 2*(1-mu^2))
%%%
%%%  omega1=G*hc/sqrt(B*mpa);
%%%
%%%

