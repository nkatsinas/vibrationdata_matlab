
%  rainflow_function_choice_nasgro.m  ver 1.0  by Tom Irvine

function[range_cycles]=rainflow_function_choice_nasgro(yc,num_eng)
%

if(num_eng==1)

    [range_cycles]=vibrationdata_rainflow_function_basic(yc);

else 
    

%    
    dchoice=-1.; % needs to be double
%
    exponent=1;
% 
    [~,~,~,~,~,~,~,~,~,~,ac1,ac2,cL]=rainflow_mex(yc,dchoice,exponent);
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
        
end       