%
%   re_thick_plate_bc.m  ver 1.0  by Tom Irvine
%
%   radiation efficiency thick plate with bc.
%
%    bc=1  for simply supported
%      =2  for clamped
%
%    a = smallest of length & width
%    b = largest of length & width
%    c = speed of sound
%    fcr = critical frequency
%
%    Using thin plate formula with thick plate critical frequency
%    pending identification of a true thick plate formula for all 
%    frequencies.
%
function[rad_eff]=re_thick_plate_bc(freq,fcr,a,b,c,bc)
%

f=freq;

NL=length(f);
 
fcr_b=1.3*fcr;

lambda_c=c/fcr;

aob=a/b;

P=2*a+2*b;
Ap=a*b;
S=Ap;

Q=P*c/(pi^2*S*fcr);

fb=fcr+(5*c/P);

rad_eff=ones(NL,1);
    
for i=1:NL

        if(f(i)<fb)
            rad_eff(i)=Q*sqrt(f(i)/fcr);
        end
        if(f(i)>=fcr_b)
            rad_eff(i)=1;
        end 
end


    