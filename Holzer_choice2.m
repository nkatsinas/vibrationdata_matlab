%
%  Holzer_choice2.m  ver 1.0  by Tom Irvine
%
function[T,x]=Holzer_choice2(ibc,idisks,j,k,omega)
%
if(ibc == 1)
%
    [T,x]=Holzer_freefree_engine(idisks,j,k,omega);
%	
end
if(ibc == 2)
%
    [T,x]=Holzer_fixedfree_engine(idisks,j,k,omega);
%	
end
if(ibc == 3)
%
    [T,x]=Holzer_fixedfixed_engine(idisks,j,k,omega);    
%
end