    
%  arbit_engine_srs_vrs.m  ver 1.0  by Tom Irvine

function[a_resp,a_pos,a_neg,a_rms]=arbit_engine_srs_vrs(a1,a2,b1,b2,b3,yy)

    forward=[ b1,  b2,  b3 ];    
    back   =[  1, -a1, -a2 ];    
%    
    a_resp=filter(forward,back,yy);
    a_pos= abs(max(a_resp));
    a_neg= abs(min(a_resp));
    
    a_resp=fix_size(a_resp);
    a_rms=std(a_resp);