    
%  arbit_engine_accel.m  ver 1.1  by Tom Irvine

function[a_resp,a_pos,a_neg]=arbit_engine_accel(a1,a2,b1,b2,b3,yy)
%    
    a_resp=filter([ b1,  b2,  b3 ],[  1, -a1, -a2 ],yy);
    a_pos= max(a_resp);
    a_neg= min(a_resp);