clear accel;
clear f;
clear amp;
clear NHS;
clear td;
clear yy;
clear fds;

tpi=2*pi;

t=xaccel1(:,1);
nt=length(t);

dur=t(end)-t(1);

dt=dur/(nt-1);


f=xwavetable1(:,2);
amp=xwavetable1(:,3);
NHS=xwavetable1(:,4);
td=xwavetable1(:,5);

num=length(f);

fn=LL_Q10_b4(:,1);
%LL_Q10_b8
%LL_Q30_b4 
%LL_Q30_b8  


cage=zeros(num,1);

Lfn=length(fn);

for i=1:num
    
    [~,j]=min(abs(f(i)-fn));
    
    cage(i)=j;
        
end

yy=zeros(Lfn,4);

for i=1:Lfn
    
    yy(i,1)=LL_Q10_b4(i,2);
    yy(i,2)=LL_Q10_b8(i,2);
    yy(i,3)=LL_Q30_b4(i,2);
    yy(i,4)=LL_Q30_b8(i,2);

end
    
Qv = [10 30];
bv = [4 8];


zz=1.01;

err_max=1.0e+99;

[accel_input]=generate_th_from_wavelet_table(f,amp,NHS,td,nt,dur,t);
[fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Qv,bv,accel_input,dt);

ampx=amp;
ampr=amp;

ratio=1;

m1=30;
m2=1400;
mpa=20;

progressbar;

xi=1;

for ijk=1:m1
    
    progressbar(ijk/m1);
    

    [err_max,ampr,fdsr,accelr]=error_check(err_max,ampr,fdsr,accelr,Lfn,yy,fds,amp,accel_input,ijk,xi);
    
    ratio=0.9+0.3*rand();
    amp=ampr*ratio;

       
    [accel_input]=generate_th_from_wavelet_table(f,amp,NHS,td,nt,dur,t);
    [fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Qv,bv,accel_input,dt);
    
end

disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NN=round(m2/30);

progressbar;

for ijk=1:m2

    progressbar(ijk/m2);

    if(ijk<=NN || rand()<0.5)
    
        [fdsr,ampr,accel_input,err_max]=random_adjustment(fdsr,ampr,accel_input,yy,num,err_max,accelr,...
                                                  Lfn,amp,ijk,NHS,td,nt,dur,t,fn,Qv,bv,dt,cage,f);  
    else
                                              
        [fdsr,ampr,accel_input,err_max,f,NHS,amp,td]=add_wavelets(fdsr,ampr,accel_input,yy,num,err_max,accelr,...
                                                  Lfn,amp,ijk,NHS,td,nt,dur,t,fn,Qv,bv,dt,cage,f);                                           
    end
end                     

progressbar(1);
                                              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Postive Adjust');
disp(' ');

[fdsr,ampr,accelr]=positive_adjust(fdsr,ampr,accelr,f,NHS,td,nt,dur,t,fn,Qv,bv,dt,yy,mpa);
%    
acceleration=[t,accelr];

figure(1);
plot(t,accelr);
grid on;
yl = ylim;
ya=max(abs(yl));
ylim([-ya,ya]);
xlabel('Time (sec)');
ylabel('Accel (G)');

xmin=fn(1);
xmax=fn(end);

y1=LL_Q10_b4;
y2=LL_Q10_b8;
y3=LL_Q30_b4;
y4=LL_Q30_b8;

FS21=[fn fdsr(:,1)];
FS22=[fn fdsr(:,2)];
FS23=[fn fdsr(:,3)];
FS24=[fn fdsr(:,4)];

Q=[10 10 30 30];
b=[4 8 4 8];

fig_num=2;
[fig_num]=plot_fds_subplots_2x2_two_curves_Qb(fig_num,y1,y2,y3,y4,FS21,FS22,FS23,FS24,xmin,xmax,Q,b);



function[fdsr,ampr,accelr]=positive_adjust(fdsr,ampr,accelr,f,NHS,td,nt,dur,t,fn,Qv,bv,dt,yy,mpa)

amp=ampr;
fds=fdsr;

progressbar;

for ijk=1:mpa

    progressbar(ijk/mpa);
    
    d1=yy(:,1)-fds(:,1);
    d2=yy(:,2)-fds(:,2);
    d3=yy(:,3)-fds(:,3);
    d4=yy(:,4)-fds(:,4);
    
    if(max(d1)>1 || max(d2)>1 || max(d3)>1 || max(d4)>1)
            amp=amp*1.03;
    else
        progressbar(1);
        break;
    end
    
    [accel_input]=generate_th_from_wavelet_table(f,amp,NHS,td,nt,dur,t);
    [fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Qv,bv,accel_input,dt);
    
    accelr=accel_input;
    ampr=amp;
    fdsr=fds;
end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[err_max,ampr,fdsr,accelr]=error_check(err_max,ampr,fdsr,accelr,Lfn,yy,fds,amp,accel_input,ijk,xi)


    dd=zeros(Lfn,1);
    
    for i=1:Lfn
        
        
        d(1)=yy(i,1)/fds(i,1);
        d(2)=yy(i,2)/fds(i,2);
        d(3)=yy(i,3)/fds(i,3);
        d(4)=yy(i,4)/fds(i,4);      
        
        dd(i)=sum(abs(log10(d)));
        
    end

    
    err=max(dd)*sum(dd);
    
