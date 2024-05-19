
% fds_synth_alt.m  ver 1.0  by Tom Irvine

function[a,fds]=fds_synth_alt(fds_ref,fn,nf,dt,a,T,t,Q,b)

tpi=2*pi;

bq=b;
Qq=Q;

nt=length(t);

AA=zeros(nf,1);
phase=zeros(nf,1);

y=fds_ref;

sz=size(fds_ref);
ncols=sz(2);
x=zeros(fn,ncols);

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
        
        dd=zeros(ncols,1);
        
        for kv=1:ncols
            dd(kv)=y(i,kv)-x(i,kv);
        end
        
        [C,I]=max(dd);
               
        xx=x(i,I);
        yy=y(i,I);
        bb=b(I);
        QQ=Q(I);
       
        s2=C/nc;
        s3=s2^(1/bb);
        s4=s3/QQ;
        amp=s4;
            
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
    
    accel_input=a;

    [fds]=fds_sdof_response_rainflow_damage_alt_Qb(fn,Q,b,accel_input,dt);
 
    x=fds;         
    
    if(k==0 || ijk==16)
        break;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    ijk=ijk+1;
    

    
end