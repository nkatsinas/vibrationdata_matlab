%
%  transfer_from_modes_plots.m  ver 1.1  September 21, 2012
%
function[fig_num]=...
    transfer_from_modes_plots(iu,iam,i,k,fig_num,minf,maxf,ymin,ymax,freq,PPP,PHA)
%
    ymax=10^(ceil(0.1+log10(ymax)));
%
    ymin=10^(floor(log10(ymin)));
%
    if(ymin<ymax*0.0001)
          ymin=ymax*0.0001;
    end
%      
    figure(fig_num);
    fig_num=fig_num+1;
%
    sz=size(freq);
    if(sz(2)>sz(1))
        freq=freq';
    end
%
    sz=size(PPP);
    if(sz(2)>sz(1))
        PPP=PPP';
    end 
%
    plot(freq,PPP);
    grid on;
    xlabel('Frequency(Hz)');
%
    af=[freq PPP]; 
    [xmax,max_freq]=find_max(af);
%
    if(iam==1)
        if(iu==1)
            ylabel('Disp/Force (in/lbf)');
            out1=sprintf('\n maximum = %8.4g (in/lbf) at %8.4g Hz \n',xmax,max_freq);  
        else
            ylabel('Disp/Force (m/N) ');
            out1=sprintf('\n maximum = %8.4g  (m/N) at %8.4g Hz \n',xmax,max_freq);
        end      
    end
%
    if(iam==2)
        if(iu==1)
            ylabel('Vel/Force (in/sec/lbf)');
            out1=sprintf('\n maximum = %8.4g (in/sec/lbf) at %8.4g Hz \n',xmax,max_freq);        
        else
            ylabel('Vel/Force (m/sec/N) ');
            out1=sprintf('\n maximum = %8.4g (m/sec/N) at %8.4g Hz \n',xmax,max_freq); 
        end
    end
%
    if(iam==3)
        if(iu==1)
            ylabel('Accel/Force (G/lbf)');
            out1=sprintf('\n maximum = %8.4g (G/lbf) at %8.4g Hz \n',xmax,max_freq); 
        else
            ylabel('Accel/Force (m/sec^2/N) '); 
            out1=sprintf('\n maximum = %8.4g (m/sec^2/N) at %8.4g Hz \n',xmax,max_freq);        
        end
    end
%
%
    if(iam==4)
        if(iu==1)
            ylabel('Accel/Accel (G/G)');
            out1=sprintf('\n maximum = %8.4g (G/G) at %8.4g Hz \n',xmax,max_freq); 
        else
            ylabel('Accel/Accel [(m/sec^2)/(m/sec^2)] '); 
            out1=sprintf('\n maximum = %8.4g [(m/sec^2)/(m/sec^2)] at %8.4g Hz \n',xmax,max_freq);        
        end
    end
%
%
    if(iam==5)
        if(iu==1)
            ylabel('Force/Disp (lbf/in)');
            out1=sprintf('\n maximum = %8.4g (lbf/in) at %8.4g Hz \n',xmax,max_freq);  
        else
            ylabel('Force/Disp (N/m) ');
            out1=sprintf('\n maximum = %8.4g  (N/m) at %8.4g Hz \n',xmax,max_freq);
        end      
    end
%
    disp(out1);  
%
    out1=sprintf('Transfer Function Magnitude H %d %d',i,k);
    title(out1);
    axis([minf,maxf,ymin,ymax]);
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(freq,PHA);
    out1=sprintf('Transfer Function Phase H %d %d',i,k);
    title(out1);     
    grid on;
    xlabel('Frequency(Hz)');
    ylabel('Phase(deg)');