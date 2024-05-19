%
%   quake_srs_function.m  ver 1.0  by Tom Irvine
%
function[error,error_p,lerr,merr,ierr,fm1,fm2]=...
                   quake_srs_function(b1,b2,b3,a1,a2,fn,num,aa,srs_spec_12)

error=0;
lerr=0;
merr=0;
ierr=0;

fm1=min(fn);
fm2=max(fn);
                        
for j=1:num
                                                            
    forward=[ b1(j),  b2(j),  b3(j) ];    
    back   =[     1, -a1(j), -a2(j) ];    
%    
    resp=filter(forward,back,aa);
%
    xmax=max(resp);
    xmin=abs(min(resp));

    e1=(20*log10(xmax/srs_spec_12(j)));
    e2=(20*log10(xmin/srs_spec_12(j)));

    e1a=abs(e1);
    e2a=abs(e2);

%%%                                   
    if(e1a>merr)
        merr=e1a;
        fm1=fn(j);
    end
    if(e2a>merr)
        merr=e2a;
        fm2=fn(j);
    end                
                
%%%                
    if(e1<lerr)
        lerr=e1;
    end
    if(e2<lerr)
        lerr=e2;
    end    
                
    if(abs(e1)>ierr)
        ierr=e1a;
    end
    if(abs(e2)>ierr)
        ierr=e2a;
    end    
    
%%%    

	error=error+e1a;
	error=error+e2a;          
                
end
            
%            error
%            lerr
%            merr
            
%%  error=error+num*(abs(lerr)+abs(merr));
error_p=abs(lerr)+abs(merr);  % leave as plus    