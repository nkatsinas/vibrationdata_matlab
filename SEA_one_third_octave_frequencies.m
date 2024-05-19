%
%  SEA_one_third_octave_frequencies.m  ver 1.1  January 9, 2016
%
function[fl,fc,fu,NL]=SEA_one_third_octave_frequencies()
%
fc(1)=0.02;   % 0.02 Hz needed for ISO 2631 calculation
fc(2)=0.025;  
fc(3)=0.0315;  
fc(4)=0.04;
fc(5)=0.05;
fc(6)=0.063;
fc(7)=0.08;
fc(8)=0.1;
fc(9)=0.125;
fc(10)=0.16;
%
i=1;
while(1)
    fc(i+10)=10*fc(i);
    if(fc(i+10)>=20000)
        break;
    end
    i=i+1;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
while(1)
    if(fc(1)>=20)
        break;
    else
       fc(1)=[]; 
    end
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
imax=length(fc);
%
alpha=2^(1/6);
%
fl=fc/alpha;
%
fu=zeros(imax,1);
%
for i=1:imax-1
    fu(i)=fl(i+1);
end
%
fu(imax)=fc(imax)*alpha;

NL=length(fc);

fc=fix_size(fc);
fl=fix_size(fl);
fu=fix_size(fu);

