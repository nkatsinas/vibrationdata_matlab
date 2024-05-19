
% bin_sorting_alt.m  ver 1.0  by Tom Irvine

function[BIG,C,peak_cycles,amean,amp_max,amp_min]=bin_sorting_alt(B,~)

%
% amax=max(y)-min(y);
%
% disp(' Begin bin sorting ');
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
kvn=length(B(:,1));
%
clear peak_cycles;
peak_cycles=[B(1:kvn,1) B(1:kvn,2)];
amean=(B(1:kvn,3)+B(1:kvn,4))/2;

amp_max=zeros(kvn,1);
amp_min=zeros(kvn,1);

for i=1:kvn
    amp_max(i)=max([ B(i,3) B(i,4)]);
    amp_min(i)=min([ B(i,3) B(i,4)]);
end

max(amp_max);
min(amp_min);

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

MaxAmp=MaxAmp/2;
AverageAmp=AverageAmp/2;

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
%  disp(' ');
%  disp('  Amplitude = (peak-valley)/2 ');
%  disp(' ');
%  disp('        Range Limits         Cycle      Average     Max      Min     Average   Max   Min     Max ');
%  disp('          (units)            Counts      Amp        Amp      Mean     Mean     Mean  Valley  Peak');
%

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
%          out1=sprintf('\t %7.4g to %7.4g \t %g \t %6.3g \t %6.3g \t %6.3g\t %6.3g\t %6.3g\t %6.3g\t %6.3g',L(j),L(j+1),C(j),AverageAmp(j),MaxAmp(j),MinMean(j),AverageMean(j),MaxMean(j),MinValley(j),MaxPeak(j));
      else
%          out1=sprintf('\t %7.4g to %7.4g \t %g \t %6.3g \t %6.3g \t %6.3g\t %6.3g\t %6.3g\t %6.3g\t %6.3g',L(j),L(j+1),round(C(j)),round(AverageAmp(j)),round(MaxAmp(j)),round(MinMean(j)),round(AverageMean(j)),round(MaxMean(j)),round(MinValley(j)),round(MaxPeak(j)));
      end
%      disp(out1);
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
%out1=sprintf('\n  Max Range=%6.3g ',aamax);
% disp(out1);
%
% TC=sum(C);
% if(rv==2)
%   out1=sprintf('\n Total Cycles =%g \n',TC);
% else
%   out1=sprintf('\n Total Cycles =%g \n',round(TC));   
% end
% disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%