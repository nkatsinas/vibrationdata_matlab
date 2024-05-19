
% fds_syn.m  ver 1.0  by Tom Irvine

function[a,fds]=fds_synth(Q,b,x,y,fn,nf,dt,a,T,t)

tpi=2*pi;

nt=length(t);

AA=zeros(nf,1);
phase=zeros(nf,1);

for i=1:nf
    phase(i)=rand()*tpi;
end

ijk=1;

while(1)
    
    fprintf(' ijk=%d \n',ijk);
    
    a=zeros(nt,1);
    
    k=0;
    
    for i=1:nf
  
        nc=T*fn(i);
    
        delta1=abs(y(i)-x(i));
        delta2=delta1/nc;
        delta3=delta2^(1/b);
        delta4=delta3/Q;
        amp=delta4;
            
        if(x(i)< y(i))
            k=1;
            AA(i)=AA(i)+0.2*amp;
        end 
        if(x(i)> y(i))
            k=1;
            AA(i)=AA(i)*0.98;
        end          
        
        a=a+AA(i)*sin(tpi*fn(i)*t+phase(i));
        
        fprintf(' %7.3g %7.3g %7.3g %7.3g  \n',fn(i),AA(i),x(i),y(i));
        
    end
    
    
    

    accel_input=a;
    [fds]=fds_sdof_response_rainflow_damage_alt(fn,Q,b,accel_input,dt);
    x=fds(:,2);    
    
    if(k==0 || ijk==14)
        break;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    ijk=ijk+1;
    

    
end