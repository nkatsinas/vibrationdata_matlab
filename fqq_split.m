
clear a;

a=fq2;

sz=size(a);

n=sz(1);
m=sz(2);

k=1;

varname='';

while(1)
    
    if(a(k,2)==81)
        
        varname=sprintf('fq_%d_%d',a(k,1),a(k,2));
        
        k=k+1;
        
        clear b;
        j=1;
        
        while(a(k,2)~=81)      
            
            
        
            b(j,:)=a(k,:);
            j=j+1;
            
            k=k+1;
            
            if(k>=n)
                break;
            end              
        end
        
        varname
        eval([varname ' = [ b(:,1)  b(:,2)  ];']);
   
    else
        k=k+1;
        
        if(k>=n)
            break;
        end    
    end   
    
   if(k>=n)
       break;
   end
   
end