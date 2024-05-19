
disp(' ');
N=input(' Enter number of trials: ');
disp(' ');

fig_num=10;

tpi=2*pi;
fpi=4*pi;

A=50*386;

T=0.010;

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

AA=A*(T/pi)^2;

for ijk=1:N

    clear a;
    clear v;
    clear d;
    clear TT;
    clear amp;
    
    dur=T*(3+5*rand());
    durh=dur/2;
    
    nt=round(dur/dt);

    TT=zeros(nt,1);
    
    for i=1:nt
        TT(i)=-durh+(i-1)*dt;
    end
    
    damp=zeros(nt,1);
    vamp=zeros(nt,1);
    aamp=zeros(nt,1);
    
    T1=durh-T/2;
    T2=T1+dur;

    pih=pi/2;

    pia=pih;
    pib=3*pih;
    pic=5*pih;

    dur2=2*dur;

    ipia=  dur/pia;
    ipib=  dur/pib;
    ipic=  dur/pic;

    ipia2=(ipia)^2;
    ipib2=(ipib)^2;
    ipic2=(ipic)^2;


    a=AA*(-0.5+1*rand())/4;
    b=AA*(-0.5+1*rand())/4;
    c=( pib*b -pia*a)/pic;

    for i=1:nt

        td=TT(i)/durh;

        piatd=pia*td;
        pibtd=pib*td;
        pictd=pic*td;

        damp(i)=        a*cos(piatd)    +b*cos(pibtd)      +c*cos(pictd);       
        vamp(i)=   a*ipia*sin(piatd) +b*ipib*sin(pibtd) +c*ipic*sin(pictd); 
        aamp(i)= -a*ipia2*cos(piatd)-b*ipib2*cos(pibtd)-c*ipic2*cos(pictd); 

        if(TT(i)>T1 && TT(i)<=T2  && 1>2)
            td=TT(i)-T1; 

            arg=pi*td/T;

            damp(i)=damp(i)         -AA*sin(arg);
            vamp(i)=vamp(i)+  AA*(T/pi)*cos(arg);
            aamp(i)=aamp(i)+AA*(T/pi)^2*sin(arg);

        end               
        
    end
   
    d=damp;
    v=vamp;
    amp=aamp/386;
    
%%    [v]=integrate_function(386*amp,dt);
%%    [d]=integrate_function(v,dt);
    
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