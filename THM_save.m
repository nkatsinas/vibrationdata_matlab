    
% THM_save.m  ver 1.0  by Tom Irvine

function[THM,nrows]=THM_save(THM,name2)
    
    sz=size(THM);
    num=sz(1);
    
    iflag=0;
    
    try
        THM{num+1,:}=name2;
        iflag=1;
    catch
    end
    if(iflag==0)
        try
            THM{num+1,:}=char(name2);
            iflag=1;
        catch
        end
    end
    if(iflag==0)
        try
            THM{num+1}=name2;
            iflag=1;
        catch
        end
    end  
    if(iflag==0)
        try
            THM{num+1}=char(name2);
            iflag=1;
        catch
        end
    end    
    
    if(iflag==0)
        disp('iflag error');
    end
   
    try
        THM=sort(THM);
        THM=unique(THM);
    catch
        disp('no NTHM');   
    end
   
    sz=size(THM);
    
    for i=sz(1):-1:1
        sz=size(char(THM{i,:}));
        if(sz(2)>100)
            THM{i}=[];
        end
    end
    
    
    THM;
    
%    NTHM



    sz=size(THM);
    nrows=sz(1);
    