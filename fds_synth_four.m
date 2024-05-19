
% fds_synth_four.m  ver 1.0  by Tom Irvine

function[a,fds]=fds_synth_four(Q,b,fds_ref,fn,nf,dt,T,t,HW)

tpi=2*pi;

nt=length(t);

AA=zeros(nf,1);
phase=zeros(nf,1);
x1=zeros(nf,1);
x2=zeros(nf,1);
x3=zeros(nf,1);
x4=zeros(nf,1);

y1=fds_ref(:,1);
y2=fds_ref(:,2);
y3=fds_ref(:,3);
y4=fds_ref(:,4);

for i=1:nf
    phase(i)=rand()*tpi;
end

zflag=0;

w=hann(nt);

maxn=16;

ijk=1;

progressbar;

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
        bq=b;
        Qq=Q;
        
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
    
    fprintf(' ijk=%d \n',ijk);
    ijk=ijk+1;
    
    if(HW==2)
        a=a.*w;
    end    
    accel_input=a;

    
    Qv = [Q(1) Q(3)];
    bv = [b(1) b(2)];
    
    try
        [fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Qv,bv,accel_input,dt);
    catch
        warndlg('fail: fds_sdof_response_rainflow_damage_alt')
        return;
    end
    
    if(zflag==1)
        break;
    end
        
    x1=fds(:,1);    
    x2=fds(:,2); 
    x3=fds(:,3); 
    x4=fds(:,4);     
    
    progressbar(ijk/maxn);
    
    if(k==0 || ijk==maxn)
        break;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
end

progressbar(1);