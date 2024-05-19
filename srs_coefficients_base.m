%
%  srs_coefficients_base.m  ver 1.0  by Tom Irvine
%
function[a1,a2,b1,b2,b3,rd_b1,rd_b2,rd_b3,rv_b1,rv_b2,rv_b3,ra_b1,ra_b2,ra_b3]=...
                                      srs_coefficients_base(f,damp,dt)    
%
%  Smallwood, Ramp Invariant
%
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
        omegan=omega;
%
        if(num_damp==1)
            ddd=damp;
        else
            ddd=damp(j);
        end
%
%    Relative Displacement
%
        omegad=(omega*sqrt(1.-ddd^2));
%            
        cosd=(cos(omegad*dt));
        sind=(sin(omegad*dt));
        domegadt=(ddd*omega*dt);
%%
        eee1=exp(-domegadt);
        eee2=exp(-2.*domegadt);
%
        ecosd=eee1*cosd;
        esind=eee1*sind;     
%
        omeganT=omegan*dt;
%
        phi=2*ddd^2-1;
        DD1=(omegan/omegad)*phi;
        DD2=2*DD1;
%    
        df1=2*ddd*(ecosd-1) +DD1*esind +omeganT;
        df2=-2*omeganT*ecosd +2*ddd*(1-eee2) -DD2*esind;
        df3=(2*ddd+omeganT)*eee2 +(DD1*esind-2*ddd*ecosd);
%
        MD=(omegan^3*dt);
        rd_b1(j)=df1/MD;
        rd_b2(j)=df2/MD;
        rd_b3(j)=df3/MD;
        
%
%   Relative Velocity
%
        VV1=-(damp*omegan/omegad);
%    
        vf1=(-ecosd+VV1*esind)+1;
        vf2=eee2-2*VV1*esind-1;
        vf3=ecosd+VV1*esind-eee2;
        
        VD=(omegan^2*dt);
        rv_b1(j)=vf1/VD;
        rv_b2(j)=vf2/VD;
        rv_b3(j)=vf3/VD;

%
%   Relative Acceleration
%        
        MD=omegan*dt;
        ra_b1(j)=   esind/MD;
        ra_b2(j)=-2*esind/MD;
        ra_b3(j)=   esind/MD;
%
%    Absolute Acceleration
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