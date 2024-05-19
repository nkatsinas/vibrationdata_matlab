
% sine_fds.m  ver 1.0  by Tom Irvine

function[fds_sine_samp]=sine_fds(fn,damp,bex,fs_samp,sine_samp,T_out)

tpi=2*pi;

ff=fs_samp;
smax=sine_samp;

num_fn=length(fn);
num_sine=length(fs_samp);

n=length(damp);


fds_sine_samp=zeros(num_fn,n);

% fprintf('\n  Sine Freq & Accel (G) \n\n');

for ik=1:num_sine   
    
 %   fprintf(' %8.4g  %8.4g  \n',ff(ik),smax(ik));      
     
    freq=ff(ik);
    omega=tpi*freq;
    om2=omega.^2;
    
    cy=ff(ik)*T_out;
    
    for i=1:n
        
        for j=1:num_fn
        
            omegan=tpi*fn(j);   
            omn2=omegan.^2;
            den= (omn2-om2) + (1i)*(2*damp(i)*omegan*omega);    
            num=omn2+(1i)*2*damp(i)*omega*omegan;
%
            accel_complex=num./den;
    
            response_accel=abs(accel_complex)*smax(ik);
            response_damage=cy*response_accel^bex(i);
    
            fds_sine_samp(j,i)=response_damage;  % running sum
            
        end
    end
end
