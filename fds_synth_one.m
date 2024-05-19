
% fds_synth_one.m  ver 1.0  by Tom Irvine

function[a,fds]=fds_synth_one(Q,b,fds_ref,fn,nf,dt,T,t,HW)

tpi=2*pi;

nt=length(t);

AA=zeros(nf,1);
phase=zeros(nf,1);
x1=zeros(nf,1);
y1=fds_ref;

for i=1:nf
    phase(i)=rand()*tpi;
end

ijk=1;

w=hann(nt);


while(1)
    
    fprintf(' ijk=%d \n',ijk);
    
    a=zeros(nt,1);
    
    k=0;
    
    for i=1:nf
  
        nc=T*fn(i);
        
        delta=(y1(i)-x1(i));
        
        s2=delta/nc;
        s3=s2^(1/b);
        s4=s3/Q;
        amp=s4;
        
        xx=x1(i);
        yy=y1(i);
            
        if(xx< yy)
            k=1;
            AA(i)=AA(i)+0.2*amp;
        end 
        if(xx> yy)
            k=1;
            AA(i)=AA(i)*0.98;
        end
        
        a=a+AA(i)*sin(tpi*fn(i)*t+phase(i));
        
        fprintf(' %7.3g %7.3g %7.3g %7.3g  \n',fn(i),AA(i),xx,yy);
        
    end
    
    if(HW==2)
        a=a.*w;
    end 
     
    accel_input=a;
    
    try
        [fds]=fds_sdof_response_rainflow_damage_one(fn,Q,b,accel_input,dt);
    catch
        warndlg('fail:  fds_sdof_response_rainflow_damage_one');
        return;
        fds=0;
    end
        
    x1=fds;    
     
    if(k==0 || ijk==16)
        break;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    ijk=ijk+1;
   
    
end