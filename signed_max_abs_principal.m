
%  signed_max_abs_principal.m  ver 1.0  by Tom Irvine

function[smap]=signed_max_abs_principal(pstress)

ss=size(pstress);

nc=ss(2);

if(nc==2 || nc==3)
else
    errordlg(' Column error');
    return;
end

[polarity]=signed_stress_polarity(pstress);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mqa=abs(pstress);    
ps=max(mqa,[],2);
    
smap=polarity.*ps;