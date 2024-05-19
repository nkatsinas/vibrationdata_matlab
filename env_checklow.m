function[iflag,record]=env_checklow(grms,vrms,drms,grmslow,vrmslow,drmslow,record,goal)
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
	   if( (drms*vrms*grms) < record )
		  record=(drms*vrms*grms);
          iflag=1;
       end
    end
%
	if(goal==4)
	   if( (drms < drmslow) && (grms < grmslow))
          record=(drms*grms); 
		  iflag=1;
       end
    end
%
	if(goal==5)	
	   if( (drms < drmslow))
          record=(drms); 
          iflag=1;
       end
    end