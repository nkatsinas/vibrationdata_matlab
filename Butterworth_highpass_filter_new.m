
% Butterworth_highpass_filter_new.m  ver 1.0

function[a]=Butterworth_highpass_filter_new(a,sr,fh,order)

Wn=fh/(sr/2);
[bb,aa] = butter(order,Wn,'high');
flag = isstable(bb,aa);
if(flag==1)
    fprintf('\n filter is stable \n');
else
    fprintf('\n filter is unstable \n');            
end        
a=filter(bb,aa,a);