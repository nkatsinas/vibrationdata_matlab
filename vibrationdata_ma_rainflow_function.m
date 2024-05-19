%
% vibrationdata_ma_rainflow_function.m  ver 1.1  March 9, 2015
%
function[peak_cycles,L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak]=...
                                      vibrationdata_ma_rainflow_function(y)

%
m=length(y)-1;
a=zeros(m,1);
t=zeros(m,1);
a(1)=y(1);
t(1)=1;
k=2;
%

slope1=(  y(2)-y(1));
for i=2:m
     slope2=(y(i+1)-y(i));
     if((slope1*slope2)<=0 && abs(slope1) >0.)
          a(k)=y(i);
          t(k)=i;
          k=k+1;
     end
     slope1=slope2;
end
%
a(k)=y(m+1);
t(k)=t(k-1)+1;
k=k+1;
%
%
clear temp;
temp(1:k-1)=a(1:k-1);
clear a;
a=temp;
%
clear temp;
temp(1:k-1)=t(1:k-1);
clear t;
t=temp;
%
clear aa;
sza=size(a);
if(sza(2)>sza(1))
    a=a';
end
szt=size(t);
if(szt(2)>szt(1))
    t=t';
end
%
aa=[t a];
%

%
% num=round(max(a)-min(a))+1;
%

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
clear B;
aamax=0;
B=zeros(m,4);

kv=1;

while(1)
    msa=max(size(aa));
%
    if((j+1)>msa)
        break;
    end
    if((i+1)>=msa)
        break;
    end
%
    Y=(abs(aa(i,2)-aa(i+1,2)));
    X=(abs(aa(j,2)-aa(j+1,2)));
%
    if(X>=Y && Y>0)
        if(i==1)
           B(kv,2)=0.5;
           am=[aa(i,2) aa(i+1,2)];
           B(kv,3)=am(1);
           B(kv,4)=am(2);         
           aa(1,:)=[];
        else 
           B(kv,2)=1;
           am=[aa(i,2) aa(i+1,2)];
           B(kv,3)=am(1);
           B(kv,4)=am(2); 
           aa(i+1,:)=[]; 
           aa(i,:)=[];
        end
        B(kv,1)=Y;
%%        
%%        out1=sprintf(' %8.4g  %8.4g  %8.4g  %8.4g ',B(kv,1),B(kv,2),B(kv,3),B(kv,4));
%%        disp(out1);
%%        
        if(Y>aamax)
     
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

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Count each range that has not been previously counted
%  as one-half cycle.
%
N=max(size(aa));

for i=1:N-1 
    Y=(abs(aa(i,2)-aa(i+1,2)));
%   
    if(Y>0)
        B(kv,1)=Y; 
        B(kv,2)=0.5;
        am=[aa(i,2) aa(i+1,2)];
        B(kv,3)=am(1);
        B(kv,4)=am(2);   
%%        
%%        out1=sprintf('* %8.4g  %8.4g  %8.4g  %8.4g ',B(kv,1),B(kv,2),B(kv,3),B(kv,4));
%%        disp(out1);
%%        
        if(Y>aamax)

         
            aamax=Y;
        end      
        kv=kv+1;
    end
end
%
% amax=max(y)-min(y);
%

%
amax=max(B(:,1));
L(1)=0;
L(2)=2.5;
L(3)=5;
L(4)=10;
L(5)=15;
L(6)=20;
L(7)=30;
L(8)=40;
L(9)=50;
L(10)=60;
L(11)=70;
L(12)=80;
L(13)=90;
L(14)=100;
L=L*amax/100;
%
clear AverageMean;
clear MaxMean;
clear MinMean;
%
clear MaxAmp;
clear AverageAmp;
%
clear MinValley;
clear MaxPeak;
%
num=max(size(L))-1;
C=zeros(num,1);
%
AverageMean=zeros(num,1);
MaxMean=-1.0e+09*ones(num,1);
MinMean= 1.0e+09*ones(num,1);
%
MaxPeak=-1.0e+09*ones(num,1);
MinValley= 1.0e+09*ones(num,1);
%
MaxAmp=zeros(num,1);
AverageAmp=zeros(num,1);


%
kvn=kv-1;
%
clear peak_cycles;
peak_cycles=[B(1:kvn,1) B(1:kvn,2)];

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
for i=1:kvn
     for ijk=1:num
        Y=B(i,1);
        if(Y>=L(ijk) && Y<=L(ijk+1))
            C(ijk)=C(ijk)+B(i,2);
            bm=(B(i,3)+B(i,4))/2;
            if(B(i,3)>MaxPeak(ijk))
                MaxPeak(ijk)=B(i,3);
            end
            if(B(i,4)>MaxPeak(ijk))
                MaxPeak(ijk)=B(i,4);
            end 
            if(B(i,3)<MinValley(ijk))
                MinValley(ijk)=B(i,3);
            end
            if(B(i,4)<MinValley(ijk))
                MinValley(ijk)=B(i,4);
            end              
%            
            AverageAmp(ijk)=AverageAmp(ijk)+B(i,1)*B(i,2);
            AverageMean(ijk)=AverageMean(ijk)+bm*B(i,2);
%
            if( bm > MaxMean(ijk))
                MaxMean(ijk)=bm;
            end
            if( bm < MinMean(ijk))
                MinMean(ijk)=bm;
            end       
%
            if(B(i,1)>MaxAmp(ijk))
               MaxAmp(ijk)=B(i,1);
            end
            break;
        end
    end   
end
for ijk=1:num
    if( C(ijk)>0)
       AverageAmp(ijk)=AverageAmp(ijk)/C(ijk);
       AverageMean(ijk)=AverageMean(ijk)/C(ijk);
    end
end
