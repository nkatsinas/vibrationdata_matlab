
%  rainflow_function_choice_mean.m  ver 1.0  by Tom Irvine

function[amp_mean_cycles]=rainflow_function_choice_mean(yc,num_eng)
%

if(num_eng==1)

    [range_cycles,amean]=vibrationdata_rainflow_mean_function_basic(yc);    
    amean=fix_size(amean);
    amp_mean_cycles=[range_cycles(:,1)/2 amean range_cycles(:,2)];
    
else
    
%    
    dchoice=-1.; % needs to be double
%
    exponent=1;
% 
    [~,~,~,~,~,~,~,~,~,~,ac1,ac2,amean,cL]...
                                   =rainflow_mean_mex(yc,dchoice,exponent);
%
    sz=size(ac1);
    if(sz(2)>sz(1))
        ac1=ac1';
        ac2=ac2';
    end
%
    ncL=int64(cL);
%
    amean=fix_size(amean);
%
    amp_mean_cycles=[ ac1(1:ncL) amean(1:ncL) ac2(1:ncL) ];   
end       