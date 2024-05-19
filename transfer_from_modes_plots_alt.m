%
%  transfer_from_modes_plots.m  ver 1.1  by Tom Irvine
%
function[fig_num]=...
    transfer_from_modes_plots_alt(iu,iam,i,k,fig_num,minf,maxf,ymin,ymax,freq,PPP,PHA)
%
    md=4;

    freq=fix_size(freq);
    PPP=fix_size(PPP);
    PHA=fix_size(PHA);
    
    af=[freq PPP]; 
    [xmax,max_freq]=find_max(af);
%
    if(iam==1)
        if(iu==1)
            ylab='Disp/Force (in/lbf)';
            out1=sprintf('\n maximum = %8.4g (in/lbf) at %8.4g Hz \n',xmax,max_freq);  
        else
            ylab='Disp/Force (m/N) ';
            out1=sprintf('\n maximum = %8.4g  (m/N) at %8.4g Hz \n',xmax,max_freq);
        end      
    end
%
    if(iam==2)
        if(iu==1)
            ylab='Vel/Force ((in/sec)/lbf)';
            out1=sprintf('\n maximum = %8.4g ((in/sec)/lbf) at %8.4g Hz \n',xmax,max_freq);        
        else
            ylab='Vel/Force (m/sec/N) ';
            out1=sprintf('\n maximum = %8.4g ((m/sec)/N) at %8.4g Hz \n',xmax,max_freq); 
        end
    end
%
    if(iam==3)
        if(iu==1)
            ylab='Accel/Force (G/lbf)';
            out1=sprintf('\n maximum = %8.4g (G/lbf) at %8.4g Hz \n',xmax,max_freq); 
        else
            ylab='Accel/Force ((m/sec^2)/N)'; 
            out1=sprintf('\n maximum = %8.4g (m/sec^2/N) at %8.4g Hz \n',xmax,max_freq);        
        end
    end
%%
%
    if(iam==4)
        if(iu==1)
            ylab='Force/Disp (lbf/in)';
            out1=sprintf('\n maximum = %8.4g (lbf/in) at %8.4g Hz \n',xmax,max_freq);  
        else
            ylab='Force/Disp (N/m)';
            out1=sprintf('\n maximum = %8.4g  (N/m) at %8.4g Hz \n',xmax,max_freq);
        end      
    end
%
    if(iam==5)
        if(iu==1)
            ylab='Force/Vel (lbf/(in/sec))';
            out1=sprintf('\n maximum = %8.4g (lbf/(in/sec)) at %8.4g Hz \n',xmax,max_freq);  
        else
            ylab='Force/Vel (N/(m/sec))';
            out1=sprintf('\n maximum = %8.4g  (N/(m/sec)) at %8.4g Hz \n',xmax,max_freq);
        end      
    end
%
    if(iam==6)
        if(iu==1)
            ylab='Force/Accel (lbf/G)';
            out1=sprintf('\n maximum = %8.4g (lbf/G) at %8.4g Hz \n',xmax,max_freq);  
        else
            ylab='Force/Accel (N/(m/sec^2))';
            out1=sprintf('\n maximum = %8.4g  (N/(m/sec^2)) at %8.4g Hz \n',xmax,max_freq);
        end      
    end
%
    if(iam==7)
        if(iu==1)
            ylab='Accel/Accel (G/G)';
            out1=sprintf('\n maximum = %8.4g (G/G) at %8.4g Hz \n',xmax,max_freq); 
        else
            ylab='Accel/Accel [(m/sec^2)/(m/sec^2)]'; 
            out1=sprintf('\n maximum = %8.4g [(m/sec^2)/(m/sec^2)] at %8.4g Hz \n',xmax,max_freq);        
        end
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    disp(out1);      
%
    t_string=sprintf('Transfer Function Magnitude & Phase H %d %d',i,k);
    
    ff=freq;
    FRF_p=PHA;
    FRF_m=PPP;
    fmin=minf;
    fmax=maxf;
    
    [fig_num]=plot_magnitude_phase_function(fig_num,t_string,fmin,fmax,ff,FRF_p,FRF_m,ylab,md);    
