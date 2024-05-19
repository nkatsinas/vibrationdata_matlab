%
%   srs_function_abs.m  ver 1.3  August 21, 2015
%
%   by Tom Irvine
%
%
%   Acceleration SRS using Smallwood ramp invariant digital recursive 
%   filtering relationship
%
%    yy = input acceleration array - single column - accel (G)
%    dt = constant time step
%  damp = viscous damping ratio  (damp=0.05 for Q=10)
%     f = array of natural frequencies Hz (pick your own)
%
%  The highest natural frequency should be less than the Nyquist frequency.
%  
%  Ideally, the highest natural frequency should less that one-tenth of
%  the sample rate.
%
%
%  num_fn = number of natural frequencies
%   x_pos = peak positive response acceleration
%   x_neg = peak negative response acceleration
%
%   srs = [ natural frequency(Hz), peak pos(G), absolute value of peak neg(G)]
%
function[srs,srsa]=srs_function_abs(yy,dt,damp,f)
%
tpi=2*pi;
%
num_fn=max(size(f));
%
%  The first loop calculates the Smallwood coefficients
%
a1=zeros(num_fn,1);
a2=zeros(num_fn,1);
b1=zeros(num_fn,1);
b2=zeros(num_fn,1);   
b3=zeros(num_fn,1);   
%
for j=1:num_fn   
%
        omega=(tpi*f(j));
%
        omegad=(omega*sqrt(1.-damp^2));
%
        E=(exp(-damp*omega*dt));
        K=(omegad*dt);
        C=(E*cos(K));
        S=(E*sin(K));
%
        Sp=S/K;
%
        a1(j)=(2*C);
        a2(j)=(-(E^2));
%
        b1(j)=(1.-Sp);
        b2(j)=(2.*(Sp-C));
        b3(j)=((E^2)-Sp);

%
end
%
%  The second loop calculates the SRS 
%
x_pos=zeros(num_fn,1);
x_neg=zeros(num_fn,1);
x_abs=zeros(num_fn,1);
%
for j=1:num_fn
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];    
%    
        resp=filter(forward,back,yy);
%
        x_pos(j)= max(resp);
        x_neg(j)= min(resp);
        x_abs(j)= max([ x_pos(j) abs(x_neg(j))]);
end
%
f=fix_size(f);
%
 srs=[f x_pos abs(x_neg)];
srsa=[f x_abs];