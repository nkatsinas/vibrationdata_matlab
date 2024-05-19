function[vrms]=env_vrms_sam(nbreak,f_sam,apsd_sam)
%
           nbreak=min([length(f_sam) length(apsd_sam)]);

           tpi=2*pi;
%
	       ra=0.;
%		   
		   vpsd_sam=zeros(nbreak,1);
%           
           conv=(386.^2.)/(tpi^2.);
%
          vrms=0.;
%
          s=zeros((nbreak-1),1);
%      
		  for(i=1:nbreak)
             vpsd_sam(i)=apsd_sam(i)*conv/(f_sam(i)^2.);
          end
%
	      for( i=1:(nbreak-1))
%
			  s(i)=log( vpsd_sam(i+1)/vpsd_sam(i) )/log( f_sam(i+1)/f_sam(i) );
%
              if(s(i) < -1.0001 ||  s(i) > -0.9999 )
                 ra=ra+ ( vpsd_sam(i+1) * f_sam(i+1)- vpsd_sam(i)*f_sam(i))/( s(i)+1.);
              else
                 ra=ra+ vpsd_sam(i)*f_sam(i)*log( f_sam(i+1)/f_sam(i));
              end
          end
          vrms=sqrt(ra);