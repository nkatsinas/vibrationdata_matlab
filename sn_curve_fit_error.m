%
%   sn_curve_fit_error.m  ver 1.0  by Tom Irvine
%
function[error]=sn_curve_fit_error(num,SN,error,R,P,A,B,C)
%
    for j=1:num
        w=(log10(SN(j,1))-A)/(-B);
        Seq=10^w+C;
        rr=(1-R)^P;
        S_trial=Seq/rr;
        error=error+abs(log10(S_trial/SN(j,2)));
    end    