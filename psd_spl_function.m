
%   psd_spl_function.m  ver 1.0  by Tom Irvine

function[SPL]=psd_spl_function(ref,fi,ai,fl,fc,fu,df)

NL=length(fi);
imax=length(fl);

js=1;

asum=zeros(imax,1);
counts=zeros(imax,1);

for i=1:NL
    
   for j=js:imax
      
       if(fi(i)>=fl(j) && fi(i) <fu(j))
           
            asum(j)=asum(j)+ai(i)*df; 
          counts(j)=counts(j)+1;
           
          js=j; 
          break; 
       end 
   end
end   

k=1;

asum=sqrt(asum);

for i=1:imax
   
    if(counts(i)>=1)        
        SPL(k,1)= fc(i);
        SPL(k,2)= 20*log10(asum(i)/ref);
        k=k+1;
    end
    
end