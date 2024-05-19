function[jrms]=env_jrms_sam(nbreak,f_sam,apsd_sam)
%
          nbreak=min([length(f_sam) length(apsd_sam)]);

          tpi=2*pi;
          
	      ra=0.;
          
          jpsd_sam=zeros(nbreak,1);
 
          for i=1:nbreak
              jpsd_sam(i)=apsd_sam(i)*tpi*f_sam(i);
          end
          
%      
	      for( i=1:nbreak-1)
%
			  s(i)=log( jpsd_sam(i+1)/jpsd_sam(i) )/log( f_sam(i+1)/f_sam(i) );
%
              if(s(i) < -1.0001 ||  s(i) > -0.9999 )
                 ra=ra+ ( jpsd_sam(i+1) * f_sam(i+1)- jpsd_sam(i)*f_sam(i))/( s(i)+1.);
              else
                 ra=ra+ jpsd_sam(i)*f_sam(i)*log( f_sam(i+1)/f_sam(i));
              end
          end
          jrms=sqrt(ra);