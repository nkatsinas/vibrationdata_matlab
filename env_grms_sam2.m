function[grms,jrms]=env_grms_sam2(nbreak,f_sam,apsd_sam)
%
        nbreak=min([length(f_sam) length(apsd_sam)]);

        ra=0.;
        s=zeros((nbreak-1),1);
%      
        for i=1:(nbreak-1)
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
          
%%%

        jpsd_sam=zeros(nbreak,1);
          
        omega=2*pi*f_sam;
          
        for i=1:nbreak
              jpsd_sam(i)=apsd_sam(i)*omega(i)^2;
        end
          
	    rj=0.;
        s=zeros((nbreak-1),1);
%      
        for i=1:(nbreak-1)
%
			  s(i)=log( jpsd_sam(i+1)/jpsd_sam(i) )/log( f_sam(i+1)/f_sam(i) );
%
              if(s(i) < -1.0001 ||  s(i) > -0.9999 )
                 rj=rj+ ( jpsd_sam(i+1) * f_sam(i+1)- jpsd_sam(i)*f_sam(i))/( s(i)+1.);
              else
                 rj=rj+ jpsd_sam(i)*f_sam(i)*log( f_sam(i+1)/f_sam(i));
              end
        end
        
        jrms=sqrt(rj);