        for ivn=1:20
            scale=(0.97+0.06*rand());
            aa=raccel*scale;
            
            [error,error_p,lerr,merr]=...
                  quake_srs_function(b1,b2,b3,a1,a2,fn,num,aa,srs_spec_12);            
     
             if( error_p<error_peaks)
                 
                error_peaks=error_p; 
                 
                raccel=aa;
                amp=amp*scale;

                out1=sprintf('%d %10.6g %7.4g %7.4g %6.3g %6.3g %6.3g %6.3g %6.3g scp',...
                              ij,error_max,merr,abs(lerr),x1r(ie),x2r(ie)/tpi,x3r(ie),x4r(ie),scale);
                disp(out1); 
                
             end
                
             if(merr<error_limit && abs(lerr)<error_limit)
                    break;
             end               
              
        end 