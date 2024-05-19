    
%   von_Mises_stress_PSD.m  ver 1.0  by Tom Irvine
%
%   Prediction of mechanical fatigue caused by multiple random excitations
%   Bonte, de Boer, Liebregts
%

function[SVM]=von_Mises_stress_PSD(SXX,SYY,SXY,nf)
  
    SVM=zeros(nf,1);

    for k=1:nf
    
        G11=SXX(k);
        G12=sqrt( SXX(k)*SYY(k) );
        G13=sqrt( SXX(k)*SXY(k) );
        
        G21=conj(G12);
        G22=SYY(k);
        G23=sqrt( SYY(k)*SXY(k) );
        
        G31=conj(G13);
        G32=conj(G23);
        G33=SXY(k);
        
        
        Gss=[G11 G12 G13; G21 G22 G23; G31 G32 G33];
        
        AA=[ 1 -0.5 0; -0.5 1 0; 0 0 3];
      
        SVM(k)=abs(trace(AA*Gss));
                
    end  