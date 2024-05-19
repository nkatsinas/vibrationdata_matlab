
%
%  rainflow_numerical_engine.m  ver 1.0  by Tom Irvine
%

function[amp_cycles,amp_mean_cycles,range_cycles_max_min,range_cycles,BIG]=...
                                                 rainflow_numerical_engine(y,YS,ndf,num_eng,THM)   
                                             
y=double(y);                                             

if(num_eng==1)
    [range_cycles,amean,amax,amin,BIG]=vibrationdata_rainflow_mean_max_min_function(y,YS,ndf);    
 
    
    amp_cycles=[range_cycles(:,1)/2 range_cycles(:,2)];
    amean=fix_size(amean);
    amp_mean_cycles=[range_cycles(:,1)/2 amean range_cycles(:,2)];
 
    amax=fix_size(amax);
    amin=fix_size(amin);
    
    range_cycles_max_min=[range_cycles(:,1) range_cycles(:,2) amax amin ];

  
else
%
    disp(' '); 
    disp(' Calculating... ');
    disp(' '); 
  
% 
    [ac1,ac2,B0,B1,B2,B3,~]=rainflow_all_dyn_mex(y);
%
    sz=size(ac1);
    if(sz(2)>sz(1))
        ac1=ac1';
        ac2=ac2';
    end
    
%
    amp_cycles=[ ac1 ac2 ]; 
    
    [amean,amin,amax,BIG]=rainflow_table(B0,B1,B2,B3);
    
    
    amean=fix_size(amean);
    amin=fix_size(amin);
    amax=fix_size(amax);    
%      

    amp_mean_cycles=[ ac1 amean ac2 ];
    range_cycles=[2*amp_cycles(:,1) amp_cycles(:,2)];
    range_cycles_max_min=[2*amp_cycles(:,1) amp_cycles(:,2) amax amin ];    

    clear ac1;
    clear ac2;
    
    BIG = flipud(BIG);
    
%
end

if(ndf==1)
%
        figure(1);
%
        sz=size(THM);
        
        if(sz(2)==2)
            plot(THM(:,1),THM(:,2));
            xlabel('Time (sec)');
        else
            plot(THM(:,1));            
        end    

%        
        ylabel(YS)
        grid on;
%

   
        sz=size(BIG);
        N=sz(1);
        
        q=zeros(N,2);
        
        for i=1:N
            
            xx=(BIG(i,1)+BIG(i,2))/2;
            
            q(i,:)=[ xx BIG(i,3)];            
        
        end
        

        figure(2);
        h=bar(q(:,1),q(:,2));
        grid on;
        title('Rainflow');
        ylabel('Cycle Counts');
        xlabel('Bin Center Range');
        
        try
           xmax = max(get(gca,'XLim')); 
           xlim([0 xmax]); 
        end
%
end