function[grms]=env_grms_sam(nbreak,f_sam,apsd_sam)
%
          nbreak=min([length(f_sam) length(apsd_sam)]);

	      ra=0.;

          s=zeros((nbreak-1),1);
%      
	      for( i=1:nbreak-1)
%
			  s(i)=log( apsd_sam(i+1)/apsd_sam(i) )/log( f_sam(i+1)/f_sam(i) );
%
              if(s(i) < -1.0001 ||  s(i) > -0.9999 )
                 ra=ra+ ( apsd_sam(i+1) * f_sam(i+1)- apsd_sam(i)*f_sam(i))/( s(i)+1.);
              else
                 ra=ra+ apsd_sam(i)*f_sam(i)*log( f_sam(i+1)/f_sam(i));
              end
          end
          grms=sqrt(ra);