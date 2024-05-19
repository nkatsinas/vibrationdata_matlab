%
% vibrationdata_rainflow_mean_max_min_function.m  ver 1.2  by Tom Irvine
%
function[peak_cycles,amean,amp_max,amp_min,BIG]=vibrationdata_rainflow_mean_max_min_function(THM,YS,ndf)
%

sz=size(THM);

if(sz(2)==1)
    y=THM(:,1);  
else
    y=THM(:,2); 
end

%%%

if(license('test','Signal_Toolbox')==0 ||  verLessThan('matlab','9.3'))
    
     [B,aamax]=matlab_direct_rainflow(y);

else
    
     [c,~,~,~,~] = rainflow(y);
     
     B(:,1)=c(:,2); 
     B(:,2)=c(:,1);
     
     nn=length(c(:,1));
     
     for i=1:nn
     
        B(i,3)=y(c(i,4));
        B(i,4)=y(c(i,5));      
     
     end   
        
     aamax=max(c(:,2));

end
    

%%%

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
%

[BIG,C,peak_cycles,amean,amp_max,amp_min]=bin_sorting(B,aamax);


if(ndf==1)
%
    figure(2);
    h=bar(C);
    grid on;
    title('Rainflow');
    ylabel('Cycle Counts');
    xlabel('Range');
%
end  

