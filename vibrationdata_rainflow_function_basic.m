%
% vibrationdata_rainflow_function_basic.m  ver 1.2  by Tom Irvine
%
function[range_cycles]=vibrationdata_rainflow_function_basic(y)
%
clear length;
m=length(y)-1;
a=zeros(m,1);
a(1)=y(1);
k=2;
%
slope1=(  y(2)-y(1));
for i=2:m
     slope2=(y(i+1)-y(i));
     if((slope1*slope2)<=0 && abs(slope1)>0)
          a(k)=y(i);
          k=k+1;
     end
     slope1=slope2;
end
%
a(k)=y(m+1);
k=k+1;
%
clear temp;
temp(1:k-1)=a(1:k-1);
clear a;
a=temp;
%
clear aa;
sza=size(a);
if(sza(2)>sza(1))
    a=a';
end

%
% num=round(max(a)-min(a))+1;
%
n=1;
i=1;
j=2;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Rules for this method are as follows: let X denote
%   range under consideration; Y, previous range adjacent to X; and
%   S, starting point in the history.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
progressbar % Create figure and set starting time 
%
clear B;
aamax=0;
B=zeros(m,4);
kv=1;
%
clear length;
aa=a;

orig=length(aa);
%
while(1)
    msa=length(aa);
    progressbar(1-msa/orig) %    
%
    if((j+1)>msa)
        break;
    end
    if((i+1)>=msa)
        break;
    end
%
    Y=(abs(aa(i)-aa(i+1)));
    X=(abs(aa(j)-aa(j+1)));
%
    if(X>=Y && Y>0)
        if(i==1)
           B(kv,2)=0.5;
           am=[aa(i) aa(i+1)];
           B(kv,3)=am(1);
           B(kv,4)=am(2);         
           aa(1,:)=[];
        else 
           B(kv,2)=1;
           am=[aa(i) aa(i+1)];
           B(kv,3)=am(1);
           B(kv,4)=am(2); 
           aa(i+1,:)=[]; 
           aa(i,:)=[];
        end
        B(kv,1)=Y;
%%               
        if(Y>aamax)
            p1=aa(i);
            p2=aa(i+1);        
            aamax=Y;
        end
        kv=kv+1; 
        i=1;
        j=2;        
    else
        i=i+1;
        j=j+1;
    end
%
end
progressbar(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Count each range that has not been previously counted
%  as one-half cycle.
%
N=length(aa);

for i=1:N-1 
    Y=(abs(aa(i)-aa(i+1)));
%   
    if(Y>0)
        B(kv,1)=Y; 
        B(kv,2)=0.5;
        am=[aa(i) aa(i+1)];
        B(kv,3)=am(1);
        B(kv,4)=am(2);   
%%               
        if(Y>aamax)
            p1=aa(i);
            p2=aa(i+1);           
            aamax=Y;
        end      
        kv=kv+1;
    end
end
%
% amax=max(y)-min(y);
%

kvn=kv-1;
%
range_cycles=[B(1:kvn,1) B(1:kvn,2)];
%