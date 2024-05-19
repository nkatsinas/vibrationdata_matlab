load('d2y.mat'); %d2y is [Time Accelration] vector
m = 1.5; %mass of brain in kg; Skull= 3.5 kg see Analytical modelling of soccer heading
k = 156e3; %stiffness of the brain
c = 340; %damping coefficien of the brain

p = 300; %peak accel m/s2
f = 100; %frequency Hz
tend = 1/f; %full period
t=0:0.0001:tend;
d2y = @(t) p*(sin(pi*f*t).^2); %haversine formula

%solve d2z + (c/m)*dz + (k/m)*z = -d2y from: http://www.vibrationdata.com/tutorials_alt/base_sine.pdf

num=length(t);
yy=zeros(num,1);

for i=1:num
    yy(i)=p*(sin(pi*f*t(i)).^2);
end


omegan=sqrt(k/m);
fn=omegan/(2*pi);
damp=c/(2*m*omegan);
dt=mean(diff(t));

fprintf('\n Natural Frequency = %8.4g Hz \n',fn);
fprintf('\n Damping ratio = %8.4g \n',damp);

%
%  Initialize coefficients
%
    [a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                               srs_coefficients(fn,damp,dt);
%
%  SRS engine
%
% Calculate absolute acceleration response:  a_resp
%
    [a_resp,~,~]=arbit_engine(a1,a2,b1,b2,b3,yy);
%
% Calculate relative displacement response:  rd_resp
%            
    [rd_resp,~,~]=arbit_engine(rd_a1,rd_a2,rd_b1,rd_b2,rd_b3,yy);
   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  arbit_engine_.m  ver 1.0  by Tom Irvine

function[a_resp,a_pos,a_neg]=arbit_engine(a1,a2,b1,b2,b3,yy)

    forward=[ b1,  b2,  b3 ];    
    back   =[  1, -a1, -a2 ];    
%    
    a_resp=filter(forward,back,yy);
    a_pos= abs(max(a_resp));
    a_neg= abs(min(a_resp));
    
    a_resp=fix_size(a_resp);

end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  srs_coefficients.m  ver 1.6  by Tom Irvine
%
function[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                      srs_coefficients(f,damp,dt)    
    %
    %  Smallwood ramp invariant digital recursive filitering relationship
    %
    tpi=2*pi;
    %
    num_fn=max(size(f));
    %
    a1=zeros(num_fn,1);
    a2=zeros(num_fn,1);
    b1=zeros(num_fn,1);
    b2=zeros(num_fn,1);   
    b3=zeros(num_fn,1);   
    %
    rd_a1=zeros(num_fn,1);
    rd_a2=zeros(num_fn,1);
    rd_b1=zeros(num_fn,1);
    rd_b2=zeros(num_fn,1);   
    rd_b3=zeros(num_fn,1); 
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
    %            
            cosd=(cos(omegad*dt));
            sind=(sin(omegad*dt));
            domegadt=(ddd*omega*dt);
    %
            rd_a1(j)=2.*exp(-domegadt)*cosd; 
            rd_a2(j)=-exp(-2.*domegadt);
            rd_b1(j)=0.;
            rd_b2(j)=-(dt/omegad)*exp(-domegadt)*sind;
            rd_b3(j)=0;
    %
    
                E=(exp(-ddd*omega*dt));
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
end
