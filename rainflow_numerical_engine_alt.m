%
%  rainflow_numerical_engine_alt.m  ver 1.0  by Tom Irvine
%

function[amp_cycles,amp_mean_cycles,range_cycles_max_min,range_cycles,BIG]=...
                                                 rainflow_numerical_engine_alt(y,YS,ndf,THM)   
                                             
     y=double(y); 


     [c,~,~,~,~] = rainflow(y);

     
     B(:,1)=c(:,2); 
     B(:,2)=c(:,1);
     
     nn=length(c(:,1));
     
     for i=1:nn
        B(i,3)=y(c(i,4));
        B(i,4)=y(c(i,5));      
     end   
        
     aamax=max(c(:,2));

    sz=size(THM); 

    if(ndf==1)
        figure(1);
    %
        if(sz(2)==2)
            plot(THM(:,1),THM(:,2));
            xlabel('Time (sec)');
        else
            plot(THM(:,1));    
        end
    %
        grid on;
    
        ylabel(YS)
    %
    end  

    [BIG,C,range_cycles,amean,amp_max,amp_min]=bin_sorting_alt(B,aamax);
   
    if(ndf==1)
    
        figure(2);
        bar(C);
        grid on;
        title('Rainflow');
        ylabel('Cycle Counts');
        xlabel('Range');
   
    end  
    
    amp_cycles=[range_cycles(:,1)/2 range_cycles(:,2)];
    amean=fix_size(amean);
    amp_mean_cycles=[range_cycles(:,1)/2 amean range_cycles(:,2)];
 
    amax=fix_size(amp_max);
    amin=fix_size(amp_min);
    
    range_cycles_max_min=[range_cycles(:,1) range_cycles(:,2) amax amin ];

    if(ndf==1)

        figure(1);

        sz=size(THM);
        
        if(sz(2)==2)
            plot(THM(:,1),THM(:,2));
            xlabel('Time (sec)');
        else
            plot(THM(:,1));            
        end    
        
        ylabel(YS)
        grid on;
   
        sz=size(BIG);
        N=sz(1);
        
        q=zeros(N,2);
        
        for i=1:N
            xx=(BIG(i,1)+BIG(i,2))/2;      
            q(i,:)=[ xx BIG(i,3)];            
        end
        
        figure(2);
        bar(q(:,1),q(:,2));
        grid on;
        title('Rainflow');
        ylabel('Cycle Counts');
        xlabel('Bin Center Range');
        
        try
           xmax = max(get(gca,'XLim')); 
           xlim([0 xmax]);
        catch   
        end

    end