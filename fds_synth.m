
% fds_syn.m  ver 1.0  by Tom Irvine

function[a,fds]=fds_synth(Q,b,x,y,fn,nf,dt,a,T,t)

tpi=2*pi;



ijk=1;

while(1)
    
    fprintf(' ijk=%d \n',ijk);
    
    k=0;
    
    for i=1:nf
  
    
        nc=T*fn(i);
    
        
        if(x(i)<0.99*y(i))
            k=1;
            delta1=y(i)-x(i);
            delta2=delta1/nc;
            delta3=delta2^(1/b);
            delta4=delta3/Q;
            amp=delta4;
            phase=rand()*tpi;
            a=a+amp*sin(tpi*fn(i)*t+phase);
            fprintf(' fn=%7.3g  amp=%7.3g  x=%7.3g  y=%7.3g nc=%g %7.3g %7.3g %7.3g  \n',fn(i),amp,x(i),y(i),nc,delta1,delta2,delta3);
        end    
    end
    


    accel_input=a;
    [fds]=fds_sdof_response_rainflow_damage_alt(fn,Q,b,accel_input,dt);
    x=fds(:,2);    
    
    if(k==0 || ijk==1)
        break;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    ijk=ijk+1;
    
    if(ijk==12)
        disp('premature break');
        break;
    end
    
end