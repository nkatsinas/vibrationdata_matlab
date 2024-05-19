%
%  srs_coefficients_avd.m  ver 1.6   by Tom Irvine
%
function[a1,a2,ra_b1,ra_b2,ra_b3,rv_b1,rv_b2,rv_b3,rd_b1,rd_b2,rd_b3]=...
                                      srs_coefficients_avd(f,damp,dt)    
%
%  ramp invariant applied force
%
tpi=2*pi;
%
num_fn=max(size(f));
%
a1=zeros(num_fn,1);
a2=zeros(num_fn,1);
%
ra_b1=zeros(num_fn,1);
ra_b2=zeros(num_fn,1);   
ra_b3=zeros(num_fn,1);   
%
rd_b1=zeros(num_fn,1);
rd_b2=zeros(num_fn,1);   
rd_b3=zeros(num_fn,1); 
%
rv_b1=zeros(num_fn,1);
rv_b2=zeros(num_fn,1);   
rv_b3=zeros(num_fn,1);
%
num_damp=length(damp);
%
for j=1:num_fn
%
        omega=(tpi*f(j));
%
        if(num_damp==1)
            ddd=damp;
        else
            ddd=damp(j);
        end
%
        omegad=(omega*sqrt(1.-ddd^2));
        omegadt=omegad*dt;
%            
        cosd=(cos(omegadt));
        sind=(sin(omegadt));
        domegadt=(ddd*omega*dt);
        eee=exp(-domegadt);
        eee2=exp(-2*domegadt);
%
        omn2T=omega^2*dt;
        doo=ddd*omega/omegad; 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        rd_b1(j)=0.;
        rd_b2(j)=-(dt/omegad)*eee*sind;
        rd_b3(j)=0;
    
% 
        rv_b1(j)=(  eee*(-cosd-doo*sind) + 1 )/omn2T;
        rv_b2(j)=(  eee2 + 2*eee*doo*sind -1 )/omn2T;
        rv_b3(j)=(  eee*(cosd-doo*sind)-eee2 )/omn2T;
%
        ra_b1(j)=  eee*sind/omegadt;
        ra_b2(j)= -2*ra_b1(j);
        ra_b3(j)= ra_b1(j);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
        E=(exp(-ddd*omega*dt));
        K=(omegad*dt);
        C=(E*cos(K));
%
        a1(j)=(2*C);
        a2(j)=(-(E^2));
%
end