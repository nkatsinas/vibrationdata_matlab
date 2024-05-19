function[iflag,record]=env_checklow2(grms,vrms,drms,grmslow,vrmslow,drmslow,record,goal,apsd_sam)
%
   iflag=0;
%
	if(goal==1)
	   if( (grms < grmslow))
          record=grms;
		  iflag=1;
       end
    end
%
	if(goal==2)	
	   if( (vrms < vrmslow) && (grms < grmslow))
          record=(vrms*grms); 
		  iflag=1;
       end
    end
%
	if(goal==3)
        x=(drms*vrms*grms);
	   if( x < record )
		  record=x;
          iflag=1;
       end
    end
%   
%
	if(goal==4)
	   if( (drms < drmslow))
          record=drms;
		  iflag=1;
       end
    end
	if(goal==5)
       x=(drms*vrms);
	   if( x < record )
		  record=x;
          iflag=1;
       end
    end