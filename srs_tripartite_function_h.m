%
%   srs_tripartite_function_h.m   ver 2.6   by Tom Irvine
%
function[fig_num,h]=srs_tripartite_function_h(iunit,fig_num,pv_srs,Q)
%

    sz=size(pv_srs);
    
    fn=pv_srs(:,1);
    
    if(sz(2)==2)
        iflag=2;
    end
    if(sz(2)==3)
        iflag=3;
        pv_pos=pv_srs(:,2);        
        pv_neg=pv_srs(:,3);  
    end

%    
    n=length(fn);
%
    fmin=fn(1);
    fmax=fn(n);
%
    fmax= 10^(round(log10(fmax)+0.5));
%
    if  fn(1) >= 0.1
        fmin=0.1;
    end
    if  fn(1) >= 1
        fmin=1;
    end
    if  fn(1) >= 10
        fmin=10;
    end
    if  fn(1) >= 100
        fmin=100;
    end
%    
%
    tpi_fmin=(2*pi*fmin);
    tpi_fmax=(2*pi*fmax);
%

    vchoice=1;
    if(vchoice==1)
%%        disp(' select plot type:  1=positive & negative   2=maximax ');
%
        srs_max = max(pv_srs(:,2));
        srs_min = min(pv_srs(:,2));
%
%%        size(fn)
%%        size(pv_pos)
%%        size(abs(pv_neg))

        h=figure(fig_num);
        fig_num=fig_num+1;
        
        if(iflag==2)
            plot(fn,pv_srs(:,2),'LineWidth',2);    
        end        
        if(iflag==3)
            plot(fn,pv_pos,fn,abs(pv_neg),'-.','LineWidth',2);
%            legend ('positive','negative');   
        end

        out5 = sprintf(' Pseudo Velocity Shock Response Spectrum Q=%g \n\n',Q);
        title(out5,'FontWeight','bold','FontSize',11);
%        
%
        if iunit==1
            ylabel('Velocity (in/sec)','FontWeight','demi','FontSize',11);
            scale=386.;
        end
        if iunit==2
            ylabel('Velocity (cm/sec)','FontWeight','demi','FontSize',11);
            scale=9.81*100;
        end
        if iunit==3
            ylabel('Velocity (cm/sec)','FontWeight','demi','FontSize',11);
            scale=1;
        end        
        xlabel('Natural Frequency (Hz)','FontWeight','demi','FontSize',11);
%
        grid;
        set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log','FontSize',13);
%
        ymax= 10^(ceil(log10(srs_max)));
        ymin= 10^(floor(log10(srs_min)));
%
        if(ymin<ymax/1000)
            ymin=ymax/1000;
        end
%
        nxd=round(log10(fmax/fmin));
        nyd=round(log10(ymax/ymin));
%
        if(nyd<nxd)
            nyd=nxd;
        end
        if(nyd>nxd)
            nyd=nxd;
        end
        ymin=ymax/10^nyd;
        
%%        out1=sprintf('\n nxd=%d  nyd=%d ',nxd,nyd);
%%        disp(out1);
%
        axis([fmin,fmax,ymin,ymax]);
        hold on;
%        v=a/(2pif)
        f1=fmin;
        v2=ymin;
%
%    acceleration lines
%
        for jk=-5:5
            for k=1:10
                amp=k*10^(jk);
                v1=amp*scale/tpi_fmin;
                f2=amp*scale/(2*pi*v2);
                a=[f1 v1; f2 v2];
                plot(a(:,1),a(:,2),'color','k','LineWidth',0.25);
                hold on;   
            end
        end  
% 
%    relative displacement lines
%

        for jk=-8:5
            for k=1:10
                amp=k*10^(jk);
                v1=amp*tpi_fmin;
                v2=amp*tpi_fmax;  
                f2=fmax;
                a=[f1 v1; f2 v2];
                plot(a(:,1),a(:,2),'color','k','LineWidth',0.25);
                hold on;   
            end
        end  
 %     
    end
    theta=-45;
%
    theta = -20.3*(nxd/nyd) -17.5;
%    
    set(gca,'DefaultTextRotation',theta);
%    
    amax=ymax*tpi_fmin/scale;
    amin=ymin*tpi_fmin/scale;
