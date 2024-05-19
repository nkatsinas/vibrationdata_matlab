
%  ss_plate_frf_core.m  ver 1.0  by Tom Irvine


function[qH,qHv,qHA,omegan]=ss_plate_frf_core(L,W,resp_loc,force_x,force_y,DD,damp,om,nmodes,Amn)

        ijk=1; 
        
        qH=0;
        
        omegan=zeros(nmodes^2,1);
        
        for i=1:nmodes
            for jk=1:nmodes          
            
 %              
                sss_f=Amn*sin(i*force_x*pi/L)*sin(jk*force_y*pi/W);
                sss_r=Amn*sin(i*resp_loc(1)*pi/L)*sin(jk*resp_loc(1)*pi/W);
 %               
                omn=DD*( (i*pi/L)^2 + (jk*pi/W)^2 );
                omegan(ijk)=omn;
                ijk=ijk+1; 
 
                num=sss_f*sss_r;  
                den=(omn^2-om^2)+(1i)*2*damp*om*omn;
                num_den=num/den;
                
                qH=qH+num_den;    
 %
            end
 %
        end
 %
        qHv=(1i)*om*qH;
        qHA=-om^2*qH;    