
%  rainflow_stress_damage_nasgro.m  ver 1.0  by Tom Irvine

function[D]=rainflow_stress_damage_nasgro(amp_mean_cycles,A,B,C,P)

sz=size(amp_mean_cycles);

damage=0;

for i=1:sz(1)
    
    stress=amp_mean_cycles(i,1);
    S_mean=amp_mean_cycles(i,2);
    n=amp_mean_cycles(i,3);
    
    Smax=stress+S_mean;
    Smin=S_mean-stress;
    
    R=Smin/Smax;
    
    if(R<-1)
        R=-1;
    end
    
    if(R<=1)

        Seq=Smax*(1-R)^P;
    
        if(Seq>C)
            log_Nf = A - B*log10(Seq - C );
            Nf=10^(log_Nf);
            damage=damage+ n/Nf;               
        end
    
    end
        
end

D=damage;