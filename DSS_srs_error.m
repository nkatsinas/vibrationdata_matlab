function[error,iflag]=DSS_srs_error(last,xmax,xmin,ra,iflag)
%
	error=0.;
    dbmax=0.;
%
	for(i=1:last)	
       if( xmax(i) <=0 || xmin(i) <=0)
           iflag=1;
		   error=1.0e+99;
		   break;
       end
%
	   db=abs(20.*log10(xmin(i)/ra(i)));
%
	    if(db>error)	  
		   error=db;
        end  
%
	   db=abs(20.*log10(xmax(i)/ra(i)));
%
	   if(db>error)
		   error=db;
       end   	    
    end
end