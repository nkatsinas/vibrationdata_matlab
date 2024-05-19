%
%   interpolate_PSD.m  ver 1.1    by Tom Irvine
%
function [fi,ai] = interpolate_PSD(f,a,s,df)
%
    if(f(1) < .0001)
        f(1)=[];
        a(1)=[];
    end
%
    m=length(f);
%
%   recalculate slope
%
    for i=1:m-1
        s(i)=log(  a(i+1) / a(i)  )/log( f(i+1) / f(i) );
    end    
%
	fi(1)=f(1);
	ai(1)=a(1);
%
    MAX = 400000;
%   
    for  i=2:MAX 
%       
		fi(i)=fi(i-1)+df; 
%
        if( fi(i) > f(m) )
            fi(i)=[];
            break;
        end 
%
        for j=1:(m-1)
%
			if( ( fi(i) >= f(j) ) && ( fi(i) <= f(j+1) )  )
				ai(i)=a(j)*( ( fi(i) / f(j) )^ s(j) );
				break;
            end
        end
%               
    end
    nn=length(fi);
    ai(nn)=a(m);
    
    fi=fix_size(fi);
    ai=fix_size(ai);