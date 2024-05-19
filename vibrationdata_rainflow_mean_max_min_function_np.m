%
% vibrationdata_rainflow_mean_max_min_function_np.m  ver 1.1  by Tom Irvine
%
function[peak_cycles,amean,amp_max,amp_min,BIG]=vibrationdata_rainflow_mean_max_min_function_np(THM)
%

sz=size(THM);

if(sz(2)==1)
    y=THM(:,1);  
else
    y=THM(:,2); 
end


clear THM;
%
m=length(y)-1;
a=zeros(m,1);
t=zeros(m,1);
a(1)=y(1);
t(1)=1;
k=2;
%
out1=sprintf(' total input points =%d ',m);
disp(out1)
%
disp(' Begin slope calculation ')
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
disp(' End slope calculation ')
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
cc=a;
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
%% progressbar % Create figure and set starting time 
%
clear B;
aamax=0;
B=zeros(m,4);
kv=1;
msa_orig=max(size(aa));
while(1)
    msa=max(size(aa));
%%    progressbar(1-msa/msa_orig) % Update figure   
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
            p1=aa(i,2);
            p2=aa(i+1,2);
            tp1=aa(i,1);
            tp2=aa(i+1,1);        
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
%% progressbar(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Count each range that has not been previously counted
%  as one-half cycle.
%
N=max(size(aa));
disp(' ');
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
            p1=aa(i,2);
            p2=aa(i+1,2);
            tp1=aa(i,1);
            tp2=aa(i+1,1);           
            aamax=Y;
        end      
        kv=kv+1;
    end
end
%
% amax=max(y)-min(y);
%
disp(' Begin bin sorting ');
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
amean=(B(1:kvn,3)+B(1:kvn,4))/2;


for i=1:kvn
    amp_max(i)=max([ B(i,3) B(i,4)]);
    amp_min(i)=min([ B(i,3) B(i,4)]);
end

%% max(amp_max)
%% min(amp_min)

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% disp(' ');
%%  disp(' Round the cycle and amplitude values to nearest integer ? ');
%%  disp(' 1=yes 2=no');
%%  rv=input(' ');
  rv=2;
%
  clear BIG;
  N=max(size(C));
  BIG=zeros(N,10);
%%  disp(' ');
%%  disp('  Amplitude = (peak-valley)/2 ');
%%  disp(' ');
%%  disp('        Range Limits         Cycle      Average     Max      Min     Average   Max   Min     Max ');
%%  disp('          (units)            Counts      Amp        Amp      Mean     Mean     Mean  Valley  Peak');
%
  MaxAmp=MaxAmp/2;
  AverageAmp=AverageAmp/2;
%
  for i=1:N
      j=N+1-i;
%
      if(C(j)==0)
         AverageAmp(j)=0.;
         MaxAmp(j)=0.;
         MinMean(j)=0.;
         AverageMean(j)=0.;
         MaxMean(j)=0.;
         MinValley(j)=0.;
         MaxPeak(j)=0.; 
      end
%
      if(rv==2)
          out1=sprintf('\t %7.4g to %7.4g \t %g \t %6.3g \t %6.3g \t %6.3g\t %6.3g\t %6.3g\t %6.3g\t %6.3g',L(j),L(j+1),C(j),AverageAmp(j),MaxAmp(j),MinMean(j),AverageMean(j),MaxMean(j),MinValley(j),MaxPeak(j));
      else
          out1=sprintf('\t %7.4g to %7.4g \t %g \t %6.3g \t %6.3g \t %6.3g\t %6.3g\t %6.3g\t %6.3g\t %6.3g',L(j),L(j+1),round(C(j)),round(AverageAmp(j)),round(MaxAmp(j)),round(MinMean(j)),round(AverageMean(j)),round(MaxMean(j)),round(MinValley(j)),round(MaxPeak(j)));
      end
 %%     disp(out1);
      BIG(i,1)=L(j);
      BIG(i,2)=L(j+1);
      BIG(i,3)=C(j);
      BIG(i,4)=AverageAmp(j);
      BIG(i,5)=MaxAmp(j);
      BIG(i,6)=MinMean(j);      
      BIG(i,7)=AverageMean(j);
      BIG(i,8)=MaxMean(j);   
      BIG(i,9)=MinValley(j); 
      BIG(i,10)=MaxPeak(j);   
  end  
%
out1=sprintf('\n  Max Range=%6.3g ',aamax);
disp(out1);
%
TC=sum(C);
if(rv==2)
   out1=sprintf('\n Total Cycles =%g \n',TC);
else
   out1=sprintf('\n Total Cycles =%g \n',round(TC));   
end
disp(out1);
%
