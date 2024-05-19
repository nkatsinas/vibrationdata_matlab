%   
%    calculate_PSD_slopes.m  ver 2.0  by Tom Irvine
%
%    This script calculates the slopes and overall RMS level for a 
%    power spectral density function (PSD).
%
%    The PSD may have either a constant or variable frequency step.
%
%    The PSD could thus be a specification or measured data.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Input variables:
%
%         f - frequency (Hz)
%         a - amplitude (units^2/Hz)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Output variables:
%
%         s - slope, log-log format
%       rms - overall level
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[s,rms] = calculate_PSD_slopes(f,a)

%
%  Eliminate start frequency < 0.0001 if necessary
%
if(f(1) < 0.0001)
    f(1)=[];
    a(1)=[];
end

%
%  Eliminate coordinates with zero amplitude if necessary
%

np=length(f);

for i=np:-1:1
    if(a(i)==0)
        a(i)=[];
        f(i)=[];
    end
end
   
%
%  nn is the number of slopes and is one less than the total number of
%  coordinates
%
nn=length(f)-1;

s=zeros(nn,1);

%
for  i=1:nn
% 
    if(  f(i+1) < f(i) )
        disp(' frequency error ')
        return;
    end  
%  
%  Calculate slope between adjacent coordinates
%
    if(f(i+1)~=f(i))
        s(i)=log10( a(i+1)/ a(i) )/log10( f(i+1)/f(i) );
    else
        s(i)=NaN;
    end
%   
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Determine whether frequency step is constant
%
ddd=diff(f);
maxd=max(ddd);
mind=min(ddd);
ratio=(maxd-mind)/maxd;

%
% df is average frequency step
%
df=mean(ddd);

if(ratio<0.02 && nn>=10 && df<=10)
%
%  Calculate the rms for case with constant frequency step
%  and at least ten coordinates
%
%    fprintf('\n Constant df = %8.4g Hz \n',df);
    rms=sqrt(sum(a)*df);
else
%    
%  Calculate the rms for variable frequency step 
%
    ra=0;
 
    for i=1:nn
        if(abs(s(i))<1000)
            if(s(i) < -1.0001 ||  s(i) > -0.9999 )
                ra = ra + ( a(i+1) * f(i+1)- a(i)*f(i))/( s(i)+1.);
            else
                ra = ra + a(i)*f(i)*log( f(i+1)/f(i));
            end
        end
    end
    rms=sqrt(ra);
    
end

fprintf('\n\n Overall level = %8.4g RMS \n\n',rms);

