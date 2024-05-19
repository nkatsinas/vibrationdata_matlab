
%   sdof_response_arbitrary.m   ver 1.0  by Tom Irvine

function[accel,pv,rd]=sdof_response_arbitrary(y,fn,damp,dt,iu)

    try
        [a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                           srs_coefficients(fn,damp,dt);                          
    catch
        warndlg('srs_coefficients failed');
        return;
    end
   
    forward=[ b1,  b2,  b3 ];    
    back   =[  1, -a1, -a2 ];    
    accel=filter(forward,back,y);
          
    forward=[ rd_b1,  rd_b2,  rd_b3 ];    
    back   =[  1, -rd_a1, -rd_a2 ];    
    rd=filter(forward,back,y);

    if(iu==1)
        scale_rd=386;
    else    
        scale_rd=9.81;                
    end

    rd=rd*scale_rd;
    [pv]=differentiate_function(rd,dt);
                