    
%  rainflow_table.m  ver 1.2  by Tom Irvine

function[amean,amin,amax,BIG]=...
          rainflow_table(B0,B1,B2,B3)
      

kv=length(B0);

amean=zeros(kv,1);
amax=zeros(kv,1);
amin=zeros(kv,1);

for i=1:kv
	   
    amean(i)=mean([B3(i) B2(i)]);
    amax(i)=max([B3(i) B2(i)]);
    amin(i)=min([B3(i) B2(i)]);
        
end
    
%% start bins

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

NB=length(L);

AverageAmp=zeros(NB,1);
MaxAmp=zeros(NB,1);
AverageMean=zeros(NB,1);
MinValley=zeros(NB,1);
MaxPeak=zeros(NB,1);
MaxMean=zeros(NB,1);
MinMean=zeros(NB,1);
C=zeros(NB,1);

ymax=max(abs(B0));


for ijk=1:NB

    L(ijk)=L(ijk)*ymax/100.;
        
    MaxMean(ijk)=-1.0e+20;
    MinMean(ijk)= 1.0e+20;        

    AverageMean(ijk)=0.;
        
    MaxPeak(ijk)=-1.0e+20;
    MinValley(ijk)= 1.0e+20;

    MaxAmp(ijk)=-1.0e+20;
    AverageAmp(ijk)= 0;

end

for i=1:kv
    
    Y=B0(i);
    
    for ijk=(NB-1):-1:1    
        
            if(Y>=L(ijk) && Y<=L(ijk+1))
            
                bm=(B2(i)+B3(i))/2.;
                
                if( bm > MaxMean(ijk))    
                    MaxMean(ijk)=bm;
                end
                
                if( bm < MinMean(ijk))    
                    MinMean(ijk)=bm;
                end

                C(ijk)=C(ijk)+B1(i);
                AverageMean(ijk)= AverageMean(ijk)+B1(i)*(B3(i)+B2(i))*0.5; % weighted average

                if(B3(i)>MaxPeak(ijk))            
                    MaxPeak(ijk)=B3(i);
                end
                
                if(B2(i)>MaxPeak(ijk))
                    MaxPeak(ijk)=B2(i);
                end

                if(B3(i)<MinValley(ijk))
                    MinValley(ijk)=B3(i);
                end
                
                if(B2(i)<MinValley(ijk))
                    MinValley(ijk)=B2(i);
                end

                if(Y>MaxAmp(ijk))
                    MaxAmp(ijk)=Y;
                end

                AverageAmp(ijk)=AverageAmp(ijk)+B1(i)*Y*0.5;

                break;
            end
    end
end

for i=1:NB
    
    if(C(i)>0)
        
        AverageMean(i)=AverageMean(i)/C(i);
         AverageAmp(i)= AverageAmp(i)/C(i);
    end
    MaxAmp(i)=MaxAmp(i)/2.;

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    ijk=1;
    for i=1:NB-1
      if( abs(L(i))>1.0e-09 && abs(L(i+1))>1.0e-09)
          ijk=ijk+1;
      end
    end
    N=ijk;
%
    BIG=zeros(N,8);
%
%%    MaxAmp=MaxAmp/2;
%%    AverageAmp=AverageAmp/2;
%
    for j=1:N
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
      BIG(j,1)=L(j);
      BIG(j,2)=L(j+1);
      BIG(j,3)=C(j);
      BIG(j,4)=AverageAmp(j);
      BIG(j,5)=MaxAmp(j);
      BIG(j,6)=MinMean(j);
      BIG(j,7)=AverageMean(j);      
      BIG(j,8)=MaxMean(j);
      BIG(j,9)=MinValley(j); 
      BIG(j,10)=MaxPeak(j);   
    end      
