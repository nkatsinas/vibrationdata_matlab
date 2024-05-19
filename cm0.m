%
%   cm0.m  ver 1.0  December 6, 2013
%
function[m0,grms]=cm0(apsd,fn,nnn)
%
    ra=0.;
%      
	for i=1:(nnn-1)
%
        s=log( apsd(i+1)/apsd(i) )/log( fn(i+1)/fn(i) );
%
        if(s < -1.0001 ||  s > -0.9999 )
            ra=ra+ ( apsd(i+1) * fn(i+1)- apsd(i)*fn(i))/( s+1.);
        else
            ra=ra+ apsd(i)*fn(i)*log( fn(i+1)/fn(i));
        end
%       
    end
%    
    m0=ra;
    grms=sqrt(ra);