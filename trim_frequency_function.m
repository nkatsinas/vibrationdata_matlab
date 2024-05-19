%
%  trim_frequency_function.m  ver 1.0  October 22, 2012
%
function[pf,pv]=trim_frequency_function(fc,sv,fl,fu)
%
imax=length(fc);
%
k=1;
%
for i=1:imax
    if(fc(i)>=fl && fc(i)<=fu)
        pf(k)=fc(i);
        pv(k)=sv(i);
        k=k+1;
    end
end