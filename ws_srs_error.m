
%
%   ws_srs_error.m  ver 1.2  by Tom Irvine
%

function[error,irror]=ws_srs_error(spec,xmax,xmin,nspec)
%
    error=0.;
    irror=0.;
%    
    for i=1:nspec
%
      if(spec(i) < 1.0e-20)
          fprintf('\n spec error. %ld %12.6e \n\n',i,spec(i));
      end
%
      emax=(abs( log10(xmax(i)/spec(i)) ));
      emin=(abs( log10(xmin(i)/spec(i)) ));
%
      error=error+emax;
      error=error+emin;
 
      if( emax > irror)
          irror= emax;
      end    
      if( emin > irror)
          irror= emin;
      end    
%
    end