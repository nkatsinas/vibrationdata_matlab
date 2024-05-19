
N=300000;


fig_num=10;

tpi=2*pi;
fpi=4*pi;

A=50;

TS1=0.0105;
TS2=0.002;

sr=10000;
dt=1/sr;

dmax1=1e+99;
dmax2=1e+99;
dmax12=1e+99;

dend_rec=1e+99;
vend_rec=1e+99;
dmax_rec=1e+99;

xlabel3='Time (sec)';
ylabel1='Accel (G)';
ylabel2='Vel (in/sec)';
ylabel3='Disp (in)';
t_string1='Accel';
t_string2='Velox';
t_string3='Disp';


for ijk=1:N

    clear a;
    clear v;
    clear d;
    clear TT;
    clear amp;

    T1=TS1*(2+5*rand());
    T2=T1+TS1;
    T3=T2+TS2;
%    TZ=TS1*(2+7*rand());
    TZ=T1;
    T4=T3+TZ;
    
    dur=T4;
    nt=round(dur/dt);
    
    TT=linspace(0,(nt-1)*dt,nt);
    
    TT=fix_size(TT);
    
    amp=zeros(nt,1);
    
    B1=(A/4)*(0.1+0.7*rand());
    C1=(A/4)*(0.2+0.7*rand());
    B2=(A/4)*(0.1+0.7*rand());
    C2=(A/4)*(0.2+0.7*rand());

    
    scale1=0.5+1.0*rand();
    scale2=0.5+1.0*rand();    
    
    for i=1:nt
       
        if(TT(i)<=T1)
            tx=(TT(i)/T1)^scale1*TT(i);
            amp(i)=-B1*sin(pi*tx/T1)+B2*sin(tpi*tx/T1);
        end
        if(TT(i)>T1 && TT(i)<=T2)
            td=TT(i)-T1; 
            amp(i)=A*td/TS1;
        end
        if(TT(i)>T2 && TT(i)<=T3)
            td=TT(i)-T2; 
            amp(i)=A*(1-td/TS2)^2;
        end        
        if(TT(i)>T3 && TT(i)<=T4)
           td=TT(i)-T3; 
           tz=(td/TZ)^scale2*TT(i); 
           amp(i)=-C1*sin(pi*td/TZ)-C2*sin(tpi*td/TZ);
        end             
        
        
    end
    
    [v]=integrate_function(386*amp,dt);
    [d]=integrate_function(v,dt);
    
    vend=abs(v(end));
    dend=abs(d(end));
    dmax=max(abs(d));
    
    dtv=dend*dmax*vend;
    
    if( (dmax<dmax_rec || dend<0.6) && (dend<dend_rec || dend<0.003) && (vend<vend_rec || vend<0.2))
        
        if(dmax<dmax_rec)
            max_rec=dmax;
        end
        
        if(dend<dend_rec)
            dend_rec=dend;
        end
        if(vend<vend_rec)
            vend_rec=vend;
        end       
        
        data1=[TT amp];
        data2=[TT v];
        data3=[TT d];
        
        out1=sprintf(' %d   %8.4g   %8.4g   %8.4g ',ijk,dend,vend,dmax);
        disp(out1);
        
    end    
    
end    


[fig_num]=subplots_three_linlin_three_titles(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);