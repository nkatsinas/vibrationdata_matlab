%
%  quake_srs_synth_phase_0.m  ver 1.0  by Tom Irvine
%
function[fn,a1,a2,b1,b2,b3]=quake_srs_synth_phase_0(fr,damp,dt)

fn(1)=fr(1);
i=2;

maxfr=max(fr);

while(1)
    ff=fn(i-1)*2^(1/12);
    
    if(ff>=maxfr)
        break;
    else
        fn(i)=ff;
    end
    
    i=i+1;
    
end

[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                   srs_coefficients(fn,damp,dt);
