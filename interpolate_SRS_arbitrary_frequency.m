%
%   interpolate_SRS_arbitary_frequency.m  ver 1.1 by Tom Irvine
%
function[fi,ai] = interpolate_SRS_arbitrary_frequency(f,a,new_freq)
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
    s=zeros(m-1,1);

    for i=1:m-1
        s(i)=log(  a(i+1) / a(i)  )/log( f(i+1) / f(i) );
    end    
%
    np = length(new_freq);
%
    fi=zeros(np,1);
    ai=zeros(np,1);
%
    for  i=1:np 
%       
		fi(i)=new_freq(i); 
%
        for j=1:(m-1)
%
            % fprintf(' i=%d j=%d m=%d\n',i,j,m)
            if(fi(i)==f(j))
                ai(i)=a(j);
                break;
            end
            if( ( fi(i) >= f(j) ) && ( fi(i) <= f(j+1) )  )
				ai(i)=a(j)*( ( fi(i) / f(j) )^ s(j) );
				break;
            end
        end
%               
    end
    nn=length(fi);
    ai(nn)=a(m);