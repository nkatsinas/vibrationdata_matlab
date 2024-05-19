
%  hypersphere.m  ver 1.0  by Tom Irvine

function[ycr,cr,drec]=hypersphere(normal_stress_array,num_eng,A,b,NT)

drec=0;

ss=size(normal_stress_array);

num_rows=ss(1);

nc=ss(2);
num_cols=nc;

if(nc==3 || nc==6)
else
    errordlg(' Column error');
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('  ');
disp(' trial      damage     c coefficients ');
progressbar;

c=zeros(num_cols,1);

for i=1:NT
    
    progressbar(i/NT);
    
    if(i< round(NT/10) || rand()>0.3 )
        c=rand(num_cols,1);
        c=c-0.5;
    else
        for k=1:num_cols
            c(k)=cr(k)*(0.98+0.04*rand());
        end        
    end
    
    c=c/norm(c);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

    yc=zeros(num_rows,1);

    for j=1:num_rows
        for k=1:num_cols
            yc(j)=yc(j)+c(k)*normal_stress_array(j,k);
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%    

    if(num_eng==1)
        [range_cycles,L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak]=...
                                     vibrationdata_ma_rainflow_function(yc);
        amp_cycles=[range_cycles(:,1)/2 range_cycles(:,2)];
    else
%
        dchoice=-1.; % needs to be double
%
        exponent=1;
% 
        [L,C,AverageAmp,MaxAmp,MinMean,AverageMean,MaxMean,MinValley,MaxPeak,D,ac1,ac2,cL]...
                                         =rainflow_mex(yc,dchoice,exponent);
%
        sz=size(ac1);
        if(sz(2)>sz(1))
            ac1=ac1';
            ac2=ac2';
        end
%
        ncL=int64(cL);
%
        amp_cycles=[ ac1(1:ncL) ac2(1:ncL) ];
        range_cycles=[2*amp_cycles(:,1) amp_cycles(:,2)];
%
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
    damage=0;
    
    sz=size(range_cycles);

    for iv=1:sz(1)
        damage=damage+range_cycles(iv,2)*( 0.5*range_cycles(iv,1) )^b;
    end    
    
    damage=damage/A;

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    if(damage>drec)
       cr=c; 
       ycr=yc; 
       
       amp_cycles_r=amp_cycles;
       range_cycles_r=range_cycles;       
       
       drec=damage;
     
       iflag=0;
       
       if(num_cols==3)
            out1=sprintf('    %d    %8.3e   %6.3g %6.3g %6.3g ',i,drec,c(1),c(2),c(3));
            iflag=1;            
       end

       if(num_cols==6)
            out1=sprintf('    %d    %8.3e   %6.3g %6.3g %6.3g %6.3g %6.3g %6.3g ',i,drec,c(1),c(2),c(3),c(4),c(5),c(6));
            iflag=1;            
       end
       
       if(iflag==0)
            out1=sprintf(' %d  %8.4g ',i,drec);                
       end
       
       disp(out1);       
       
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end


pause(0.4);
progressbar(1);