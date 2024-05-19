%
%  DSS_scale_th.m  ver 1.1  October 9, 2012
%
function[sym,acc]=DSS_scale_th(ns,last,acc,amp,sss)
%
amp=amp';
%
for j=1:ns
%	 
    acc(j)= amp(1:last)*sss(1:last,j);
%
end
%
big=max(acc);
small=min(acc);
%
acc(1)=0.;
%
sym = abs(20*log10( big/abs(small)));