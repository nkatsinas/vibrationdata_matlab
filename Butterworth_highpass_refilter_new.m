
% Butterworth_highpass_refilter_new.m  ver 1.0

function[a]=Butterworth_highpass_refilter_new(a,sr,fh,order)

Wn=fh/(sr/2);
[bb,aa] = butter(order,Wn,'high');
flag = isstable(bb,aa);
if(flag==1)
    fprintf('\n filter is stable \n');
else
    fprintf('\n filter is unstable \n');            
end        
a=filtfilt(bb,aa,a);