%    fprintf('%d %8.5g %8.5g  %d\n',ijk,err_max,err,xi);
    
    if(err<err_max)
        err_max=err;
        ampr=amp;
        fdsr=fds;
        accelr=accel_input;
        fprintf(' %d %8.5g %d\n',ijk,err_max,xi);
    end
  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[fdsr,ampr,accel_input,err_max]=...
    random_adjustment(fdsr,ampr,accel_input,yy,num,err_max,accelr,...
                      Lfn,amp,ijk,NHS,td,nt,dur,t,fn,Qv,bv,dt,cage,f)


    xxx=rand();
    
    if(xxx<=0.5)
        xi=2;
        for i=1:num    
            amp(i)=ampr(i)*(0.98+0.04*rand());
        end
        xxx=1;
    else
        xi=3;
        for i=1:num    
        
            j=cage(i);
        
            d(1)=yy(j,1)/fdsr(j,1);
            d(2)=yy(j,2)/fdsr(j,2);
            d(3)=yy(j,3)/fdsr(j,3);
            d(4)=yy(j,4)/fdsr(j,4);       
            
            d=log10(d);
        
            if(min(d)<0)
                amp(i)=amp(i)*(1-0.02*rand());
            else
                amp(i)=amp(i)*(1+0.02*rand());
            end
        end
        xxx=2;
    end
        
    [accel_input]=generate_th_from_wavelet_table(f,amp,NHS,td,nt,dur,t);
    [fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Qv,bv,accel_input,dt);    
    [err_max,ampr,fdsr,accelr]=error_check(err_max,ampr,fdsr,accelr,Lfn,yy,fds,amp,accel_input,ijk,xi);
        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[fdsr,ampr,accel_input,err_max,f,NHS,amp,td]=add_wavelets(fdsr,ampr,accel_input,yy,num,err_max,accelr,...
                                                  Lfn,amp,ijk,NHS,td,nt,dur,t,fn,Qv,bv,dt,cage,f)                                               

amp=ampr;

err_old=err_max;


    
            clear ampt;
        clear tdt;
        clear NHSt;
        clear ft;
   
    if(rand()<0.5)
        xi=4;
        d1=yy(:,1)-fdsr(:,1);        
        d2=yy(:,2)-fdsr(:,2);        
        d3=yy(:,3)-fdsr(:,3);        
        d4=yy(:,4)-fdsr(:,4);
        
        ddd=zeros(Lfn,1);
        for ik=1:Lfn
            ddd(ik)=max([abs(d1(ik)) abs(d2(ik)) abs(d3(ik)) abs(d4(ik))]);
        end     
        
        [C,I]=max(ddd);
        ft=f(I);
    else
        xi=5;
        jj=round(Lfn*rand());
        if(jj<1)
            jj=1;
        end
        ft=fn(jj);
    end
    
         nnn=[3 5 7 9 11 13 15 17 19 21 23 25 27 29];
       
         ampt=(-1+2*rand());
         tdt=(0.2*dur*rand());
         jj=round(length(nnn)*rand());
         if(jj<1)
             jj=1;
         end
         NHSt=nnn(jj);
         
         
         iflag=0;
    
         while(1)
            for ij=1:100
%
                if( (2*pi)*NHSt/(2.*ft) + tdt < dur )
                    iflag=1;
                    break;
                end
            end  
            if(iflag==1)
                break;
            else
                NHSt=NHSt-2;
            end
         end
         
         
         ampt=[amp; ampt];
         NHSt=[NHS; NHSt];
         tdt=[td; tdt];
         ft=[f; ft];
         
 %        fprintf(' ft=%8.4g ampt=%8.4g  NHSt=%d  tdt=%8.4g\n',ft(end),ampt(end),NHSt(end),tdt(end));
 %       max(accel_input)
        [accel_input]=generate_th_from_wavelet_table(ft,ampt,NHSt,tdt,nt,dur,t);
%        max(accel_input)
        
        [fds,zflag]=fds_sdof_response_rainflow_damage_alt(fn,Qv,bv,accel_input,dt);    
       
        
        [err_max,ampr,fdsr,accelr]=error_check(err_max,ampr,fdsr,accelr,Lfn,yy,fds,ampt,accel_input,ijk,xi);
   
%        uuu=input(' ');
           
%        fprintf('**ijk=%d  err_max=%8.4g    %7.4g %7.4g  %d  %7.4g\n',ijk,err_max,ft(end),ampt(end),NHSt(end),tdt(end));
        
        if(err_max<err_old)
            fdsr=fds;
            amp=ampt;
            NHS=NHSt;
            td=tdt;
            f=ft;
%            fprintf('%8.4g %8.4g %8.4g  %d  %8.4g\n',err_max,ft(end),ampt(end),NHSt(end),td(end));
        end

    
end



