
%
%   compensation_avd.m  ver 1.0  by Tom Irvine
%


function[a,v,d]=compensation_avd(a,dt,minf,maxf)

tpi=2*pi;

num=length(a);
nt=floor(num/3);

aaa=a;

v=dt*cumtrapz(a);
d=dt*cumtrapz(v);

ve=abs(v(end));
de=abs(d(end));

rec=ve*de;

amax=0.05*max(abs(a));

t=1:1:num;

t=t/num;

df=maxf-minf;

dx=1e-06;
vx=1e-06;

for i=1:2000
    
    if(i<100 || rand()<0.5)
        f=df*rand()+minf;
        A=amax*(-0.5+rand());
    else
        f=fr*(0.95+0.1*rand());
        A=Ar*(0.95+0.1*rand());           
    end     
    
    if(f<minf)
        f=minf;
    end
    if(f>maxf)
        f=maxf;
    end
    if(A>amax)
        A=amax;
    end
    if(A<-amax)
        A=-amax;
    end
    
    
    arg=tpi*f*t(2*nt:num);
    
    
    y(2*nt:num)=A*sin(arg);
    
    yh=zeros(num,1);
    
    [yh(2*nt:num)]=Hanning_function(y(2*nt:num));
    

    
    yh=yh+aaa;
    
    vh=dt*cumtrapz(yh);
    dh=dt*cumtrapz(vh);
    
    vhe=abs(vh(end));
    dhe=abs(dh(end));
    
    q=vhe*dhe;
    
    if(i==1)
        fr=f;
        Ar=A;        
    end
    
    if((vhe<ve && (dhe<de || dhe<dx )) || (dhe<de && (vhe<ve || vhe<vx )))
    
        fr=f;
        Ar=A;

        if(q<rec)
            rec=q;
        end
        if(vhe<ve)
            ve=vhe;
        end
        if(dhe<de)
            de=dhe;
        end
        
        
        a=yh;
        v=vh;
        d=dh;
        
        out1=sprintf('i=%d ve=%8.4g  vhe=%8.4g   de=%8.4g  dhe=%8.4g',i,ve,vhe,de,dhe);
        disp(out1);    
    
    end
    

    
end

