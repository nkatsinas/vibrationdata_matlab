
% fds_synth3.m  ver 1.0  by Tom Irvine

function[a,fds]=fds_synth3(y1,y2,y3,y4,fn,nf,dt,a,T,t)

tpi=2*pi;

nt=length(t);

AA=zeros(nf,1);
phase=zeros(nf,1);
x1=zeros(nf,1);
x2=zeros(nf,1);
x3=zeros(nf,1);
x4=zeros(nf,1);

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
        
        delta1=(y1(i)-x1(i));
        delta2=(y2(i)-x2(i));
        delta3=(y3(i)-x3(i));
        delta4=(y4(i)-x4(i));
        
        dd=[delta1 delta2 delta3 delta4];
        xq=[x1(i) x2(i) x3(i) x4(i)];
        yq=[y1(i) y2(i) y3(i) y4(i)];
        bq=[4 8 4 8];
        Qq=[10 30 10 30];
        
        [C,I]=max(dd);
        
        xx=xq(I);
        yy=yq(I);
        bb=bq(I);
        QQ=Qq(I);
       
        
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
    
    Q = [10 30];
    b = [4 8];

    [fds]=fds_sdof_response_rainflow_damage_alt(fn,Q,b,accel_input,dt);
 
    x1=fds(:,2);    
    x2=fds(:,3); 
    x3=fds(:,4); 
    x4=fds(:,5);     
    
    if(k==0 || ijk==16)
        break;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    ijk=ijk+1;
    

    
end