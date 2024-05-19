%
%  quake_srs_synth_phase_2.m  ver 1.0  by Tom Irvine
%
function[fn,rxmax,rxmin]=quake_srs_synth_phase_2(raccel,damp,dt,fr)


num=length(fn);     

rxmax=zeros(num,1);
rxmin=zeros(num,1);
                               
for j=1:num
       
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];    
%    
        resp=filter(forward,back,raccel);
%
        rxmax(j)=max(resp);
        rxmin(j)=abs(min(resp));
end