%   

    scale_rd=scale;
        
    if(iunit==2)
           scale_rd=10*scale; 
    end

    if(iunit==1 || iunit==2)
        if(amin<=0.01 && amax>=0.01)
            text('Position',[fmin  0.012*scale/tpi_fmin],'String','0.01 G','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amin<=0.1 && amax>=0.1)   
            text('Position',[fmin   0.12*scale/tpi_fmin],'String', '0.1 G','color','k','FontWeight','demi','FontSize',13)     
        end   
        if(amin<=1 && amax>=1)
            text('Position',[fmin    1.2*scale/tpi_fmin],'String',   '1 G','color','k','FontWeight','demi','FontSize',13)        
        end   
        if(amin<=10 && amax>=10) 
            text('Position',[fmin     12*scale/tpi_fmin],'String',  '10 G','color','k','FontWeight','demi','FontSize',13)        
        end    
        if(amin<=100 && amax>=100)
            text('Position',[fmin    120*scale/tpi_fmin],'String', '100 G','color','k','FontWeight','demi','FontSize',13)        
        end    
        if(amin<=1000 && amax>=1000) 
            text('Position',[fmin   1200*scale/tpi_fmin],'String',  '1K G','color','k','FontWeight','demi','FontSize',13)      
        end   
        if(amin<=10000 && amax>=10000)   
            text('Position',[fmin  12000*scale/tpi_fmin],'String', '10K G','color','k','FontWeight','demi','FontSize',13)   
        end   
        if(amin<=100000 && amax>=100000)
            text('Position',[fmin 120000*scale/tpi_fmin],'String','100K G','color','k','FontWeight','demi','FontSize',13)
        end 
    else
         if(amin<=0.01 && amax>=0.01)
            text('Position',[fmin  0.012*scale/tpi_fmin],'String','0.01 m/s^2','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amin<=0.1 && amax>=0.1)   
            text('Position',[fmin   0.12*scale/tpi_fmin],'String', '0.1 m/s^2','color','k','FontWeight','demi','FontSize',13)     
        end   
        if(amin<=1 && amax>=1)
            text('Position',[fmin    1.2*scale/tpi_fmin],'String',   '1 m/s^2','color','k','FontWeight','demi','FontSize',13)        
        end   
        if(amin<=10 && amax>=10) 
            text('Position',[fmin     12*scale/tpi_fmin],'String',  '10 m/s^2','color','k','FontWeight','demi','FontSize',13)        
        end    
        if(amin<=100 && amax>=100)
            text('Position',[fmin    120*scale/tpi_fmin],'String', '100 m/s^2','color','k','FontWeight','demi','FontSize',13)        
        end    
        if(amin<=1000 && amax>=1000) 
            text('Position',[fmin   1200*scale/tpi_fmin],'String',  '1K m/s^2','color','k','FontWeight','demi','FontSize',13)      
        end   
        if(amin<=10000 && amax>=10000)   
            text('Position',[fmin  12000*scale/tpi_fmin],'String', '10K m/s^2','color','k','FontWeight','demi','FontSize',13)   
        end   
        if(amin<=100000 && amax>=100000)
            text('Position',[fmin 120000*scale_rd/tpi_fmin],'String','100K m/s^2','color','k','FontWeight','demi','FontSize',13)
        end        
    end
%    
%%%%%  v=a/(2pif)
%
    aamax=ymax*tpi_fmax/scale;
%
    if(iunit==1 || iunit==2)
        if(amax<=0.01 && 0.01<aamax)
            text('Position',[0.012*scale/(2*pi*ymax) ymax],'String','0.01 G','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amax<=0.1 && 0.1<aamax)
            text('Position',[0.12*scale/(2*pi*ymax) ymax],'String','0.1 G','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amax<=1 && 1<aamax)
            text('Position',[1.2*scale/(2*pi*ymax) ymax],'String','1 G','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amax<=10 && 10<aamax)
            text('Position',[12*scale/(2*pi*ymax) ymax],'String','10 G','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amax<=100 && 100<aamax)
            text('Position',[120*scale/(2*pi*ymax) ymax],'String','100 G','color','k','FontWeight','demi','FontSize',13)  
        end   
        if(amax<=1000 && 1000<aamax)
            text('Position',[1200*scale/(2*pi*ymax) ymax],'String','1K G','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amax<=10000 && 10000<aamax)
            text('Position',[12000*scale/(2*pi*ymax) ymax],'String','10K G','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amax<=100000 && 100000<aamax)
            text('Position',[120000*scale/(2*pi*ymax) ymax],'String','100K G','color','k','FontWeight','demi','FontSize',13)  
        end    
    else
         if(amax<=0.01 && 0.01<aamax)
            text('Position',[0.012*scale/(2*pi*ymax) ymax],'String','0.01 m/s^2','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amax<=0.1 && 0.1<aamax)
            text('Position',[0.12*scale/(2*pi*ymax) ymax],'String','0.1 m/s^2','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amax<=1 && 1<aamax)
            text('Position',[1.2*scale/(2*pi*ymax) ymax],'String','1 m/s^2','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amax<=10 && 10<aamax)
            text('Position',[12*scale/(2*pi*ymax) ymax],'String','10 m/s^2','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amax<=100 && 100<aamax)
            text('Position',[120*scale/(2*pi*ymax) ymax],'String','100 m/s^2','color','k','FontWeight','demi','FontSize',13)  
        end   
        if(amax<=1000 && 1000<aamax)
            text('Position',[1200*scale/(2*pi*ymax) ymax],'String','1K m/s^2','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amax<=10000 && 10000<aamax)
            text('Position',[12000*scale/(2*pi*ymax) ymax],'String','10K m/s^2','color','k','FontWeight','demi','FontSize',13)  
        end
        if(amax<=100000 && 100000<aamax)
            text('Position',[120000*scale/(2*pi*ymax) ymax],'String','100K m/s^2','color','k','FontWeight','demi','FontSize',13)  
        end         
    end
%%%%
    set(gca,'DefaultTextRotation',-theta);
    dmax=ymax/tpi_fmax;
    dmin=ymin/tpi_fmax;
%  
    if(iunit==1)
        if(dmin<=10 && dmax>=10)
            text('Position',[0.32*fmax  4*tpi_fmax],'String','10 in','color','k','FontWeight','demi','FontSize',13)  
        end
        if(dmin<=1 && dmax>=1)
            text('Position',[0.32*fmax  0.4*tpi_fmax],'String','1 in','color','k','FontWeight','demi','FontSize',13)  
        end
        if(dmin<=0.1 && dmax>=0.1)
            text('Position',[0.32*fmax  0.04*tpi_fmax],'String','0.1 in','color','k','FontWeight','demi','FontSize',13)  
        end
        if(dmin<=0.01 && dmax>=0.01)
            text('Position',[0.32*fmax  0.004*tpi_fmax],'String','0.01 in','color','k','FontWeight','demi','FontSize',13)  
        end
        if(dmin<=0.001 && dmax>=0.001)
            text('Position',[0.32*fmax  0.0004*tpi_fmax],'String','0.001 in','color','k','FontWeight','demi','FontSize',13)  
        end
        if(dmin<=0.0001 && dmax>=0.0001)
            text('Position',[0.32*fmax  0.00004*tpi_fmax],'String','1e-04 in','color','k','FontWeight','demi','FontSize',13)  
        end      
    else
        nn=100;
        if(dmin<=nn && dmax>=nn)
            text('Position',[0.32*fmax  4*tpi_fmax*10],'String','1 m','color','k','FontWeight','demi','FontSize',13)  
        end
        nn=nn*0.1;
        if(dmin<=nn && dmax>=nn)
            text('Position',[0.32*fmax  0.4*tpi_fmax*10],'String','0.1 m','color','k','FontWeight','demi','FontSize',13)  
        end
        nn=nn*0.1;
        if(dmin<=nn && dmax>=nn)
            text('Position',[0.32*fmax  0.04*tpi_fmax*10],'String','1 cm','color','k','FontWeight','demi','FontSize',13)  
        end
        nn=nn*0.1;
        if(dmin<=nn && dmax>=nn)
            text('Position',[0.32*fmax  0.004*tpi_fmax*10],'String','1 mm','color','k','FontWeight','demi','FontSize',13)  
        end
        nn=nn*0.1;
        if(dmin<=nn && dmax>=nn)
            text('Position',[0.32*fmax  0.0004*tpi_fmax*10],'String','0.1 mm','color','k','FontWeight','demi','FontSize',13)  
        end
        nn=nn*0.1;
        if(dmin<=nn && dmax>=nn)
            text('Position',[0.32*fmax  0.00004*tpi_fmax*10],'String','0.01 mm','color','k','FontWeight','demi','FontSize',13)  
        end  
        nn=nn*0.1;
        if(dmin<=nn && dmax>=nn)
            text('Position',[0.32*fmax  0.000004*tpi_fmax*10],'String','0.001 mm','color','k','FontWeight','demi','FontSize',13)  
        end 
        nn=nn*0.1;
        if(dmin<=nn && dmax>=nn)
            text('Position',[0.32*fmax  0.0000004*tpi_fmax*10],'String','0.00001 mm','color','k','FontWeight','demi','FontSize',13)  
        end          
    end
%%%%
    ddmax=ymax/tpi_fmin;
    ddmin=ymax/tpi_fmax; 
%  
    if(iunit==1)
%        
        if(ddmin<=0.01 && 0.01<ddmax)
            text('Position',[ymax/(2*pi*0.01) ymax],'String','0.01 in','color','k','FontWeight','demi','FontSize',13)  
        end
 %
        if(ddmin<=0.1 && 0.1<ddmax)
            text('Position',[ymax/(2*pi*0.1) ymax],'String','0.1 in','color','k','FontWeight','demi','FontSize',13)  
        end
 %
        if(ddmin<=1 && 1<ddmax)
            text('Position',[ymax/(2*pi*1) ymax],'String','1 in','color','k','FontWeight','demi','FontSize',13)  
        end
  %
        if(ddmin<=10 && 10<ddmax)
            text('Position',[ymax/(2*pi*10) ymax],'String','10 in','color','k','FontWeight','demi','FontSize',13)  
        end 
 %
        if(ddmin<=100 && 100<ddmax)
            text('Position',[ymax/(2*pi*100) ymax],'String','100 in','color','k','FontWeight','demi','FontSize',13)  
        end
    else
      %  
        nn=0.00001;
        if(ddmin<=nn && nn<ddmax)
            text('Position',[0.1*ymax/(2*pi*0.000001) ymax],'String','0.0001 mm','color','k','FontWeight','demi','FontSize',13)  
        end           
    %      
        nn=nn*10;
        if(ddmin<=nn && nn<ddmax)
            text('Position',[0.1*ymax/(2*pi*0.00001) ymax],'String','0.001 mm','color','k','FontWeight','demi','FontSize',13)  
        end         
 %     
        nn=nn*10;
        if(ddmin<=nn && nn<ddmax)
            text('Position',[0.1*ymax/(2*pi*0.0001) ymax],'String','0.01 mm','color','k','FontWeight','demi','FontSize',13)  
        end          
%        
        nn=nn*10;
        if(ddmin<=nn && nn<ddmax)
            text('Position',[0.1*ymax/(2*pi*0.001) ymax],'String','0.1 mm','color','k','FontWeight','demi','FontSize',13)  
        end        
%        
        nn=nn*10;
        if(ddmin<=nn && nn<ddmax)
            text('Position',[0.1*ymax/(2*pi*0.01) ymax],'String','1 mm','color','k','FontWeight','demi','FontSize',13)  
        end
 %
        nn=nn*10;
        if(ddmin<=nn && nn<ddmax)
            text('Position',[0.1*ymax/(2*pi*0.1) ymax],'String','1 cm','color','k','FontWeight','demi','FontSize',13)  
        end
 %
        nn=nn*10;
        if(ddmin<=nn && nn<ddmax)
            text('Position',[0.1*ymax/(2*pi*1) ymax],'String','0.1 m','color','k','FontWeight','demi','FontSize',13)  
        end
 %
        nn=nn*10; 
        if(ddmin<=nn && nn<ddmax)
            text('Position',[ymax/(2*pi*10) ymax*10],'String','1 m','color','k','FontWeight','demi','FontSize',13)  
        end 
 %
        nn=nn*10;
        if(ddmin<=nn && nn<ddmax)
            text('Position',[ymax/(2*pi*100) ymax*10],'String','10 m','color','k','FontWeight','demi','FontSize',13)  
        end        
    end
%%%%
    grid on;      
%
hold off;
end