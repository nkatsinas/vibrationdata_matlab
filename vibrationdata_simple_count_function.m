%
% vibrationdata_simple_count_function.m  ver 1.0  Aug 27, 2015
%
function[peak_cycles,amean,BIG]=vibrationdata_simple_count_function(THM,YS,ndf)
%
THM_hold=THM;

sz=size(THM);

if(sz(2)==1)
    y=THM(:,1);  
else
    y=THM(:,2); 
end


clear THM;
%
m=length(y)-1;
aa=zeros(m,1);
tt=zeros(m,1);
aa(1)=y(1);
tt(1)=1;
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
          aa(k)=y(i);         
          tt(k)=i;
          k=k+1;
     end
     slope1=slope2;
end
%
aa(k)=y(m+1);
tt(k)=tt(k-1)+1;

m=k;

a=aa(1:m);
t=tt(1:m);

clear aa;
clear tt;

a=fix_size(a);
t=fix_size(t);


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

m=length(a)-1;

clear B;
aamax=0;
B=zeros(m,4);


B(:,2)=0.5;

for i=1:m
    Y=abs( a(i+1) - a(i)  );
    B(i,1)=Y;    
    B(i,3)=a(1);
    B(i,4)=a(i+1); 
    
    if(Y>aamax)
        aamax=Y;
    end
end

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
kvn=m;
%
clear peak_cycles;
peak_cycles=[B(1:kvn,1) B(1:kvn,2)];
amean=(B(1:kvn,3)+B(1:kvn,4))/2;
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
  disp(' ');
  disp('  Amplitude = (peak-valley)/2 ');
  disp(' ');
  disp('        Range Limits         Cycle      Average     Max      Min     Average   Max   Min     Max ');
  disp('          (units)            Counts      Amp        Amp      Mean     Mean     Mean  Valley  Peak');
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
      disp(out1);
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

if(ndf==1)
    figure(1);
%
    if(sz(2)==2)
        plot(THM_hold(:,1),THM_hold(:,2));
        xlabel('Time (sec)');
    else
        plot(THM_hold(:,1));    
    end
%
    grid on;

    ylabel(YS)
%
    figure(2);
    h=bar(C);
    grid on;
    title('Rainflow');
    ylabel('Cycle Counts');
    xlabel('Range');
%
end  
%