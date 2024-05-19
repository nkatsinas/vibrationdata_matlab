%
%  vrs_srs_fds.m  ver 1.0  by Tom Irvine
%

function[accel_peak,accel_rms,pv_peak,pv_rms]=vrs_srs_fds(Q,fn,num_fn,base_input,dt,b)

    damp=1/(2*Q);

    accel_rms=zeros(num_fn,1);  
    accel_peak=zeros(num_fn,1);  
    pv_rms=zeros(num_fn,1);  
    pv_peak=zeros(num_fn,1);      
    
    for i=1:num_fn

        omega=2*pi*fn(i);
        omegad=omega*sqrt(1-damp^2);

        E=(exp(-damp*omega*dt));
        K=(omegad*dt);
        C=(E*cos(K));
        S=(E*sin(K));

        Sp=S/K;

        a1=(2*C);
        a2=(-(E^2));

        b1=(1.-Sp);
        b2=(2.*(Sp-C));
        b3=((E^2)-Sp);

        forward=[ b1,  b2,  b3 ];    
        back   =[  1, -a1, -a2 ];    

        accel_resp=filter(forward,back,base_input);
        accel_peak(i)=max(abs(accel_resp));
        accel_rms(i)=std(accel_resp);     
%
        sind=(sin(omegad*dt));
        domegadt=(damp*omega*dt);
        
        rd_b1=0.;
        rd_b2=-(dt/omegad)*exp(-domegadt)*sind;
        rd_b3=0;       
        
        forward=[ rd_b1,  rd_b2,  rd_b3 ];
        rd_resp=filter(forward,back,base_input);
        rd_resp=rd_resp*386;
        v=differentiate_function(rd_resp,dt);
        pv_peak(i)=max(abs(v));
        pv_rms(i)=std(v);   
        
        
        fds(i)=accel_resp
        
    end

end
