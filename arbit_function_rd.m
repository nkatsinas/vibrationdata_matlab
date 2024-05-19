%
%  arbit_function_rd.m  ver 1.0  November 26, 2013
%
function[y_resp]=arbit_function_rd(fn,damp,dt,base)
%
[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);
%
forward=[ rd_b1,  rd_b2,  rd_b3 ];
back   =[  1, -rd_a1, -rd_a2 ];
%
y_resp=filter(forward,back,base);
