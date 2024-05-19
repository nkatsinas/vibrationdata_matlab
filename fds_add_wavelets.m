function[fdsr,ampr,accel_input,err_max,f,NHS,amp,td]=fds_add_wavelets(fdsr,ampr,accel_input,yy,num,err_max,accelr,...
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
       
         ampt=(-1.5+3*rand());
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
       
        
        [err_max,ampr,fdsr,accelr]=fds_wavelet_error_check(err_max,ampr,fdsr,accelr,Lfn,yy,fds,ampt,accel_input,ijk,xi);
   
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