%
%  bandsplit_cases_velox.m  ver 1.0  by Tom Irvine
%
function[bpsd,numb]=bandsplit_cases_velox(f,a,fi,ai,n,ni,df,nb)
%
bpsd=zeros(nb,10,2);
numb=zeros(nb,1);
%

for i=1:ni
    fi(i)=round(10*fi(i))/10;
end


v=zeros(n,1);

for i=1:n
    v(i)=a(i)/(2*pi*f(i))^2;
end

vi=zeros(ni,1);

for i=1:ni
    vi(i)=ai(i)/(2*pi*fi(i))^2;
end

ms=zeros(ni,1);

ms(1)=0.5*df*vi(1);

for i=2:ni-1    
    ms(i)=ms(i-1)+df*vi(i);
end    

ms(ni)=ms(ni-1)+0.5*df*vi(ni-1);
%

g1=0;
g2=0;
g3=0;

if(nb==2)
    g1=ms(end)/2;
end
if(nb==3)
    g1=ms(end)/3;
    g2=2*ms(end)/3;    
end
if(nb==4)
    g1=ms(end)/4;
    g2=2*ms(end)/4;
    g3=3*ms(end)/4;    
end

[~,idx1]=min(abs(g1-ms));
[~,idx2]=min(abs(g2-ms));  
[~,idx3]=min(abs(g3-ms));

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



