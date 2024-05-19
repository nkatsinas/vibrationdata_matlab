
%  ss_plate_frf_core_alt.m  ver 1.0  by Tom Irvine

function[qH,qHv,qHA]=ss_plate_frf_core_alt(L,W,resp_loc,force_x,force_y,damp,om,Amn,fbig)

    tpi=2*pi;
        
    qH=0;

    N=length(fbig(:,1));
        
    for j=1:N

        i=fbig(j,2);
        jk=fbig(j,3);
                    
        sss_f=Amn*sin(i*force_x*pi/L)*sin(jk*force_y*pi/W);
        sss_r=Amn*sin(i*resp_loc(1)*pi/L)*sin(jk*resp_loc(2)*pi/W);

        omn=tpi*fbig(j,1); 
 
        num=sss_f*sss_r;  

        try
            den=(omn^2-om^2)+(1i)*2*damp(i,jk)*om*omn;
        catch
            fprintf(' ref 1');
        end

        num_den=num/den;
                
        qH=qH+num_den;    

    end
 %
    qHv=(1i)*om*qH;
    qHA=-om^2*qH;    