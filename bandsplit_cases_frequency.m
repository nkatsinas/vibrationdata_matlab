%
%  bandsplit_cases_frequency.m  ver 1.0  by Tom Irvine
%
function[bpsd,numb]=bandsplit_cases_frequency(f,a,fi,ai,n,ni,df,nb)
%
bpsd=zeros(nb,10,2);
numb=zeros(nb,1);
%

for i=1:ni
    fi(i)=round(10*fi(i))/10;
end


noct=log(fi(end)/fi(1))/log(2);

f1=0;
f2=0;
f3=0;

if(nb==2)
    f1=fi(1)*2^(noct/2);
end
if(nb==3)
    f1=fi(1)*2^(noct/3);
    f2=fi(1)*2^(2*noct/3);    
end
if(nb==4)
    f1=fi(1)*2^(noct/4);
    f2=fi(1)*2^(2*noct/4);   
    f3=fi(1)*2^(3*noct/4);     
end


[~,idx1]=min(abs(f1-fi));
[~,idx2]=min(abs(f2-fi));
[~,idx3]=min(abs(f3-fi));


fg1=fi(idx1);
ag1=ai(idx1);


fg2=fi(idx2);
ag2=ai(idx2);

fg3=fi(idx3);
ag3=ai(idx3);

if(nb==2)
    fg2=fi(end);
    ag2=ai(end);
end
if(nb==3)
    fg3=fi(end);
    ag3=ai(end);
end

fg4=fi(end);
ag4=ai(end);

for p=1:n
    if(f(p)<fg1) 
        bpsd(1,p,1)=f(p);
        bpsd(1,p,2)=a(p);            
    else
        bpsd(1,p,1)=fg1;
        bpsd(1,p,2)=ag1;
        numb(1)=p;
        break;
    end
end


if(nb>=2)

    bpsd(2,1,1)=fg1;
    bpsd(2,1,2)=ag1;    
    
    k=2;
    for p=1:n
       if(f(p)>fg1 && f(p)<fg2)

            bpsd(2,k,1)=f(p);
            bpsd(2,k,2)=a(p);
            numb(2)=k;
            k=k+1;
       end 
       if(f(p)>=fg2)
           bpsd(2,k,1)=fg2;
           bpsd(2,k,2)=ag2;           
           numb(2)=k;
           break;
       end
    end    
    
end

if(nb>=3)

    bpsd(3,1,1)=fg2;
    bpsd(3,1,2)=ag2;    
    
    k=2;
    for p=1:n
       if(f(p)>fg2 && f(p)<fg3) 
            bpsd(3,k,1)=f(p);
            bpsd(3,k,2)=a(p);
            numb(3)=k;
            k=k+1;
       end 
       if(f(p)>=fg3)
           bpsd(3,k,1)=fg3;
           bpsd(3,k,2)=ag3;           
           numb(3)=k;
           break;
       end
    end    
    
    
end

if(nb==4)
    
    bpsd(4,1,1)=fg3;
    bpsd(4,1,2)=ag3;    
    
    k=2;
    for p=1:n
       if(f(p)>fg3 && f(p)<fg4) 
            bpsd(4,k,1)=f(p);
            bpsd(4,k,2)=a(p);
            numb(4)=k;
            k=k+1;
       end 
       if(f(p)>=fg4)
           bpsd(4,k,1)=fg4;
           bpsd(4,k,2)=ag4;           
           numb(4)=k;
           break;
       end
    end    
        
    
end



