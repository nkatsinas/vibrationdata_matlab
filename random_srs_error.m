
%  random_srs_error.m  ver 1.0  by Tom Irvine

function[error,irror]=random_srs_error(spec,xmax,xmin)
%
    nspec=length(spec);

    error=0.;
    irror=0.;
%    
    for i=1:nspec
%
      if(spec(i) < 1.0e-20)
          out1=sprintf('\n spec error. %ld %12.6e \n',i,spec(i));
          disp(out1);
      end
%
      emax=(abs( 20*log10(xmax(i)/spec(i)) ));
      emin=(abs( 20*log10(xmin(i)/spec(i)) ));
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