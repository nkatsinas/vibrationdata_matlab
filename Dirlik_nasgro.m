
%   Dirlik_nasgro.m  ver 1.1  by Tom Irvine

function[Dirlik_damage]=Dirlik_nasgro(n,A,B,C,P,R,EP_tau,N,range,dz)

damage=0;

for i=1:n
    
    s=range(i)/2;  % conversion from range to amp
    nc=N(i);
    
    Seq=s*(1-R)^P;
    
    if(Seq>C)
    
        log_Nf = A - B*log10(Seq - C );
    
        Nf=10^(log_Nf);
        
        damage=damage+ nc/Nf;
        
    end
    
end

Dirlik_damage=damage*EP_tau*dz;