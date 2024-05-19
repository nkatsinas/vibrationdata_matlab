
function[iflag,record]=env_checklow3(jrms,grms,vrms,drms,jrmslow,grmslow,vrmslow,drmslow,record,goal)
%
   iflag=0;
%
    if(goal==1)
       x=(grms*jrms);
       if( x < record )
		  record=x;
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
       x=(drms*vrms*grms*jrms);
       if( x < record )
		  record=x;
          iflag=1;
       end
    end
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