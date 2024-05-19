function[drms]= env_drms_sam(nbreak,f_sam,apsd_sam)
%
           tpi=2*pi;
%           
	       ra=0.;
%
		   dpsd_sam=zeros(nbreak,1);
%
           conv=(386.^2.)/(tpi^4.);
%
          drms=0.;
          s=zeros((nbreak-1),1);
%	
		  for(i=1:nbreak)
             dpsd_sam(i)=apsd_sam(i)*conv/(f_sam(i)^4.);
          end
%
	      for( i=1:(nbreak-1))
		  
			  s(i)=log( dpsd_sam(i+1)/dpsd_sam(i) )/log( f_sam(i+1)/f_sam(i) );

              if(s(i) < -1.0001 ||  s(i) > -0.9999 )
			  
                 ra=ra+ ( dpsd_sam(i+1) * f_sam(i+1)- dpsd_sam(i)*f_sam(i))/( s(i)+1.);

              else
                 ra=ra+ dpsd_sam(i)*f_sam(i)*log( f_sam(i+1)/f_sam(i));

              end

          end
%
          drms=sqrt(ra);