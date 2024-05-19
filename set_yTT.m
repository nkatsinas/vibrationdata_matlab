

% set_yTT.m  ver 1.0  by Tom Irvine


function[yTT,ytt]=set_yTT(ytt)

yTT='';

n=length(ytt);

if(n<=7)
    for i=1:n
        yTT{i}=strtrim(sprintf('%8.4g',ytt(i)));
    end
end 
if(n>=8 && n<=14)

    for i=1:2:n
        yTT{i}=strtrim(sprintf('%8.4g',ytt(i)));
    end
    for i=2:2:n
        yTT{i}='x';
    end    
    
    if(contains(yTT(n),'x'))
        ytt(n+1)=ytt(n)*10;
        yTT{n+1}=strtrim(sprintf('%8.4g',ytt(n+1)));
    end    
    
end 
if(n>=15 && n<=17)

    for i=1:3:n
        yTT{i}=strtrim(sprintf('%8.4g',ytt(i)));
    end
    for i=2:3:n
        yTT{i}='x';
    end   
    for i=3:3:n
        yTT{i}='x';
    end  
    
    if(contains(yTT(n-1),'x') && contains(yTT(n),'x') )   
        ytt(n+1)=ytt(n)*10;
        ytt(n+2)=ytt(n)*100;        
        yTT{n+1}=strtrim(sprintf('%8.4g',ytt(n+1))); 
        yTT{n+2}=strtrim(sprintf('%8.4g',ytt(n+2)));         
    end
end   
if(n>=18)
    
    
    ymin=ytt(1);
    ymax=ytt(n);
    
    for i=-20:5:60
       if(ymin<=10^i)
           ia=i;
           break;
       end
    end    

    
    for i=-20:5:60
       if(ymax<=10^i)
           ib=i;
           break;
       end
    end        
    c=ib-ia+1;
    

    
    try
        ytt=logspace(ia,ib,c);
    catch
        disp(' logspace fail ');
    end

    for i=1:5:c
        yTT{i}=strtrim(sprintf('%8.4g',ytt(i)));
    end
    for i=2:5:c
        yTT{i}='x';
    end   
    for i=3:5:c
        yTT{i}='x';
    end      
    for i=4:5:c
        yTT{i}='x';
    end  
    for i=5:5:c
        yTT{i}='x';
    end  
    
end
yTT=strrep(yTT,'x','');



